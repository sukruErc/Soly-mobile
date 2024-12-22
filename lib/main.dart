import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/common_bindings/internet_connectivity_binding.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/utills/local_storage.dart';
import 'package:solyticket/utills/routes.dart';

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
      theme: DefaultTheme().base,
      title: 'Solyticket',
      initialRoute: Routes.splash,
      getPages: getPages,
      initialBinding: InternetConnectivityBinding(),
    );
  }
}
