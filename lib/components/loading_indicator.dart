
import 'package:flutter/material.dart';
import 'package:solyticket/constants/color_constant.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Media.screenHeight(context) * 0.030,
      width: Media.screenWidth(context) * 0.065,
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: whiteColor,
          color: primaryColor,
        ),
      ),
    );
  }
}
