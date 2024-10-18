import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/location/repo/location_repo.dart';

class LocationController extends GetxController {
  LocationRepo locationRepo;
  LocationController(this.locationRepo);
  RxList locationList = [
    {
      'title': 'Efes',
      'subTitle': 'Selcuk, izmir, Turkiye',
      'image': 'assets/images/location_img_1.jpg',
    },
    {
      'title': 'AKM',
      'subTitle': 'Taksim, Beyoglu, Istanbul',
      'image': 'assets/images/location_img_2.jpg',
    },
    {
      'title': 'CSO ADA Ankara',
      'subTitle': 'Talatpasa Bulvari, o: 38 Opera, 06330 Altindag/Ankara',
      'image': 'assets/images/location_img_3.jpg',
    },
    {
      'title': 'Topkapi Sarayi',
      'subTitle': 'Cankurtaran, 34122 Fatin/Istanbul',
      'image': 'assets/images/location_img_4.jpg',
    },
    {
      'title': 'California',
      'subTitle': 'United State of America',
      'image': 'assets/images/location_img_5.jpg',
    },
    {
      'title': 'California',
      'subTitle': 'United State of America',
      'image': 'assets/images/location_img_5.jpg',
    },
    {
      'title': 'California',
      'subTitle': 'United State of America',
      'image': 'assets/images/location_img_5.jpg',
    },
    {
      'title': 'California',
      'subTitle': 'United State of America',
      'image': 'assets/images/location_img_5.jpg',
    },
    {
      'title': 'California',
      'subTitle': 'United State of America',
      'image': 'assets/images/location_img_5.jpg',
    },
    {
      'title': 'California',
      'subTitle': 'United State of America',
      'image': 'assets/images/location_img_5.jpg',
    },
  ].obs;
}
