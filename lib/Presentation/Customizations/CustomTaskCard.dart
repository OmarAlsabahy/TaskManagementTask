import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_management_system/Domain/Models/projects_response.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomCheckButton.dart';

import '../../Domain/Models/Task.dart';
import 'CustomText.dart';

class CustomTaskCard extends StatelessWidget{
  Task _task;
  double? width , height , borderRadius;
  Function(bool) onChange;
  CustomTaskCard(this._task,{this.width,this.height,this.borderRadius,
  required this.onChange});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius??0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
                spacing: 16.w,
                crossAxisAlignment: .center,
                children: [
                  CustomCheckButton(24.sp, _task.completed, onChange),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      CustomText(
                        text: _task.title,
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                      CustomText(
                        text: _task.description,
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )
                ],
              ),
        ),
        )
    );
  }

}