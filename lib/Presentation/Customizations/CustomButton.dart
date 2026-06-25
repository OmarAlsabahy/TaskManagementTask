import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Widget text;
  double? width, height, borderRadius;
  Color? backgroundColor;
  VoidCallback onPressed;
  CustomButton({
    required this.text,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width??MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: text,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
          ),
        ),
      ),
    );
  }
}
