import 'package:flutter/material.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/utills/strings.dart';
import 'package:solyticket/utills/widget_formats.dart';

class SeeAllButton extends StatelessWidget {
  const SeeAllButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStrings.seeAll,
          style: textDesigner(
            15,
            DefaultTheme().primaryColor,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DefaultTheme().secondaryColor,
          ),
          child: const Icon(
            Icons.arrow_forward_ios,
            size: 12,
          ),
        ),
      ],
    );
  }
}
