import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckButton extends StatelessWidget{
  double size;
  bool isChecked;
  Function(bool) onChange;
  CustomCheckButton(this.size,this.isChecked,this.onChange);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onChange(!isChecked);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle,
        color: isChecked?Theme.of(context).primaryColor:Colors.transparent,
        border: Border.all(color: Theme.of(context).primaryColor,width: 1.sp)),
        child: isChecked?Icon(Icons.check,color: Colors.white,
        size: 11.sp,):SizedBox(),
      ),
    );
  }
}