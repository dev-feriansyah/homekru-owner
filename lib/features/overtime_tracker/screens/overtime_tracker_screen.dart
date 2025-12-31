import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:homekru_owner/shared/domain/value_objects/date_range.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class OvertimeTrackerScreen extends HookWidget {
  const OvertimeTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDateRange = useState(DateRange.today.label);

    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: CustomCommonAppBar(title: "Overtime Tracker"),

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                            color: appTheme.primaryColor.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedDateRange.value,
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
                            onChanged: (newValue) {
                              if (newValue == "Custom") {
                                showDateRangePickerDialog(
                                  context: context,
                                  onRangePicked: (range) {},
                                );
                              } else {
                                selectedDateRange.value = newValue!;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: SizeUtils.width,
                    // padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: appTheme.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: appTheme.primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: CustomImageView(
                              imagePath: ImageConstant.maskGroup,
                              // width: SizeUtils.width * 0.7,
                              height: SizeUtils.height * 0.14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CText(
                                "Period: April 1-30, 2025",
                                size: 15,
                                color: appTheme.grey,
                              ),
                              const SizedBox(height: 8),
                              CText(
                                "Total overtime (all helpers): 26.0 hours",
                                weight: FontWeight.bold,
                                size: 17,
                                fontFamily: "PoppinsMedium",
                              ),
                              const SizedBox(height: 8),
                              CText(
                                "Total outstanding overtime: IDR 1,200,000",
                                weight: FontWeight.bold,
                                size: 17,
                                color: appTheme.primaryColor,
                                fontFamily: "PoppinsMedium",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Overtime Listing",
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: appTheme.primaryColor,
                            value: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                              side: BorderSide(
                                color: appTheme.silver.withValues(alpha: 0.2),
                              ),
                            ),
                            side: BorderSide(color: appTheme.grey),
                            onChanged: (bool? newValue) {},
                          ),
                          CText(
                            "Mark all as paid",
                            size: 14,
                            color: appTheme.grey,
                            weight: FontWeight.w600,
                          ),
                        ],
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
                                flex: 2,
                                child: CText(
                                  "Helper",
                                  size: 14,
                                  weight: FontWeight.bold,
                                  color: appTheme.white,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CText(
                                  "Hours",
                                  textAlign: TextAlign.center,
                                  size: 14,
                                  weight: FontWeight.bold,
                                  color: appTheme.white,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CText(
                                  "Amount",
                                  textAlign: TextAlign.end,
                                  size: 14,
                                  weight: FontWeight.bold,
                                  color: appTheme.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          separatorBuilder:
                              (context, index) => Container(
                                height: 1,
                                width: SizeUtils.width,
                                color: appTheme.veryLightGrey,
                              ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                AppNavigator.pushNamed(
                                  AppRoutes.overtimeDetailed,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: appTheme.white,
                                  borderRadius:
                                      (index != 4)
                                          ? null
                                          : BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CText(
                                            "Maria Johnson",
                                            weight: FontWeight.bold,
                                            size: 13,
                                          ),
                                          CText(
                                            "Maid",
                                            size: 12,
                                            color: appTheme.grey,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Hours
                                    Expanded(
                                      flex: 1,
                                      child: CText(
                                        "10.5 hrs",
                                        textAlign: TextAlign.center,
                                        size: 12,
                                        color: appTheme.grey,
                                        weight: FontWeight.w700,
                                      ),
                                    ),

                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      (index % 2 == 0)
                                                          ? appTheme.mintGreen
                                                          : appTheme
                                                              .lightYellow,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: CText(
                                                  (index % 2 == 0)
                                                      ? "Paid"
                                                      : "Pending",

                                                  color:
                                                      (index % 2 == 0)
                                                          ? appTheme.brightGreen
                                                          : appTheme.amber,
                                                  size: 12,
                                                  weight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              CText(
                                                "\$189.49",
                                                weight: FontWeight.w700,
                                                color: appTheme.grey,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 4),
                                          InkWell(
                                            onTap: () {
                                              _showCustomDialog(context);
                                            },
                                            child: const Icon(
                                              Icons.more_vert,
                                              color: Colors.grey,
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                    // height: 55.h,
                    onPressed: () {},
                    text: "Export Detailed Report",
                    // buttonTextStyle: TextStyle(
                    //   color: appTheme.white,
                    //   fontSize: 18,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    // buttonStyle: ButtonStyle(
                    //   backgroundColor: MaterialStateProperty.all(
                    //     appTheme.primaryColor,
                    //   ),
                    //   shape: MaterialStateProperty.all(
                    //     RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //   ),
                    // ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> showDateRangePickerDialog({
    required BuildContext context,
    required void Function(DateTimeRange range) onRangePicked,
  }) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 30)),
        end: DateTime.now(),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appTheme.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onRangePicked(picked);
    }
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent, // background transparent
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              right: 40, // adjust according to your UI
              top: 200, // adjust according to your UI
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Add your "Mark as Paid" logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Marked as Paid")),
                      );
                    },
                    child: const Text(
                      "Mark as paid",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
