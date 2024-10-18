import 'package:flutter/material.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/widget_formats.dart';

class TitleSubtitleText extends StatelessWidget {
  const TitleSubtitleText({super.key, this.title, this.subtitle});
  final String? title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: textDesigner(
            15,
            DefaultTheme().blackColor,
          ),
        ),
        verticalGap(3),
        Text(
          subtitle!,
          style: textDesigner(20, DefaultTheme().blackColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}