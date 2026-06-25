import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomButton.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomTaskCard.dart';
import 'package:tasks_management_system/Presentation/Customizations/CustomTextField.dart';
import 'package:tasks_management_system/Presentation/Home/StateManagement/Projects/ProjectCubit.dart';
import 'package:tasks_management_system/Presentation/Home/StateManagement/Projects/ProjectStates.dart';

import '../../../Domain/Models/Task.dart';
import '../../../Domain/Models/projects_response.dart';
import '../../Customizations/CustomText.dart';
import '../../Styles/AppColors.dart';

class ProjectDetailsScreen extends StatefulWidget {
  int projectId;
  ProjectDetailsScreen(this.projectId);
  @override
  State<StatefulWidget> createState() => ProjectDetailsState();
}

class ProjectDetailsState extends State<ProjectDetailsScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priorityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          final state = context.read<ProjectCubit>().state;
          if(state is ProjectSuccessState){
            DisplayBottomSheet(
              context,
              state.project,
              _titleController,
              _descriptionController,
              _priorityController,
                (project){
                  context.read<ProjectCubit>().addTask(project);
                }
            );
          }
        },
        child: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
          child: Icon(Icons.add, color: Colors.white, size: 15.sp),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          child: RefreshIndicator(
            onRefresh: () async {
              await context.read<ProjectCubit>().getProjectDetails(widget.projectId);
            },
            child: BlocConsumer<ProjectCubit, ProjectStates>(
              builder: (context, state) {
                if (state is ProjectLoadingState) {
                  return CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
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
                } else if (state is ProjectSuccessState) {
                  return state.project.tasks.isNotEmpty
                  ? ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Task currentTask = state.project.tasks[index];
                        return CustomTaskCard(
                          currentTask,
                          width: MediaQuery.of(context).size.width,
                          borderRadius: 8.r,
                          onChange: (value) {
                            setState(() {
                              currentTask.completed = value;
                              context.read<ProjectCubit>().updateTask(
                                currentTask,
                              );
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, state) {
                        return SizedBox(height: 16.h);
                      },
                      itemCount: state.project.tasks.length,
                    )
                  : CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverFillRemaining(
                          child: Center(
                            child: CustomText(
                              text: "no_tasks".tr(),
                              textStyle: Theme.of(
                                context,
                              ).textTheme.titleLarge?.copyWith(fontSize: 24.sp),
                            ),
                          ),
                        ),
                      ],
                    );
                } else if (state is ProjectErrorState) {
                  return CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
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
                  return const SizedBox();
                }
              },
              listener: (context, state) {
                if (state is ProjectErrorState) {
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<ProjectCubit>().getProjectDetails(widget.projectId);
  }

  void DisplayBottomSheet(
    BuildContext context,
    ProjectsResponse project,
    TextEditingController titleController,
    TextEditingController descriptionController,
    TextEditingController priorityController,
    Function(ProjectsResponse response) addProject,
  ) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: .start,
                spacing: 16.h,
                children: [
                  CustomText(
                    text: "add_task".tr(),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  CustomTextField(
                    hintText: "task_name".tr(),
                    controller: titleController,
                    backgroundColor: Colors.transparent,
                    borderColor: textFieldLightBorderColor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "task_name_error".tr();
                      }
                    },
                  ),
                  CustomTextField(
                    hintText: "description".tr(),
                    controller: descriptionController,
                    backgroundColor: Colors.transparent,
                    borderColor: textFieldLightBorderColor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "description_error".tr();
                      }
                    },
                  ),
                  CustomTextField(
                    hintText: "priority".tr(),
                    controller: priorityController,
                    backgroundColor: Colors.transparent,
                    borderColor: textFieldLightBorderColor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "priority_error".tr();
                      }
                    },
                  ),
                  Spacer(),
                  CustomButton(
                    text: CustomText(
                      text: "add".tr(),
                      textStyle: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                    borderRadius: 8.r,
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        Task task = Task(
                          title: titleController.text,
                          description: descriptionController.text,
                          priority: int.parse(priorityController.text),
                          completed: false,
                          id: null
                        );
                        project.tasks.add(task);
                        addProject(project);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
