import 'dart:convert';
import 'package:get/get.dart';
import 'package:solyticket/model/category_count_json.dart';
import 'package:solyticket/model/event_detail_model.dart';
import 'package:solyticket/model/highlight_event_json.dart';
import 'package:solyticket/model/location_json.dart';
import 'package:solyticket/model/upcoming_event_json.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/repo/customer_home_repo.dart';

class CustomerHomeController extends GetxController {
  CustomerHomeRepo homeRepo;

  var isFromTab = true.obs;

  var hotTicketList = HighlightEventJson(data: []).obs;
  var newlySalesList = HighlightEventJson(data: []).obs;
  var recentEventList = UpcomingEventJson(data: []).obs;
  var solyAdviceList = HighlightEventJson(data: []).obs;
  var highlightedEventList = HighlightEventJson(data: []).obs;

  var locationList = LocationJson(data: []).obs;
  var catCountList = CategoryCountJson(data: []).obs;

  CustomerHomeController(this.homeRepo);

  @override
  void onInit() {
    super.onInit();
    getAllHomeData();
  }

  Future getAllHomeData() async {
    try {
      final results = await Future.wait([
        homeRepo.getHotTickets({}),
        homeRepo.getNewlySales({}),
        homeRepo.getRecentEvents({}),
        homeRepo.getSolyAdvice({}),
        homeRepo.gethighlightedEvent({}),
        homeRepo.getEvents({}),
        homeRepo.getLocations({}),
        homeRepo.getCategoryCount({}),
      ]);

      try {
        var hotTicketResult = json.decode(results[0]!.data);
        if (hotTicketResult["success"] == true) {
          hotTicketList.value = HighlightEventJson.fromJson(hotTicketResult);
        }
      } catch (e) {
        // Handle errors silently
      }

      try {
        var newlySalesResult = json.decode(results[1]!.data);
        if (newlySalesResult["success"] == true) {
          newlySalesList.value = HighlightEventJson.fromJson(newlySalesResult);
        }
      } catch (e) {}

      try {
        var recentEventResult = json.decode(results[2]!.data);
        if (recentEventResult["success"] == true) {
          recentEventList.value = UpcomingEventJson.fromJson(recentEventResult);
        }
      } catch (e) {}

      try {
        var solyAdviceResult = json.decode(results[3]!.data);
        if (solyAdviceResult["success"] == true) {
          solyAdviceList.value = HighlightEventJson.fromJson(solyAdviceResult);
        }
      } catch (e) {}

      try {
        var highlightedEventResult = json.decode(results[4]!.data);

        if (highlightedEventResult["success"] == true) {
          highlightedEventList.value =
              HighlightEventJson.fromJson(highlightedEventResult);
        }
      } catch (e) {}

      try {
        var locationResult = json.decode(results[6]!.data);
        if (locationResult["success"] == true) {
          locationList.value = LocationJson.fromJson(locationResult);
        }
      } catch (e) {}

      try {
        var catCountResult = json.decode(results[7]!.data);
        if (catCountResult["success"] == true) {
          catCountList.value = CategoryCountJson.fromJson(catCountResult);
        }
      } catch (e) {}
    } catch (e) {
      // Handle network or other errors
    }
  }

  List<Map<String, dynamic>> eventDetailList = [
    {
      "eventTitle": "Museum Tour",
      "eventSubTitle": "Tours and cultural experiences",
      "date": "05-10-2024",
      "time": "9:00",
      "location": "Topkapi",
      "image": "assets/images/event_img.jpg",
      "price": "300",
      "organizer": "Danish",
      "memberDate": "27-08-2024"
    },
    {
      "eventTitle": "EduCon 2024",
      "eventSubTitle": "An educational conference",
      "date": "05-10-2024",
      "time": "9:00",
      "location": "Topkapi",
      "image": "assets/images/event_img.jpg",
      "price": "500",
      "organizer": "Alice Johnson",
      "memberDate": "27-08-2024"
    },
  ];

  RxList<EventDetailModel> eventDetailData = <EventDetailModel>[].obs;

  Future getEventDetailDataAll() async {
    try {
      eventDetailData.value = eventDetailList.map((event) {
        return EventDetailModel(
          eventTitle: event['eventTitle'] ?? '',
          eventSubTitle: event['eventSubTitle'] ?? '',
          date: event['date'] ?? '',
          time: event['time'] ?? '',
          location: event['location'] ?? '',
          image: event['image'] ?? '',
          price: event['price'] ?? '',
          organizer: event['organizer'] ?? '',
          memberDate: event['memberDate'] ?? '',
        );
      }).toList();
    } catch (e) {
      // Handle errors silently
    }
  }
}
