import 'dart:convert';
import 'package:get/get.dart';
import 'package:solyticket/model/seat_category_json.dart';
import 'package:solyticket/modules/booking_module/repo/booking_repo.dart';

class SeatCategoryController extends GetxController {
  late BookingRepo repo;
  var seatCategories = SeatCategoryJson(data: null).obs;
  var isCgLoading = false.obs;
  var numberOfPerson = Rxn();
  var selectedCategory = Rxn();
  var selectedBlock = Rxn(); // Yeni eklenen blok seçimi için değişken
  var availableBlocks = <dynamic>[].obs; // Blokların listesi
  var eventId = Rxn();

  SeatCategoryController({required this.repo});

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments.isNotEmpty) {
      eventId.value = Get.arguments[0];
    } else {
      throw Exception("Event ID is null or missing in arguments");
    }
    loadSeatCategory();
    super.onInit();
  }

  // Kategorilere bağlı blokları güncelleme metodu
  void updateBlocks(String? categoryId) {
    // Blok seçimini sıfırla
    selectedBlock.value = null;

    if (categoryId == null) {
      availableBlocks.clear();
      return;
    }

    var category = seatCategories.value.data?.categories.firstWhere(
      (cat) => cat.id == categoryId,
      orElse: () => Category(id: '', label: '', block: Block(id: '', label: '')), // Default bir block ekledim
    );

    if (category != null && category.block != null) {
      availableBlocks.value = [category.block];
    } else {
      availableBlocks.clear();
    }
  }

  loadSeatCategory() async {
    try {
      isCgLoading.value = true;
      if (eventId.value == null) {
        throw Exception("Event ID is null");
      }
      Map<String, dynamic> data = {"eventId": eventId.value};
      await repo.getSeatBookingCategory(data).then((response) {
        var result = jsonDecode(response!.data);
        if (result["success"] == true) {
          isCgLoading(false);
          seatCategories.value = SeatCategoryJson.fromJson(result);
        } else {
          isCgLoading(false);
        }
      });
    } catch (e) {
      isCgLoading(false);
      rethrow;
    }
  }

  bool isSelectionComplete() {
    if (eventId.value == null) {
      print("Error: Event ID is null");
      return false;
    }
    if (selectedCategory.value == null) {
      print("Error: Selected category is null");
      return false;
    }
    if (selectedBlock.value == null) {
      print("Error: Selected block is null");
      return false;
    }
    if (numberOfPerson.value == null) {
      print("Error: Number of person is null");
      return false;
    }
    return true;
  }
}
