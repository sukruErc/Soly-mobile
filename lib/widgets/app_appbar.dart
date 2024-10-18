import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends AppBar {
  final Widget? text;
  final bool isShowBottomLine;
  final bool centerTitle;
  @override
  final Color backgroundColor;
  @override
  final Widget? leading;

  DefaultAppBar(
      {super.key,
      super.actions,
      this.leading,
      this.text,
      this.isShowBottomLine = false,
      this.backgroundColor = Colors.white,
      required this.centerTitle})
      : super(
          centerTitle: centerTitle,
          leading: leading,
          automaticallyImplyLeading: leading != null ? true : false,
          leadingWidth: 70,
          backgroundColor: backgroundColor,
          title: text,
        );
}
