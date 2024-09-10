
import 'package:flutter/material.dart';
import 'package:solyticket/components/loading_indicator.dart';

import '../../constants/color_constant.dart';

class CustomLoaderButton extends StatefulWidget {
  const CustomLoaderButton({
    super.key,
    required this.btnText,
    required this.onTap,
    this.color,
    this.textColor,
    this.fontSize,
    this.weight,
    this.radius,
    this.borderSide,
  });

  final String btnText;
  final Color? textColor;
  final double? radius;
  final Color? borderSide;
  final Future<void> Function() onTap;
  final Color? color;
  final double? fontSize;
  final FontWeight? weight;

  @override
  State<CustomLoaderButton> createState() => _CustomLoaderButtonState();
}

class _CustomLoaderButtonState extends State<CustomLoaderButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color ?? primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 30),
          side: BorderSide(color: widget.borderSide ?? Colors.transparent),
        ),
        minimumSize: Size(MediaQuery.of(context).size.width, 45),
      ),
      onPressed: () async {
        if (mounted) {
          setState(() => loading = true);
        }
        await widget.onTap();
        if (mounted) {
          setState(() => loading = false);
        }
      },
      child: loading
          ? const LoadingIndicator()
          : Text(widget.btnText,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: widget.textColor ?? Colors.white,
                    fontSize: widget.fontSize ?? 15,
                    letterSpacing: 0.9,
                    fontWeight: widget.weight ?? FontWeight.w500,
                  )),
    );
  }
}
