import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/domain/value_objects/date_range.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';

import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class OvertimeDetailedScreen extends StatefulWidget {
  const OvertimeDetailedScreen({super.key});

  @override
  State<OvertimeDetailedScreen> createState() => _OvertimeDetailedScreenState();
}

class _OvertimeDetailedScreenState extends State<OvertimeDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: CustomCommonAppBar(title: "Maria Johnson"),

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
          SizedBox(
            height: SizeUtils.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(
                          "Date Range",
                          size: 18,
                          weight: FontWeight.bold,
                          fontFamily: "PoppinsMedium",
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            color: appTheme.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: appTheme.primaryColor.withValues(
                                alpha: 0.3,
                              ),
                              width: 2,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: null,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: appTheme.primaryColor,
                              ),
                              style: TextStyle(
                                color: appTheme.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                              items:
                                  DateRange.values.map((DateRange value) {
                                    return DropdownMenuItem<String>(
                                      value: value.label,
                                      child: Text(value.label),
                                    );
                                  }).toList(),
                              onChanged: (newValue) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    Container(
                      width: SizeUtils.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: appTheme.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            width: SizeUtils.width,
                            decoration: BoxDecoration(
                              color: appTheme.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CText(
                                    "Date",
                                    size: 10,
                                    weight: FontWeight.bold,
                                    color: appTheme.white,
                                  ),
                                ),
                                Expanded(
                                  child: CText(
                                    "Check In",
                                    size: 10,
                                    weight: FontWeight.bold,
                                    textAlign: TextAlign.center,
                                    color: appTheme.white,
                                  ),
                                ),
                                Expanded(
                                  child: CText(
                                    "Check Out",
                                    size: 10,
                                    textAlign: TextAlign.center,
                                    weight: FontWeight.bold,
                                    color: appTheme.white,
                                  ),
                                ),
                                Expanded(
                                  child: CText(
                                    "Hours",
                                    size: 10,
                                    weight: FontWeight.bold,
                                    textAlign: TextAlign.center,
                                    color: appTheme.white,
                                  ),
                                ),
                                Expanded(
                                  child: CText(
                                    "Amount",
                                    size: 10,
                                    weight: FontWeight.bold,
                                    textAlign: TextAlign.center,
                                    color: appTheme.white,
                                  ),
                                ),
                                Expanded(
                                  child: CText(
                                    "Status",
                                    size: 10,
                                    weight: FontWeight.bold,
                                    textAlign: TextAlign.end,
                                    color: appTheme.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 9,
                            separatorBuilder:
                                (context, index) => Container(
                                  height: 1,
                                  width: SizeUtils.width,
                                  color: appTheme.veryLightGrey,
                                ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // NavigatorService.pushNamed(
                                  //   AppRoutes.attendanceScreen,
                                  // );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: appTheme.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CText(
                                          "15-05-25",
                                          weight: FontWeight.w700,
                                          color: appTheme.grey,
                                          size: 10,
                                        ),
                                      ),
                                      Expanded(
                                        child: CText(
                                          "9:00",
                                          weight: FontWeight.w700,
                                          textAlign: TextAlign.center,
                                          color: appTheme.grey,
                                          size: 10,
                                        ),
                                      ),

                                      // Hours
                                      Expanded(
                                        child: CText(
                                          "12:00",
                                          textAlign: TextAlign.center,
                                          size: 10,
                                          color: appTheme.grey,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                      Expanded(
                                        child: CText(
                                          "5 hrs",
                                          textAlign: TextAlign.center,
                                          weight: FontWeight.w700,
                                          color: appTheme.grey,
                                          size: 10,
                                        ),
                                      ),

                                      Expanded(
                                        child: CText(
                                          "\$189.49",
                                          weight: FontWeight.w700,
                                          textAlign: TextAlign.center,
                                          color: appTheme.grey,
                                          size: 10,
                                        ),
                                      ),

                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                (index % 2 == 0)
                                                    ? appTheme.mintGreen
                                                    : appTheme.lightYellow,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: CText(
                                            (index % 2 == 0)
                                                ? "Paid"
                                                : "Pending",

                                            color:
                                                (index % 2 == 0)
                                                    ? appTheme.darkGreen
                                                    : appTheme.amber,
                                            size: 9,
                                            weight: FontWeight.bold,
                                            textAlign: TextAlign.center,
                                            fontFamily: "PoppinsMedium",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            height: 1,
                            width: SizeUtils.width,
                            color: appTheme.veryLightGrey,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CText(
                                  "Total",
                                  size: 14,
                                  weight: FontWeight.bold,
                                  fontFamily: "PoppimsMedium",
                                  color: appTheme.grey,
                                ),
                                const SizedBox(width: 8),
                                CText(
                                  "\$99.00",
                                  size: 14,
                                  fontFamily: "PoppimsMedium",
                                  weight: FontWeight.bold,
                                  color: appTheme.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.h),

                    CustomElevatedButton(
                      onPressed: () {
                        // NavigatorService.popAndPushNamed(AppRoutes.coownerListScreen);
                      },
                      text: "Export Detailed Report",
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
