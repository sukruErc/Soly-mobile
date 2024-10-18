import 'package:flutter/material.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/widgets/app_appbar.dart';

class DefaultAppLayout extends StatelessWidget {
  final Widget child;
  final bool isAppBar;
  final bool centerTitle;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  const DefaultAppLayout(
      {super.key, required this.child,this.isAppBar = false,this.action,this.title,this.centerTitle=false,this.leading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.isAppBar ? DefaultAppBar(text: title,actions: action,centerTitle: centerTitle,leading: leading,) : null,
      backgroundColor: DefaultTheme().backgroundColor,
      resizeToAvoidBottomInset: true,
      body: child,
    );
  }
}
