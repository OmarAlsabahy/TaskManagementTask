import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_management_system/Domain/Di/Di.dart';
import 'package:tasks_management_system/Presentation/Home/Screens/HomeScreen.dart';
import 'package:tasks_management_system/Presentation/Home/StateManagement/Home/HomeCubit.dart';
import 'package:tasks_management_system/Presentation/Profile/Screens/ProfileScreen.dart';
import 'package:tasks_management_system/Presentation/Profile/StateManagement/Profile/ProfileCubit.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: HomeScreen(),
          ),
          BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: ProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).cardColor,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "home".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "profile".tr(),
          ),
        ],
      ),
    );
  }
}
