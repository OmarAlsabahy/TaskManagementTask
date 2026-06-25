import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_management_system/Domain/Models/projects_response.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomText.dart';

class CustomProjectCard extends StatelessWidget {
  ProjectsResponse _projectsResponse;
  double? width, height, borderRadius;
  Function(int id) onClick;
  CustomProjectCard(
    this._projectsResponse, {
    this.width,
    this.height,
    this.borderRadius,
    required this.onClick
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick(_projectsResponse.id);
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          color: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 4.h,
              children: [
                CustomText(
                  text: _projectsResponse.name,
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
                CustomText(
                  text: _projectsResponse.description,
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
