import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:solyticket/model/event_detail_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getEventDetailDataAll();
  }

  List<String> list = [
    'Developer',
    'Designer',
    'Consultant',
    'Student',
  ].obs;

  List entertainmentList = [
    {
      'icon': 'assets/images/music.png',
      'title': 'Music',
      'countEvent': '1 Event',
    },
    {
      'icon': 'assets/images/art.png',
      'title': 'Art',
      'countEvent': '10 Event',
    },
    {
      'icon': 'assets/images/family.png',
      'title': 'Family',
      'countEvent': '1 Event',
    },
    {
      'icon': 'assets/images/conference.png',
      'title': 'Conference',
      'countEvent': '1 Event',
    },
  ];

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
      if (kDebugMode) {
        print("Error $e");
      }
    }
  }
}
