import 'dart:convert';
import 'package:book_my_seat/book_my_seat.dart';
import 'package:get/get.dart';
import 'package:solyticket/model/seat_selection_json.dart';
import 'package:solyticket/modules/booking_module/repo/booking_repo.dart';

class SeatSelectionController extends GetxController {
  late BookingRepo repo;
  var seatList = SeatSelectionJson(data: []).obs;
  var isLoading = false.obs;
  // var currentSeatStatus = <List<SeatState>>[].obs;
  var finalList = <List<SeatState>>[].obs;
  SeatSelectionController({required this.repo});

  @override
  void onInit() {
    // TODO: implement onInit
    var eventId = Get.arguments[0];
    var catId = Get.arguments[1];
    getSeats(eventId,catId);
    super.onInit();
  }

  getSeats(eventId, catId) async{
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {"eventId": eventId,"categoryId": catId};
      await repo.getSeats(data).then((response) {
        var result = jsonDecode(response!.data);
        if(result["success"]==true){
          isLoading(false);
          seatList.value = SeatSelectionJson.fromJson(result);
          var ab= seatList.value.data![0].seats;
          ab.forEach((val){
            List<SeatState> list = [];
            val.forEach((ac){
              switch (ac) {
                case Seat.AVAILABLE:
                  list.add(SeatState.unselected);
                  break;
                case Seat.EMPTY:
                  list.add(SeatState.empty);
                  print("EMP");
                  break;
                case Seat.RESERVED:
                  list.add(SeatState.sold);
                  break;
              }
            });
            finalList.add(list);
          });
          print(finalList);
        }else{
          isLoading(false);
        }
      });
    } catch (e) {
      isLoading(false);
    }
  }
  @override
  void onClose() {
    finalList.value = <List<SeatState>>[];
    // TODO: implement onClose
    super.onClose();
  }
}
