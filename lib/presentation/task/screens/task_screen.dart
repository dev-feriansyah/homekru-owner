import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_fab.dart';
import 'package:homekru_owner/core/utils/constants/app_strings.dart';
import 'package:homekru_owner/core/utils/image_constant.dart';
import 'package:homekru_owner/presentation/task/widgets/task_card.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/bottom_sheets/filter_bottom_sheet.dart';
import 'package:homekru_owner/shared/widgets/custom_home_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? currentFilter;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Filter handling methods
  Future<void> _showFilterBottomSheet() async {
    final result = await showFilterBottomSheet(context);
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        currentFilter = result;
      });
      _applyFilter(result);
    }
  }

  void _applyFilter(Map<String, dynamic> filterData) {
    final filterType = filterData['filterType'];
    final subOption = filterData['subOption'];

    String filterMessage = '';
    switch (filterType.toString()) {
      case 'FilterType.helper':
        filterMessage = 'Filtered by Helper: $subOption';
        break;
      case 'FilterType.room':
        filterMessage = 'Filtered by Room: $subOption';
        break;
      case 'FilterType.time':
        filterMessage = 'Filtered by Time: $subOption';
        break;
      case 'FilterType.status':
        filterMessage = 'Filtered by Status: $subOption';
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(filterMessage),
        duration: Duration(seconds: 2),
        backgroundColor: appTheme.primaryColor,
      ),
    );
  }

  // 🔹 Build Method ===================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: CustomAppBar(
        title: 'All Task',
        toolbarHeight: 130.h,
        appHeaderImage: ImageConstant.appHeaderImage,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Container(
            height: 40.h,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: appTheme.blueAccentCustom,
              // borderRadius: BorderRadius.circular(8.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: appTheme.white, width: 1.0),
                ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: appTheme.white,
              unselectedLabelColor: appTheme.mintGreen,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Task'),
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildTaskTab(), _buildUpcomingTab(), _buildCompletedTab()],
      ),
      floatingActionButton: CommonFab(
        onPressed: () {
          AppNavigator.pushNamed(AppRoutes.taskManagement);
        },
      ),
    );
  }

  // All Tasks Tab
  Widget _buildTaskTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              CText(
                'All Tasks',
                size: 18.sp,
                weight: FontWeight.w600,
                color: appTheme.textPrimary,
              ),
              const Spacer(),
              InkWell(
                onTap: _showFilterBottomSheet,
                child: Container(
                  width: 80.w,
                  padding: EdgeInsets.symmetric(vertical: 4.sp),
                  decoration: ShapeDecoration(
                    color: appTheme.white.withValues(alpha: 0.10),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.w,
                        color: appTheme.primaryColor.withValues(alpha: 0.5),
                      ),
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.w,
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: appTheme.primaryColor,
                        size: 14.sp,
                      ),
                      CText(
                        'Filter',
                        size: 14.sp,
                        weight: FontWeight.w500,
                        color: appTheme.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => AppNavigator.pushNamed(AppRoutes.taskDetail),
                  child: TaskCard(
                    title: "Kitchen Cleaning",
                    description: "Clean countertops, floor, and appliances",
                    assignedTo: "Sarah Johnson",
                    time: "10:00 AM",
                    status: _getTaskStatus(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Upcoming Tasks Tab
  Widget _buildUpcomingTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              CText(
                'Upcoming Tasks',
                size: 18.sp,
                weight: FontWeight.w600,
                color: appTheme.textPrimary,
              ),
              const Spacer(),
              InkWell(
                onTap: _showFilterBottomSheet,
                child: Container(
                  width: 80.w,
                  padding: EdgeInsets.symmetric(vertical: 4.sp),
                  decoration: ShapeDecoration(
                    color: appTheme.white.withValues(alpha: 0.10),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.w,
                        color: appTheme.primaryColor.withValues(alpha: 0.5),
                      ),
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.w,
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: appTheme.primaryColor,
                        size: 14.sp,
                      ),
                      CText(
                        'Filter',
                        size: 14.sp,
                        weight: FontWeight.w500,
                        color: appTheme.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return TaskCard(
                  title: "Upcoming Task ${index + 1}",
                  description: "This is an upcoming task description",
                  assignedTo: "John Doe",
                  time: "2:00 PM",
                  status: AppStrings.pending,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Completed Tasks Tab
  Widget _buildCompletedTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              CText(
                'Completed Tasks',
                size: 18.sp,
                weight: FontWeight.w600,
                color: appTheme.textPrimary,
              ),
              const Spacer(),
              InkWell(
                onTap: _showFilterBottomSheet,
                child: Container(
                  width: 80.w,
                  padding: EdgeInsets.symmetric(vertical: 4.sp),
                  decoration: ShapeDecoration(
                    color: appTheme.white.withValues(alpha: 0.10),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.w,
                        color: appTheme.primaryColor.withValues(alpha: 0.5),
                      ),
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.w,
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: appTheme.primaryColor,
                        size: 14.sp,
                      ),
                      CText(
                        'Filter',
                        size: 14.sp,
                        weight: FontWeight.w500,
                        color: appTheme.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return TaskCard(
                  title: "Completed Task ${index + 1}",
                  description: "This task has been completed successfully",
                  assignedTo: "Jane Smith",
                  time: "9:00 AM",
                  status: AppStrings.complete,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getTaskStatus(int index) {
    final statuses = [
      AppStrings.complete,
      AppStrings.pending,
      AppStrings.inProgress,
      AppStrings.complete,
      AppStrings.pending,
    ];
    return statuses[index % statuses.length];
  }
}
