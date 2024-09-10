import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/utills/local_storage.dart';
import 'package:solyticket/view/auth/profile.dart';
import 'package:solyticket/view/customer/custom_dashboard_view.dart';
import 'package:solyticket/view/customer/events/event_view.dart';
import 'package:solyticket/view/customer/location/location_detail_view.dart';
import 'package:solyticket/view/splash/splash_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashView()),

        GetPage(
            name: '/customerDashboard',
            page: () => const CustomerDashboardView()),
        GetPage(name: '/location', page: () => const LocationDetailView()),
        GetPage(name: '/event', page: () => const EventView()),
       
        GetPage(name: '/profile', page: () => const ProfileView()),
      ],
    );
  }
}
