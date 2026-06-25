import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_management_system/Domain/SharedPrference/SharedPrf.dart';
import 'package:tasks_management_system/Presentation/Styles/AppTheme.dart';

import 'Domain/Di/Di.dart';
import 'Domain/Navigation/AppRouting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();

  final sharedPrf = getIt<SharedPrf>();
  final savedTheme = await sharedPrf.getThemeMode();
  final initialTheme = savedTheme == "light" ? ThemeMode.light : ThemeMode.dark;

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(initialTheme: initialTheme),
    ),
  );
}

class MyApp extends StatefulWidget {
  final ThemeMode initialTheme;
  const MyApp({super.key, required this.initialTheme});

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    themeMode = widget.initialTheme;
  }

  void changeTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          routerConfig: router,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
        );
      }
    );
  }
}
