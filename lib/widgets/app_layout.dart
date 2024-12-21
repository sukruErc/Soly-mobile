import 'package:flutter/material.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/widgets/app_appbar.dart';

class DefaultAppLayout extends StatelessWidget {
  final Widget child;
  final bool isAppBar;
  final bool centerTitle;
  final Widget? title;
  final Widget? leading;
  final Color? backgroundColor;
  final List<Widget>? action;
  const DefaultAppLayout(
      {super.key, required this.child,this.isAppBar = false,this.action,this.title,this.centerTitle=false,this.leading,this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBar ? DefaultAppBar(text: title,actions: action,isCenterTitle: centerTitle,leadingWidget: leading,) : null,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      body: child,
    );
  }
}
