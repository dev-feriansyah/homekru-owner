import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedPeriod = 'This Month';
  final List<String> _periods = [
    'This Week',
    'This Month',
    'Last Month',
    'This Year',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: const CustomCommonAppBar(title: "Reports"),
      body: Stack(
        children: [
          bottomWaveWidget(),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   child: CustomImageView(
          //     imagePath: ImageConstant.backgroundImage2,
          //     height: 200,
          //   ),
          // ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Period Selector
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset(0, 2),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Period:",
                        size: 16.sp,
                        weight: FontWeight.w600,
                        color: appTheme.textPrimary,
                      ),
                      DropdownButton<String>(
                        value: _selectedPeriod,
                        underline: SizedBox(),
                        items:
                            _periods.map((String period) {
                              return DropdownMenuItem<String>(
                                value: period,
                                child: CText(
                                  period,
                                  size: 14.sp,
                                  color: appTheme.textPrimary,
                                ),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedPeriod = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Summary Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Total Tasks",
                        "156",
                        Icons.task_alt,
                        appTheme.primaryColor,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildSummaryCard(
                        "Completed",
                        "142",
                        Icons.check_circle,
                        appTheme.brightGreen,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Pending",
                        "14",
                        Icons.pending,
                        appTheme.orange,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildSummaryCard(
                        "Hours Worked",
                        "89.5",
                        Icons.access_time,
                        appTheme.amber,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Performance Chart
                _buildChartSection(),
                SizedBox(height: 24.h),

                // Detailed Reports
                _buildDetailedReports(),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24.sp),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CText(
                  "+12%",
                  size: 10.sp,
                  color: color,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CText(
            value,
            size: 24.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 4.h),
          CText(
            title,
            size: 12.sp,
            color: appTheme.grey,
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            "Performance Overview",
            size: 18.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 200.h,
            child: Center(
              child: CText(
                "Chart Placeholder\n(Integrate with charts_flutter or similar)",
                size: 14.sp,
                color: appTheme.grey,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedReports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText(
          "Detailed Reports",
          size: 18.sp,
          weight: FontWeight.bold,
          color: appTheme.textPrimary,
        ),
        SizedBox(height: 16.h),
        _buildReportItem(
          "Task Completion Report",
          "View detailed task completion statistics",
          Icons.analytics,
        ),
        _buildReportItem(
          "Helper Performance",
          "Individual helper performance metrics",
          Icons.person,
        ),
        _buildReportItem(
          "Time Tracking",
          "Detailed time tracking and attendance",
          Icons.schedule,
        ),
        _buildReportItem(
          "Financial Summary",
          "Cost analysis and budget reports",
          Icons.account_balance_wallet,
        ),
      ],
    );
  }

  Widget _buildReportItem(String title, String subtitle, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appTheme.veryLightGrey),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: appTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: appTheme.primaryColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  title,
                  size: 14.sp,
                  weight: FontWeight.w600,
                  color: appTheme.textPrimary,
                ),
                SizedBox(height: 4.h),
                CText(subtitle, size: 12.sp, color: appTheme.grey),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: appTheme.grey),
        ],
      ),
    );
  }
}
