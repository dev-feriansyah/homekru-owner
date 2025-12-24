import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/core/utils/size_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class ActionTaskCard extends StatelessWidget {
  final ActionTask task;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final VoidCallback? onViewDetails;

  const ActionTaskCard({
    super.key,
    required this.task,
    this.onApprove,
    this.onReject,
    this.onViewDetails,
  });

  bool get hasExtraInfo =>
      task.type.isNotEmpty || task.items.isNotEmpty || task.urgency.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      width: SizeUtils.width,
      decoration: BoxDecoration(
        color: appTheme.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: appTheme.offWhite),
        boxShadow: [
          BoxShadow(
            color: appTheme.primaryColor.withValues(alpha: 0.08),
            blurRadius: 50.r,
            offset: Offset(10.w, 20.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Avatar with initials
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: appTheme.lightBlueTwo,
                    shape: BoxShape.circle,
                  ),
                  child: CText(
                    task.initials,
                    color: appTheme.primaryColor,
                    size: 11.sp,
                    weight: FontWeight.w700,
                  ),
                ),
                hGap(8),

                /// Title + subtitle + time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        task.title,
                        color: appTheme.textPrimary,
                        size: 16.sp,
                        weight: FontWeight.w500,
                        height: 1.38,
                      ),
                      vGap(4),
                      CText(
                        task.subtitle,
                        color: appTheme.grey,
                        size: 14.sp,
                        weight: FontWeight.w400,
                        height: 1.29,
                      ),
                      vGap(4),
                      CText(
                        task.time,
                        color: appTheme.grey,
                        size: 14.sp,
                        weight: FontWeight.w400,
                        height: 1.29,
                      ),

                      /// Extra Info Section (only for Leave Requests)
                      if (hasExtraInfo) ...[
                        vGap(16.h),

                        Divider(color: appTheme.veryLightGrey, height: 1.h),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 14.w,
                            right: 14.w,
                            top: 12.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow(AppStrings.type, task.type),
                              _buildInfoRow(AppStrings.items, task.items),
                              _buildInfoRow(AppStrings.urgency, task.urgency),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Bottom Action Bar
          Container(
            height: 48.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: appTheme.silver.withValues(alpha: 0.15),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15.r),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _buildActionButtons(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    if (value.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: appTheme.grey,
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            height: 1.29,
          ),
          children: [
            TextSpan(
              text: "$label: ",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: appTheme.grey,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: appTheme.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons() {
    List<Widget> buttons = [];

    switch (task.actionType) {
      case ActionType.taskProof:
        buttons.addAll([
          _buildActionChip(
            "Mark as approved",
            appTheme.mintGreen,
            appTheme.darkGreen,
            onTap: onApprove,
          ),
          hGap(6),
          _buildActionChip(
            AppStrings.reject,
            appTheme.lightPink.withValues(alpha: 0.3),
            appTheme.darkRed,
            onTap: onReject,
          ),
          hGap(6),
          _buildActionChip(
            AppStrings.viewDetails,
            appTheme.lightBlue.withValues(alpha: 0.6),
            appTheme.primaryColor,
            width: 108.w,
            onTap: onViewDetails,
          ),
        ]);
        break;

      case ActionType.deadlineExtension:
        buttons.addAll([
          _buildActionChip(
            "Mark as approved",
            appTheme.mintGreen,
            appTheme.darkGreen,
            onTap: onApprove,
          ),
          hGap(6),
          _buildActionChip(
            AppStrings.reject,
            appTheme.lightPink.withValues(alpha: 0.3),
            appTheme.darkRed,
            onTap: onReject,
          ),
          hGap(6),
          _buildActionChip(
            AppStrings.viewDetails,
            appTheme.lightBlue.withValues(alpha: 0.6),
            appTheme.primaryColor,
            width: 108.w,
            onTap: onViewDetails,
          ),
        ]);
        break;

      case ActionType.leaveRequest:
        buttons.addAll([
          _buildActionChip(
            "Mark as approved",
            appTheme.mintGreen,
            appTheme.darkGreen,
            onTap: onApprove,
          ),
          hGap(6),
          _buildActionChip(
            AppStrings.reject,
            appTheme.lightPink.withValues(alpha: 0.3),
            appTheme.darkRed,
            onTap: onReject,
          ),
          hGap(6),
          _buildActionChip(
            AppStrings.viewDetails,
            appTheme.lightBlue.withValues(alpha: 0.6),
            appTheme.primaryColor,
            width: 108.w,
            onTap: onViewDetails,
          ),
        ]);
        break;

      case ActionType.requestedItems:
        buttons.addAll([
          _buildActionChip(
            "Mark as done",
            appTheme.mintGreen,
            appTheme.darkGreen,
            onTap: onApprove,
          ),
          hGap(6),
          _buildActionChip(
            AppStrings.reject,
            appTheme.lightPink.withValues(alpha: 0.3),
            appTheme.darkRed,
            onTap: onReject,
          ),
          hGap(6),
          _buildActionChip(
            AppStrings.viewDetails,
            appTheme.lightBlue.withValues(alpha: 0.6),
            appTheme.primaryColor,
            width: 108.w,
            onTap: onViewDetails,
          ),
        ]);
        break;
      case null:
        // TODO: Handle this case.
        throw UnimplementedError();
    }

    return buttons;
  }

  Widget _buildActionChip(
    String text,
    Color bg,
    Color fg, {
    double? width,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24.h,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(50.r),
        ),
        alignment: Alignment.center,
        child: CText(text, color: fg, size: 12.sp, weight: FontWeight.w500),
      ),
    );
  }
}

enum ActionType { taskProof, deadlineExtension, leaveRequest, requestedItems }

class ActionTask {
  final String initials;
  final String title;
  final String subtitle;
  final String time;
  final String type;
  final String items;
  final String urgency;
  final ActionType? actionType;

  ActionTask({
    required this.initials,
    required this.title,
    required this.subtitle,
    required this.time,
    this.type = "",
    this.items = "",
    this.urgency = "",
    this.actionType,
  });
}
