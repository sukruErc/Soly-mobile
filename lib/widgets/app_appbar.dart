import 'package:flutter/material.dart';

class DefaultAppBar extends AppBar {
  final Widget? text;
  final bool isShowBottomLine;
  final bool isCenterTitle;
  final Color brgColor;
  final Widget? leadingWidget;

  DefaultAppBar(
      {super.key,
      super.actions,
      this.leadingWidget,
      this.text,
      this.isShowBottomLine = false,
      this.brgColor = Colors.white,
      required this.isCenterTitle})
      : super(
          centerTitle: isCenterTitle,
          leading: leadingWidget,
          automaticallyImplyLeading: leadingWidget != null ? true : false,
          leadingWidth: 70,
          backgroundColor: brgColor,
          title: text,
        );
}
