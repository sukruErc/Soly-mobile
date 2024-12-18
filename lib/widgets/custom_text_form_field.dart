import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solyticket/constants/themes.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final bool? readOnly;
  final bool isLabel;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final IconData? suffixIcon2;
  late bool isVisible;
  final String? imagePath;
  final String? Function(String?)? validator;
  final Colors? color;
  final String labelText;
  final TextInputType? inputType;
  final Color? prefixIconColor;
  final void Function()? onTap;
  final int? maxLine;
  final Color? fillerColor;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChange;

  CustomTextFormField({
    super.key,
    this.onTap,
    this.focusNode,
    required this.isLabel,
    this.imagePath,
    this.readOnly,
    this.isVisible = false,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.color,
    this.fillerColor,
    this.maxLine,
    this.controller,
    this.prefixIconColor,
    this.inputType,
    this.suffixIcon2,
    this.inputFormatters,
    this.onChange,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.black),
      maxLines: widget.maxLine,
      focusNode: widget.focusNode,
      readOnly: widget.readOnly ?? false,
      onTap: widget.onTap,
      controller: widget.controller,
      keyboardType: widget.inputType,
      validator: widget.validator,
      obscureText: widget.isVisible,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        labelText: widget.isLabel?widget.labelText:null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: DefaultTheme().textFieldColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: DefaultTheme().textFieldColor),
        ),
        isDense: true,
        hintText: widget.hintText,
        labelStyle: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: DefaultTheme().greyColor, fontSize: 14),
        hintStyle: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: DefaultTheme().greyColor, fontSize: 14),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: widget.prefixIconColor ?? DefaultTheme().greyColor,
              )
            : null,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              widget.isVisible = !widget.isVisible;
            });
          },
          child: Icon(
            widget.isVisible ? widget.suffixIcon2 : widget.suffixIcon,
            color: DefaultTheme().greyColor,
            size: 18,
          ),
        ),
        fillColor: widget.fillerColor ?? DefaultTheme().textFieldColor,
        filled: true,
      ),
    );
  }
}
