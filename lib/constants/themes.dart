import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultTheme {
  // default base theme.
  ThemeData base = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFF4e43f1)),
    textTheme: GoogleFonts.poppinsTextTheme(
      // Theme.of().textTheme,
    ),
    useMaterial3: true,
  );

  // colors define here.
  Color primaryColor = const Color(0XFF4e43f1);
  Color lightPrimarColor = const Color.fromARGB(255, 127, 121, 210);

  Color secondaryColor = const Color(0xFFebe5ff);

  Color doubleTickIconColor = const Color.fromARGB(255, 77, 212, 253);
//const secondaryColor = Color(0XFF131C27);
  Color whiteColor = const Color(0xFFFFFFFF);
  Color textFieldBorderColor = const Color(0xFF1B2736);
  Color textFieldColor = const Color.fromARGB(255, 235, 235, 235);
  Color blackColor = const Color(0XFF2e2e2e);
  Color pureBlack = Colors.black;
  Color backgroundColor = const Color(0xFFF5F5F5);
  Color greenColor = const Color(0xFF8CC63F);
  Color redColor = const Color(0xFF800000);
  Color greyColor = Colors.grey;
  Color fieldTextColor = const Color(0xFF2E2E2E);
  Color redLightColor = const Color(0xFFFA3E47);
  Color purpleColor = const Color(0xFF5653D4);
  Color greenDarkColor = const Color(0xFF08A791);
  Color yellowColor = const Color(0xFFFAA33F);
  Color brownColor = const Color(0xFFB6644F);
  Color pinkColor = const Color(0xFFFB3061);
  Color lightGreyColor = const Color(0xFF848484);
  Color lightBlackColor = const Color(0xFF2E2E2E);
  Color lightBlueColor = const Color(0xFF12C3F5);
  Color transparentColor = Colors.transparent;
  Color disabledButtonColor = const Color(0xFFD9D9D9);
  Color iconColor = const Color(0xFF969797);
  Color trackColor = const Color(0xFFE7E7E7);
  Color black = const Color(0xFF000000);
  Color white = const Color(0xFFffffff);

  // Label text style define here.
  TextStyle labelRegular = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w400);

  TextStyle labelMedium = const TextStyle(
      color: Colors.white,fontWeight: FontWeight.w500);

  TextStyle labelSemiBold = const TextStyle(
      color: Colors.white,fontWeight: FontWeight.w600);

  TextStyle labelBold = const TextStyle(
      color: Colors.white,fontWeight: FontWeight.bold);

  // Textfields style define here
  TextStyle txtFieldRegular = const TextStyle(
      color: Colors.white,fontWeight: FontWeight.w400);

  // Button text style define here.

  TextStyle btnSemiBold = const TextStyle(
      color: Colors.white,fontWeight: FontWeight.w600);
}
