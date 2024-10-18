import 'package:flutter/material.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/widgets/loading_indicator.dart';

class CustomLoaderButton extends StatelessWidget {
   const CustomLoaderButton(
      {super.key,
      required this.btnText,
      required this.onTap,
      this.color,
      this.textColor,
      this.fontSize,
      this.weight,
      this.radius,
      this.borderSide,
      required this.isLoading});

  final String btnText;
  final Color? textColor;
  final double? radius;
  final Color? borderSide;
  final Future<void> Function() onTap;
  final Color? color;
  final double? fontSize;
  final FontWeight? weight;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? DefaultTheme().primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 30),
          side: BorderSide(color: borderSide ?? Colors.transparent),
        ),
        minimumSize: Size(MediaQuery.of(context).size.width, 45),
      ),
      onPressed: () async {
        await onTap();
      },
      child: isLoading
          ? const LoadingIndicator()
          : Text(btnText,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 15,
            letterSpacing: 0.9,
            fontWeight: weight ?? FontWeight.w500,
          ))
    );
  }
}
