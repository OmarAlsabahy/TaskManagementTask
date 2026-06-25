import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_management_system/Domain/Di/Di.dart';
import 'package:tasks_management_system/Domain/Navigation/AppRoutes.dart';
import 'package:tasks_management_system/Domain/SharedPrference/SharedPrf.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomButton.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomText.dart';
import 'package:tasks_management_system/Presentation/Profile/StateManagement/Profile/ProfileCubit.dart';
import 'package:tasks_management_system/Presentation/Profile/StateManagement/Profile/ProfileStates.dart';
import 'package:tasks_management_system/main.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 24.h),
        child: SafeArea(
          child: BlocConsumer<ProfileCubit, ProfileStates>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return Center(
                  child: SizedBox(
                    width: 25.w,
                    height: 25.h,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              } else if (state is ProfileSuccessState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "profile".tr(),
                      textStyle: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(fontSize: 24.sp),
                    ),
                    SizedBox(height: 24.h),
                    _DisplayProfileCard(state),
                    SizedBox(height: 16.h),
                    _buildThemeToggle(context),
                    Spacer(),
                    CustomButton(
                      width: MediaQuery.of(context).size.width,
                      borderRadius: 8.r,
                      text: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: CustomText(
                          text: "log_out".tr(),
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                      onPressed: () async {
                        await context.read<ProfileCubit>().logout();
                        GoRouter.of(context).go(AppRoutes.loginScreen);
                      },
                    ),
                    SizedBox(height: 8.h,)
                  ],
                );
              } else if (state is ProfileErrorState) {
                return Center(
                  child: CustomText(
                    text: state.error,
                    textStyle: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 24.sp),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
            listener: (context, state) {
              if (state is ProfileErrorState) {
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
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final themeMode = MyApp.of(context).themeMode;
    final isDarkMode = themeMode == ThemeMode.dark;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                  color: Theme.of(context).iconTheme.color,
                  size: 24.sp,
                ),
                SizedBox(width: 16.w),
                CustomText(
                  text: isDarkMode ? "dark_mode".tr() : "light_mode".tr(),
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            Switch(
              value: isDarkMode,
              onChanged: (value) async {
                final newMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
                MyApp.of(context).changeTheme(newMode);
                await getIt<SharedPrf>().saveThemeMode(newMode == ThemeMode.dark ? "dark" : "light");
              },
              activeThumbColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _DisplayProfileCard(ProfileSuccessState state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(32.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40.sp,
                backgroundColor: Theme.of(context).primaryColor,
                child: CustomText(
                  text: state.response.username.isNotEmpty
                      ? state.response.username[0].toUpperCase()
                      : "?",
                  textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 32.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            CustomText(
              text: "username".tr(),
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: state.response.username,
              textStyle: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 16.h),
            CustomText(
              text: "email".tr(),
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: state.response.email,
              textStyle: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
