import 'dart:convert';

import 'package:get/get.dart';
import 'package:solyticket/model/seat_selection_json.dart';
import 'package:solyticket/modules/booking_module/repo/booking_repo.dart';
import 'package:solyticket/utills/global.dart';

class SeatSelectionController extends GetxController {
  final BookingRepo repo;
  var seatList = <Block>[].obs;
  var isLoading = false.obs;
  var finalList = <List<Seat>>[].obs;


  SeatSelectionController({required this.repo});

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    String eventId = args[0];
    String blockId = args[2];
    String categoryId = args[1];
    int selectedPersonCount = int.tryParse(args[3].toString()) ?? 0;
    fetchSeats(blockId, eventId, categoryId);
  }

  Future<void> fetchSeats(
      String blockId, String eventId, String categoryId) async {
    try {
      isLoading.value = true;

      final response = await repo.getSeats({
        'blockId': blockId,
        'eventId': eventId,
        'categoryId': categoryId,
      });

      if (response != null) {
        final result = jsonDecode(response.data);
        if (result['success'] == true) {
          final seatSelection = SeatSelectionJson.fromJson(result);
          if (seatSelection.data != null) {
            seatList.value = [seatSelection.data!];
            processSeats();
          } else {
            Get.snackbar('Hata', 'Oturma düzeni alınamadı.');
          }
        } else {
          Get.snackbar('Hata', result['message'] ?? 'Bir hata oluştu.');
        }
      }
    } catch (e) {
      Get.snackbar('Hata', 'Bir hata oluştu: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void processSeats() {
    finalList.clear();
    for (var block in seatList) {
      if (block.seats != null) {
        List<List<Seat>> blockSeats = [];
        for (var row in block.seats!) {
          blockSeats.add(row);
        }
        finalList.addAll(blockSeats);
      }
    }
  }

void sendToPayment(Set<String> selectedSeatIds) {

  String seatIdsString = selectedSeatIds.join(",");

  Get.toNamed("payment", arguments: [
    Get.arguments[0], 
    seatIdsString,    
    GlobalClass.userId,
  seatList[0].eventName
  ]);
}


  void updateSeatState(
      int row, int col, int selectedPersonCount, Set<String> selectedSeatIds) {
    final seat = finalList[row][col];


    if (seat.status == "available") {
      if (selectedSeatIds.length < selectedPersonCount) {
        seat.status = "selected"; 
        selectedSeatIds.add(seat.id ?? "");
      } else {
        Get.snackbar(
            "Uyarı", "En fazla $selectedPersonCount koltuk seçebilirsiniz.");
      }
    } else if (seat.status == "selected") {

      seat.status = "available";
      selectedSeatIds.remove(seat.id);
    }


    if (seat.status == "reserved") {
      Get.snackbar("Bilgi", "Satılmış bir koltuk seçemezsiniz.");
      return;
    }

    finalList.refresh(); 
  }
}
