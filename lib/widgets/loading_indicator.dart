import 'package:flutter/material.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/utills/media.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Media.height() * 0.030,
      width: Media.width() * 0.065,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: DefaultTheme().whiteColor,
          color: DefaultTheme().primaryColor,
        ),
      ),
    );
  }
}
