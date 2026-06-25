import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  TextAlign? textAlign;
  TextDecoration? textDecoration;
  TextStyle? textStyle;
  String? fontFamily;
  CustomText({
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.textDecoration,
    this.textStyle,
    this.fontFamily
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          textStyle ??
          TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: textDecoration,
            fontFamily: fontFamily??Theme.of(context).textTheme.titleMedium?.fontFamily,
          ),
      textAlign: textAlign,
    );
  }
}
