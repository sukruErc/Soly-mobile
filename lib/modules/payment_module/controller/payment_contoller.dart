import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/model/payment_json.dart';
import 'package:solyticket/modules/payment_module/repo/payment_repo.dart';

class PaymentController extends GetxController {
  final PaymentRepo repo;

  // Observables
  var ticketData = <TicketData>[].obs;
  var isLoading = false.obs;
  var eventId = ''.obs;
  var selectedSeatIds = <String>[].obs;
  var userId = ''.obs;
  var eventName = ''.obs;
  var timer = 600.obs;
  var discount = 0.obs;

  Timer? _countdownTimer;

  PaymentController({required this.repo});

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    eventId.value = args[0];
    userId.value = args[2];
    eventName.value = args[3];

    selectedSeatIds.value = args[1] is String
        ? (args[1] as String).split(',')
        : List<String>.from(args[1]);

    startCountdown();
    fetchTickets(eventId.value, selectedSeatIds, userId.value);
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is disposed
    _countdownTimer?.cancel();
    super.onClose();
  }

  void startCountdown() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.timer.value > 0) {
        this.timer.value--;
      } else {
        timer.cancel();
        handleTimeExpired();
      }
    });
  }

  void handleTimeExpired() {
    // Logic to handle when the timer expires
    Get.snackbar('Rezervasyon Süresi Doldu', 'Lütfen tekrar seçim yapınız.');
    Get.offAndToNamed('seat-category-selection');
  }

  Future<void> fetchTickets(
      String eventId, List<String> seatIds, String userId) async {
    try {
      isLoading.value = true;

      final response = await repo.holdTickets({
        'eventId': eventId,
        'seatIds': seatIds,
        'userId': userId,
      });

      if (response != null) {
        final result = response.data;

        if (result['success'] == true) {
          // Parse the ticket data
          ticketData.value = (result['data'] as List)
              .map((ticket) => TicketData.fromJson(ticket))
              .toList();
        } else {
          Get.snackbar('Hata', result['message'] ?? 'Bir hata oluştu.');
          Get.offAndToNamed('seat-category-selection');
        }
      }
    } catch (e) {
      Get.snackbar('Hata', 'Bir hata oluştu: $e');
      Get.offAndToNamed('seat-category-selection');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> unHold() async {
    try {
      // Extract ticket IDs
      final ticketIds = ticketData.map((ticket) => ticket.id).toList();

      isLoading.value = true;

      final response = await repo.unholdTickets({
        'ticketIds': ticketIds,
      });

      if (response != null) {
        final result = response.data;

        if (result['success'] == true) {
          Get.offAndToNamed('seat-category-selection');
        } else {
          Get.snackbar('Hata', result['message'] ?? 'Bir hata oluştu.');
        }
      }
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Bir hata oluştu: ${e is DioError ? e.response?.data["message"] ?? e.message : e}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> applyCoupon(String couponCode) async {
    if (couponCode.isEmpty) {
      Get.snackbar('Hata', 'Kupon kodu boş olamaz.');
      return;
    }

    try {
      isLoading.value = true;

      final response = await repo.applyCoupon({
        'userId': userId.value,
        'eventId': eventId.value,
        'couponCode': couponCode
      });

      if (response != null) {
        final result = response.data;

        if (result['success'] == true) {
          // Update discount value and notify the user
          discount.value = result['data'];
          Get.snackbar(
            'Başarılı',
            'Kupon kodu başarıyla uygulandı.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar('Hata', result['message'] ?? 'Kupon kodu geçersiz.');
        }
      }
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Bir hata oluştu: ${e is DioError ? e.response?.data["message"] ?? e.message : e}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Helper methods for calculations
  int calculateSubtotal() {
    return ticketData.fold(0, (sum, ticket) => sum + ticket.price);
  }

  int calculateDiscount() {
    final subtotal = calculateSubtotal();
    return (subtotal * discount.value) ~/ 100;
  }

  int calculateTotal() {
    final subtotal = calculateSubtotal();
    const serviceFee = 10;
    final discountAmount = calculateDiscount();
    return subtotal + serviceFee - discountAmount;
  }
}
