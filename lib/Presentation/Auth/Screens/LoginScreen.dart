import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_management_system/Domain/Assets/AppAssets.dart';
import 'package:tasks_management_system/Domain/Navigation/AppRoutes.dart';
import 'package:tasks_management_system/Domain/SharedPrference/SharedPrf.dart';
import 'package:tasks_management_system/Domain/SharedPrference/SharedPrfKeys.dart';
import 'package:tasks_management_system/Presentation/Auth/StateManagement/Auth/Login/LoginCubit.dart';
import 'package:tasks_management_system/Presentation/Auth/StateManagement/Auth/Login/LoginStates.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomButton.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomText.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomTextField.dart';

class LoginScreen extends StatefulWidget {
  SharedPrf sharedPrf;
  LoginScreen({super.key, required this.sharedPrf});
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState(sharedPrf: sharedPrf);
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSecured = true;
  SharedPrf sharedPrf;
  LoginScreenState({required this.sharedPrf});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<LoginCubit, LoginStates>(
            builder: (context, state) {
              if (state is LoginLoadingState) {
                return  Center(
                    child: SizedBox(
                      width: 25.w,
                      height: 25.h,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 16.w,
                      top: 95.h,
                    ),
                    child: Column(
                      children: [
                        DisplayTopSection(MediaQuery.of(context).size.width),
                        DisplayFormSection(
                          _emailController,
                          _passwordController,
                          MediaQuery.of(context).size.width,
                          formKey,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            listener: (context, state) {
              if (state is LoginSuccessState) {
                sharedPrf.save(
                  SharedPrfKeys.accessToken,
                  state.response.accessToken,
                );
                sharedPrf.save(
                  SharedPrfKeys.refreshToken,
                  state.response.refreshToken,
                );
                GoRouter.of(context).pushReplacement(AppRoutes.homeScreen);
              }
              if (state is LoginErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ),
    );
  }

  Widget DisplayTopSection(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssets.logo, width: 644.w, height: 64.h),
        SizedBox(height: 16.h),
        CustomText(
          text: "welcome_back".tr(),
          textStyle: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontSize: 24.sp),
        ),
        SizedBox(height: 8.h),
        CustomText(
          text: "sign_in_subtitle".tr(),
          textStyle: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget DisplayFormSection(
    TextEditingController emailController,
    TextEditingController passwordController,
    double width,
    GlobalKey<FormState> formKey,
  ) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(32.sp),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              CustomText(
                text: "username".tr(),
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.w),
              CustomTextField(
                hintText: "username_hint".tr(),
                controller: emailController,
                width: width,
                prefixIcon: Icon(
                  Icons.person,
                  size: 20.sp,
                  color: Theme.of(context).iconTheme.color,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "username_error".tr();
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: "password".tr(),
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.w),
              CustomTextField(
                hintText: "password".tr(),
                controller: passwordController,
                width: width,
                isSecured: isSecured,
                prefixIcon: Icon(
                  Icons.lock,
                  size: 20.sp,
                  color: Theme.of(context).iconTheme.color,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isSecured = !isSecured;
                    });
                  },
                  icon: Icon(
                    isSecured
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "password_error".tr();
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: "password".tr(),
                    textStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  CustomText(
                    text: "forgot_password".tr(),
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomButton(
                text: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: .center,
                    children: [
                      CustomText(
                        text: "sign_in".tr(),
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                borderRadius: 8.sp,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginCubit>().login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
