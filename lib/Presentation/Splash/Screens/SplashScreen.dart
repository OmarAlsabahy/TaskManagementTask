import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_management_system/Domain/Assets/AppAssets.dart';
import 'package:tasks_management_system/Domain/Navigation/AppRoutes.dart';
import 'package:tasks_management_system/Domain/SharedPrference/SharedPrf.dart';
import 'package:tasks_management_system/Domain/SharedPrference/SharedPrfKeys.dart';

class SplashScreen extends StatefulWidget {
  SharedPrf sharedPrf;
  SplashScreen({super.key, required this.sharedPrf});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  _navigate() async {
    await Future.delayed(Duration(seconds: 2));
    final accessToken = await widget.sharedPrf.get(SharedPrfKeys.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      GoRouter.of(context).pushReplacement(AppRoutes.homeScreen);
    } else {
      GoRouter.of(context).pushReplacement(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          AppAssets.logo,
          width: 200.w,
          height: 200.h,
        ),
      ),
    );
  }
}
