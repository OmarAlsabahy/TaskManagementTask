import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  double? fontSize, width, height, borderRadius;
  Color? backgroundColor, borderColor,textColor;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? isSecured;
  String? Function(String?)? validator;
  CustomTextField({
    required this.hintText,
    required this.controller,
    this.fontSize,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.textColor,
    this.isSecured,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        obscureText: isSecured??false,
        validator: validator,
        style: TextStyle(
          color: textColor ?? Theme.of(context).textTheme.titleMedium?.color,
          fontSize: fontSize ?? Theme.of(context).textTheme.titleMedium?.fontSize,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          hintStyle: TextStyle(
            fontSize:
                fontSize ?? Theme.of(context).textTheme.titleMedium?.fontSize,
            color: (textColor ?? Theme.of(context).textTheme.titleMedium?.color)
                ?.withValues(alpha: 0.5),
            fontWeight: FontWeight.w400,
          ),
          fillColor:
              backgroundColor ??
              Theme.of(context).inputDecorationTheme.fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8.sp)),
            borderSide: BorderSide(
              color:
                  borderColor ??
                  Theme.of(
                    context,
                  ).inputDecorationTheme.border!.borderSide.color,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8.sp)),
            borderSide: BorderSide(
              color:
                  borderColor ??
                  Theme.of(
                    context,
                  ).inputDecorationTheme.enabledBorder!.borderSide.color,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8.sp)),
            borderSide: BorderSide(
              color:
              borderColor ??
                  Theme.of(
                    context,
                  ).inputDecorationTheme.enabledBorder!.borderSide.color,
            ),
          )
        ),
      ),
    );
  }
}
