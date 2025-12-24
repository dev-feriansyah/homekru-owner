import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'dart:math' as math;

class HouseholdStatsDashboard extends StatelessWidget {
  const HouseholdStatsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            "Household Stats",
            size: 18.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 16.h),

          // Large Tasks Completed Card
          _buildTasksCompletedCard(),
          SizedBox(height: 16.h),

          // Two row cards
          Row(
            children: [
              Expanded(
                child: _buildCircularProgressCard(
                  "74%",
                  "Tasks Completed on time",
                  0.74,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildCircularProgressCard(
                  "45%",
                  "Redo Requests Over Total Tasks",
                  0.45,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: _buildCircularProgressCard(
                  "89%",
                  "On-Time Check-ins",
                  0.89,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(child: _buildTaskDistributionCard()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasksCompletedCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
        children: [
          // Green accent bar
          Container(
            width: 4.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: Color(0xFF83E888),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              "320",
                              size: 22.sp,
                              weight: FontWeight.w600,
                              color: appTheme.textPrimary,
                            ),
                            SizedBox(height: 4.h),
                            CText(
                              "Tasks completed",
                              size: 16.sp,
                              color: appTheme.textPrimary,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      DottedBorder(
                        options: CircularDottedBorderOptions(
                          dashPattern: [8, 5],
                          strokeWidth: 2,
                          color: appTheme.primaryColor,
                          padding: EdgeInsets.all(0),
                        ),
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: appTheme.lightBlueTwo,
                            shape: BoxShape.circle,
                            // border: Border.all(
                            //   color: appTheme.primaryColor.withOpacity(0.3),
                            //   width: 2,
                            //   style: BorderStyle.solid,
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomImageView(
                              imagePath: ImageConstant.checkIcon,
                              height: 12,
                              width: 12,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "100% Complete",
                        size: 10.sp,
                        color: appTheme.textPrimary,
                        weight: FontWeight.w500,
                      ),
                      CText(
                        "320 Tasks",
                        size: 10.sp,
                        color: appTheme.grey,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: appTheme.veryLightGrey,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: appTheme.primaryColor,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgressCard(
    String percentage,
    String title,
    double progress,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Yellow accent bar
          Container(
            margin: EdgeInsets.only(top: 22),
            width: 4.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: appTheme.mediumYellow,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 60.w,
                        height: 60.h,
                        child: Stack(
                          children: [
                            // Background circle
                            Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: appTheme.veryLightGrey,
                              ),
                            ),
                            // Progress arc
                            CustomPaint(
                              size: Size(60.w, 60.h),
                              painter: CircularProgressPainter(
                                progress: progress,
                                color: appTheme.primaryColor,
                                strokeWidth: 6,
                              ),
                            ),
                            // Center text
                            Center(
                              child: CText(
                                "100%",
                                size: 10.sp,
                                color: appTheme.grey,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              percentage,
                              size: 24.sp,
                              weight: FontWeight.bold,
                              color: appTheme.textPrimary,
                            ),
                            SizedBox(height: 4.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Bottom section with text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        title,
                        size: 14.sp,
                        weight: FontWeight.bold,
                        color: appTheme.textPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskDistributionCard() {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Yellow accent bar
          Container(
            margin: EdgeInsets.only(top: 22),
            width: 4.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: appTheme.mediumYellow,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Top section with chart and legend
                  Row(
                    children: [
                      SizedBox(
                        width: 60.w,
                        height: 60.h,
                        child: Stack(
                          children: [
                            // Background circle
                            Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: appTheme.veryLightGrey,
                              ),
                            ),
                            // Donut chart with multiple segments
                            CustomPaint(
                              size: Size(60.w, 60.h),
                              painter: MultiSegmentDonutPainter(
                                segments: [
                                  {
                                    'value': 0.6,
                                    'color': appTheme.primaryColor,
                                  },
                                  {'value': 0.25, 'color': appTheme.grey},
                                  {
                                    'value': 0.15,
                                    'color': appTheme.veryLightGrey,
                                  },
                                ],
                                strokeWidth: 8,
                              ),
                            ),
                            // Center text
                            Center(
                              child: CText(
                                "60%\nRina",
                                size: 8.sp,
                                color: appTheme.textPrimary,
                                weight: FontWeight.w600,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLegendItem("Rina", appTheme.primaryColor),
                            _buildLegendItem("Budi", appTheme.grey),
                            _buildLegendItem("Siti", appTheme.veryLightGrey),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Bottom section with text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        "Task Distribution",
                        size: 14.sp,
                        weight: FontWeight.bold,
                        color: appTheme.textPrimary,
                      ),
                      SizedBox(height: 4.h),
                      CText(
                        "Completed By Helper",
                        size: 12.sp,
                        color: appTheme.grey,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String name, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 6.w),
          CText(
            name,
            size: 10.sp,
            color: appTheme.grey,
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final startAngle = -math.pi / 2; // Start from top
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DonutChartPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  DonutChartPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final startAngle = -math.pi / 2; // Start from top
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MultiSegmentDonutPainter extends CustomPainter {
  final List<Map<String, dynamic>> segments;
  final double strokeWidth;

  MultiSegmentDonutPainter({required this.segments, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    double currentAngle = -math.pi / 2; // Start from top

    for (var segment in segments) {
      final value = segment['value'] as double;
      final color = segment['color'] as Color;

      final paint =
          Paint()
            ..color = color
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * math.pi * value;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        sweepAngle,
        false,
        paint,
      );

      currentAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
