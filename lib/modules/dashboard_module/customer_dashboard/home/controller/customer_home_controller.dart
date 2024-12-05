import 'dart:convert';
import 'package:get/get.dart';
import 'package:solyticket/model/category_count_json.dart';
import 'package:solyticket/model/event_detail_model.dart';
import 'package:solyticket/model/location_json.dart';
import 'package:solyticket/model/recent_event_json.dart';
import 'package:solyticket/model/upcoming_event_json.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/repo/customer_home_repo.dart';

class CustomerHomeController extends GetxController {
  CustomerHomeRepo homeRepo;
  var isFromTab = true.obs;
  var upcomingEventList = UpcomingEventJson(data: []).obs;
  var recentEventList = RecentEventJson(data: []).obs;
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
        homeRepo.getUpcomingEvents({}),
        homeRepo.getEvents({}),
        homeRepo.getLocations({}),
        homeRepo.getCategoryCount({}),
      ]);
      try {
        var upcomingEventResult = json.decode(results[0]!.data);
        if (upcomingEventResult["success"] == true) {
          upcomingEventList.value =
              UpcomingEventJson.fromJson(upcomingEventResult);
        }
      } catch (e) {
        // do nothing here
      }
      try {
        var recentEventResult = json.decode(results[1]!.data);
        if (recentEventResult["success"] == true) {
          recentEventList.value = RecentEventJson.fromJson(recentEventResult);
        }
      } catch (e) {
        // do nothing here
      }
      try {
        var locationResult = json.decode(results[2]!.data);
        if (locationResult["success"] == true) {
          locationList.value = LocationJson.fromJson(locationResult);
        }
      } catch (e) {
        // do nothing here
      }
      try {
        var catCountResult = json.decode(results[3]!.data);
        if (catCountResult["success"] == true) {
          catCountList.value = CategoryCountJson.fromJson(catCountResult);
        }
      } catch (e) {
        // do nothing here
      }
    } catch (e) {
      // do nothing here
    }
  }

  List<Map<String, dynamic>> eventDetailList = [
    {
      "eventTitle": "Museum Tour",
      "eventSubTitle": "tourrs tour sf",
      "date": "05-10-2024",
      "time": "9:00",
      "location": "Topkapi",
      "image": "assets/images/event_img.jpg",
      "price": "300",
      "organizer": "danish",
      "memberDate": "27-08-2024"
    },
    {
      "eventTitle": "Museum",
      "eventSubTitle": "tourrs tour sf",
      "date": "05-10-2024",
      "time": "9:00",
      "location": "Topkapi",
      "image": "assets/images/event_img.jpg",
      "price": "250",
      "organizer": "danish",
      "memberDate": "27-08-2024"
    },
    {
      "eventTitle": "Motorsports Maina",
      "eventSubTitle": "An educational conference",
      "date": "05-09-2024",
      "time": "12:00",
      "location": "Topkapi",
      "image": "assets/images/event_img.jpg",
      "price": "500",
      "organizer": "Alice Johnson",
      "memberDate": "27-08-2024"
    },
    {
      "eventTitle": "Digital Art Showcase",
      "eventSubTitle": "An educational conference",
      "date": "20-10-2024",
      "time": "10:00",
      "location": "Topkapi",
      "image": "assets/images/event_img.jpg",
      "price": "250",
      "organizer": "Alice Johnson",
      "memberDate": "27-08-2024"
    },
    {
      "eventTitle": "Charity Run",
      "eventSubTitle": "An educational conference",
      "date": "05-11-2024",
      "time": "09:00",
      "location": "Topkapi",
      "image": "assets/images/event_img.jpg",
      "price": "500",
      "organizer": "Alice Johnson",
      "memberDate": "30-08-2024"
    },
    {
      "eventTitle": "Dance Spectacular",
      "eventSubTitle": "An educational conference",
      "date": "05-10-2024",
      "time": "9:00",
      "location": "Topkapi",
      "image": "assets/images/event_img.jpg",
      "price": "500",
      "organizer": "Alice Johnson",
      "memberDate": "15-07-2024"
    },
    {
      "eventTitle": "Cultural Fest",
      "eventSubTitle": "An educational conference",
      "date": "05-12-2024",
      "time": "11:00",
      "location": "Topkapi",
      "image": "assets/images/event_img.jpg",
      "price": "500",
      "organizer": "Alice Johnson",
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
      // if (kDebugMode) {
      //   print("Error $e");
      // }
    }
  }

// RxList locationList = [
//   {
//     'title': 'Efes',
//     'subTitle': 'Selcuk, izmir, Turkiye',
//     'image': 'assets/images/location_img_1.jpg',
//   },
//   {
//     'title': 'AKM',
//     'subTitle': 'Taksim, Beyoglu, Istanbul',
//     'image': 'assets/images/location_img_2.jpg',
//   },
//   {
//     'title': 'CSO ADA Ankara',
//     'subTitle': 'Talatpasa Bulvari, o: 38 Opera, 06330 Altindag/Ankara',
//     'image': 'assets/images/location_img_3.jpg',
//   },
//   {
//     'title': 'Topkapi Sarayi',
//     'subTitle': 'Cankurtaran, 34122 Fatin/Istanbul',
//     'image': 'assets/images/location_img_4.jpg',
//   },
//   {
//     'title': 'California',
//     'subTitle': 'United State of America',
//     'image': 'assets/images/location_img_5.jpg',
//   },
//   {
//     'title': 'California',
//     'subTitle': 'United State of America',
//     'image': 'assets/images/location_img_5.jpg',
//   },
//   {
//     'title': 'California',
//     'subTitle': 'United State of America',
//     'image': 'assets/images/location_img_5.jpg',
//   },
//   {
//     'title': 'California',
//     'subTitle': 'United State of America',
//     'image': 'assets/images/location_img_5.jpg',
//   },
//   {
//     'title': 'California',
//     'subTitle': 'United State of America',
//     'image': 'assets/images/location_img_5.jpg',
//   },
//   {
//     'title': 'California',
//     'subTitle': 'United State of America',
//     'image': 'assets/images/location_img_5.jpg',
//   },
// ].obs;
}
