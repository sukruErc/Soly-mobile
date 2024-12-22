import 'package:flutter/material.dart';
import 'package:solyticket/constants/themes.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultTheme().backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.logoGif,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class AppImages {
  static const String logo = 'assets/images/logo.png';
  static const String logoGif = 'assets/gif/splash.gif';
}
