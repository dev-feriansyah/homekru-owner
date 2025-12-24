import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/presentation/action_item/widgets/redo_parameters_dialog.dart';
import 'package:homekru_owner/presentation/task/widgets/action_task_card.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class ActionScreen extends StatefulWidget {
  const ActionScreen({super.key});

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Track selected items for bulk actions
  Map<String, Set<int>> selectedItems = {
    'taskProof': <int>{},
    'deadlineExtension': <int>{},
    'leaveRequest': <int>{},
    'requestedItems': <int>{},
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for all action item types
    final List<ActionTask> taskProofItems = [
      ActionTask(
        initials: "MK",
        title: "Kitchen Cleaning",
        subtitle: "Rina uploaded photo proof",
        time: "2 mins ago",
        actionType: ActionType.taskProof,
      ),
      ActionTask(
        initials: "AS",
        title: "Bathroom Cleaning",
        subtitle: "Sarah uploaded photo proof",
        time: "5 mins ago",
        actionType: ActionType.taskProof,
      ),
    ];

    final List<ActionTask> deadlineExtensionItems = [
      ActionTask(
        initials: "RJ",
        title: "Living Room Cleaning",
        subtitle: "Requesting 2 hours extension",
        time: "1 hour ago",
        actionType: ActionType.deadlineExtension,
      ),
      ActionTask(
        initials: "LM",
        title: "Garden Maintenance",
        subtitle: "Need 1 day extension due to weather",
        time: "3 hours ago",
        actionType: ActionType.deadlineExtension,
      ),
    ];

    final List<ActionTask> leaveRequestItems = [
      ActionTask(
        initials: "MJ",
        title: "Personal Leave Request",
        subtitle: "Requesting leave for family emergency",
        time: "Today - 10:15 AM",
        type: "Personal",
        items: "Medical appointment",
        urgency: "Urgent",
        actionType: ActionType.leaveRequest,
      ),
      ActionTask(
        initials: "DK",
        title: "Vacation Leave",
        subtitle: "Planning family vacation",
        time: "Yesterday - 4:30 PM",
        type: "Vacation",
        items: "Family trip",
        urgency: "Standard",
        actionType: ActionType.leaveRequest,
      ),
    ];

    final List<ActionTask> requestedItemsItems = [
      ActionTask(
        initials: "PT",
        title: "Cleaning Supplies Request",
        subtitle: "Need new cleaning materials",
        time: "2 hours ago",
        type: "Supplies",
        items: "Bleach, Gloves, Sponges",
        urgency: "Standard",
        actionType: ActionType.requestedItems,
      ),
      ActionTask(
        initials: "WS",
        title: "Equipment Request",
        subtitle: "Vacuum cleaner needs replacement",
        time: "4 hours ago",
        type: "Equipment",
        items: "Vacuum cleaner, Extension cord",
        urgency: "High",
        actionType: ActionType.requestedItems,
      ),
    ];

    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: CustomCommonAppBar(title: AppStrings.actionitems),
      body: Stack(
        children: [
          bottomWaveWidget(),
          Column(
            children: [
              // Tab Bar
              Container(
                color: appTheme.white,
                child: TabBar(

                  controller: _tabController,
                  indicatorColor: appTheme.primaryColor,
                  labelColor: appTheme.primaryColor,
                  unselectedLabelColor: appTheme.grey,
                  labelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  tabs: [
                    Tab(text: "Task Proof (${taskProofItems.length})"),
                    Tab(
                      text:
                          "Deadline Extension (${deadlineExtensionItems.length})",
                    ),
                    Tab(text: "Leave Request (${leaveRequestItems.length})"),
                    Tab(
                      text: "Requested Items (${requestedItemsItems.length})",
                    ),
                  ],
                ),
              ),
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildActionItemsList(taskProofItems, 'taskProof'),
                    _buildActionItemsList(
                      deadlineExtensionItems,
                      'deadlineExtension',
                    ),
                    _buildActionItemsList(leaveRequestItems, 'leaveRequest'),
                    _buildActionItemsList(
                      requestedItemsItems,
                      'requestedItems',
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Floating Action Button for Mark All as Approved
          Positioned(
            bottom: 20.h,
            right: 20.w,
            left: 20.w,
            child: CustomElevatedButton(
              text: AppStrings.markAllAsApproved,
              onPressed: () => _markAllAsApproved(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItemsList(List<ActionTask> items, String tabKey) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final isSelected = selectedItems[tabKey]!.contains(index);
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          child: Row(
            children: [
              // Checkbox for bulk selection
              // Checkbox(
              //   value: isSelected,
              //   onChanged: (value) {
              //     setState(() {
              //       if (value == true) {
              //         selectedItems[tabKey]!.add(index);
              //       } else {
              //         selectedItems[tabKey]!.remove(index);
              //       }
              //     });
              //   },
              //   activeColor: appTheme.primaryColor,
              // ),
              // Action Task Card
              Expanded(
                child: ActionTaskCard(
                  task: items[index],
                  onApprove: () => _handleApprove(items[index], index, tabKey),
                  onReject: () => _handleReject(items[index]),
                  onViewDetails: () => _handleViewDetails(items[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleApprove(ActionTask task, int index, String tabKey) {
    setState(() {
      // Remove from selected items
      selectedItems[tabKey]!.remove(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CText(
          '${task.title} approved successfully!',
          color: appTheme.darkGreen,
          size: 14.sp,
          weight: FontWeight.w600,
        ),
        backgroundColor: appTheme.mintGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleReject(ActionTask task) {
    redoParametersPopup(context);
  }

  void _handleViewDetails(ActionTask task) {
    AppNavigator.pushNamed(AppRoutes.taskDetail);
  }

  void _markAllAsApproved() {
    final currentTabIndex = _tabController.index;
    final tabKeys = [
      'taskProof',
      'deadlineExtension',
      'leaveRequest',
      'requestedItems',
    ];
    final currentTabKey = tabKeys[currentTabIndex];

    if (selectedItems[currentTabKey]!.isNotEmpty) {
      setState(() {
        selectedItems[currentTabKey]!.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All selected items approved successfully!'),
          backgroundColor: appTheme.mintGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select items to approve'),
          backgroundColor: appTheme.darkRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
