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
  var eventId = Rxn();

  SeatCategoryController({required this.repo});

  @override
  void onInit() {
    // TODO: implement onInit
    eventId.value = Get.arguments[0];
    loadSeatCategory();
    super.onInit();
  }

  loadSeatCategory() async {
    try {
      isCgLoading.value = true;
      Map<String, dynamic> data = {"eventId": eventId};
      await repo.getSeatBookingCategory(data).then((response) {
        var result = jsonDecode(response!.data);
        if(result["success"]==true){
          isCgLoading(false);
          seatCategories.value = SeatCategoryJson.fromJson(result);
        }else{
          isCgLoading(false);
        }
      });
    } catch (e) {
      isCgLoading(false);
    }
  }
}
