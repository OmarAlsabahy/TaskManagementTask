import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_management_system/Domain/Navigation/AppRoutes.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomProjectCard.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomText.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomTextField.dart';
import 'package:tasks_management_system/Presentation/Home/StateManagement/Home/HomeCubit.dart';
import 'package:tasks_management_system/Presentation/Home/StateManagement/Home/HomeStates.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getProjects();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 24.h),
        child: SafeArea(
          child: RefreshIndicator(
            child: BlocConsumer<HomeCubit, HomeStates>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: SizedBox(
                            width: 25.w,
                            height: 25.h,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is HomeSuccessState) {
                  if (state.projects.isNotEmpty) {
                    final filteredProjects = state.projects.where((project) {
                      final query = _searchQuery.toLowerCase();
                      return project.name.toLowerCase().contains(query) ||
                          project.description.toLowerCase().contains(query);
                    }).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "your_projects".tr(),
                          textStyle: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontSize: 24.sp),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          hintText: "search".tr(),
                          controller: _searchController,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 18.sp,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Expanded(
                          child: filteredProjects.isNotEmpty
                              ? ListView.separated(
                                  itemBuilder: (context, index) {
                                    return CustomProjectCard(
                                      filteredProjects[index],
                                      width: MediaQuery.of(context).size.width,
                                      borderRadius: 8.sp,
                                      onClick: (id) {
                                        GoRouter.of(context).push(
                                          AppRoutes.projectDetailsScreen,
                                          extra: id,
                                        );
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 16.h);
                                  },
                                  itemCount: filteredProjects.length,
                                )
                              : Center(
                                  child: CustomText(
                                    text: "no_matching_projects".tr(),
                                    textStyle: Theme.of(
                                      context,
                                    ).textTheme.titleLarge?.copyWith(fontSize: 20.sp),
                                  ),
                                ),
                        ),
                      ],
                    );
                  } else {
                    return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: CustomText(
                              text: "no_projects".tr(),
                              textStyle: Theme.of(
                                context,
                              ).textTheme.titleLarge?.copyWith(fontSize: 24.sp),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                } else if (state is HomeErrorState) {
                  return CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CustomText(
                            text: state.error,
                            textStyle: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(fontSize: 24.sp),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
              listener: (context, state) {
                if (state is HomeErrorState) {
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
            onRefresh: () async {
              await context.read<HomeCubit>().getProjects();
            },
          ),
        ),
      ),
    );
  }
}
