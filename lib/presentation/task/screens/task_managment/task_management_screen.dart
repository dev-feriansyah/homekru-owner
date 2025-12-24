import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/presentation/task/screens/task_managment/create_from_scratch_screen.dart';
import 'package:homekru_owner/presentation/task/screens/task_managment/suggeste_tasks_screen.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/presentation/task/provider/task_management_provider.dart';
import 'package:provider/provider.dart';

class TaskManagementScreen extends StatefulWidget {
  const TaskManagementScreen({super.key});

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskManagementProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: appTheme.white,
          appBar: CustomCommonAppBar(
            title: 'Task Management',
            backgroundColor: appTheme.white,
          ),
          body:
          // provider.isLoading
          //     ? const Center(child: CircularProgressIndicator())
          //     :
          Container(
            color: appTheme.lightBlue,
            child: Column(
              children: [
                Container(
                  height: 30.h,
                  // margin: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: appTheme.white,
                    // borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: appTheme.blueAccentCustom,
                          width: 1.0,
                        ),
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: appTheme.blueAccentCustom,
                    unselectedLabelColor: appTheme.greyAA,
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: const [
                      Tab(text: 'Suggested Tasks'),
                      Tab(text: 'Create From Scratch'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SuggestedTasksScreen(provider: provider),
                      CreateFromScratchScreen(provider: provider),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
