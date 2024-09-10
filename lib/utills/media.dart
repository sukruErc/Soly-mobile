import 'package:flutter/material.dart';

class Media {
  static MediaQueryData getMediaQuery(BuildContext context) {
    return MediaQuery.of(context);
  }

  static double screenHeight(BuildContext context) {
    return getMediaQuery(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return getMediaQuery(context).size.width;
  }
  
}
