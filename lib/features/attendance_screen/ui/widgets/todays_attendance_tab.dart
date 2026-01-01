import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:intl/intl.dart';

// Track attendance status for each member

Map<String, Map<String, dynamic>> attendanceData = {
  'James Miller': {
    'status': 'checked-in', // 'checked-in', 'discharged', 'day-off'
    'checkIn': '8:15 AM',
    'checkOut': '5:00 PM',
    'dischargedAt': null,
    'expectedCheckIn': null,
  },
  'Maria Garcia': {
    'status': 'day-off',
    'checkIn': '8:15 AM',
    'checkOut': '5:00 PM',
    'dischargedAt': null,
    'expectedCheckIn': null,
  },
  'John Smith': {
    'status': 'day-off',
    'checkIn': '8:15 AM',
    'checkOut': '5:00 PM',
    'dischargedAt': null,
    'expectedCheckIn': null,
  },
};

class TodayAttendanceTab extends HookWidget {
  const TodayAttendanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final selectedDate = useState<DateTime>(
      DateTime.now().subtract(Duration(days: 1)),
    );

    void reminderPopup(context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: appTheme.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 32),
                          Expanded(
                            child: CText(
                              "Custom Time",
                              textAlign: TextAlign.center,
                              size: 18,
                              weight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // NavigatorService.goBack();
                              AppNavigator.pop();
                            },
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: appTheme.lightBlueTwo,
                              child: Icon(
                                Icons.close,
                                color: appTheme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CText("Check-in", size: 15, weight: FontWeight.bold),
                      SizedBox(height: 10),
                      Form(
                        key: formKey,
                        child: Row(
                          children: [
                            // Hour input
                            Expanded(
                              child: TextFormField(
                                controller: TextEditingController(text: "08"),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "HH",
                                  labelText: "Hour",
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: appTheme.grey.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: appTheme.grey.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: appTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Required';
                                  }
                                  final hour = int.tryParse(val);
                                  if (hour == null || hour < 0 || hour > 23) {
                                    return 'Invalid';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 12),
                            CText(":", size: 20, weight: FontWeight.bold),
                            SizedBox(width: 12),
                            // Minute input
                            Expanded(
                              child: TextFormField(
                                controller: TextEditingController(text: "00"),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "MM",
                                  labelText: "Minute",
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: appTheme.grey.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: appTheme.grey.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: appTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Required';
                                  }
                                  final minute = int.tryParse(val);
                                  if (minute == null ||
                                      minute < 0 ||
                                      minute > 59) {
                                    return 'Invalid';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            // NavigatorService.goBack();
                            AppNavigator.pop();
                          } else {}
                        },

                        child: Container(
                          width: 1.sw,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: appTheme.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CText(
                            'Save',
                            textAlign: TextAlign.center,
                            size: 16,
                            color: appTheme.white,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }

    // Generate dynamic list based on attendance data
    final topList =
        attendanceData.entries.map((entry) {
          final name = entry.key;
          final data = entry.value;

          String statusText;
          String? tag;

          switch (data['status']) {
            case 'checked-in':
              statusText = 'Checked-in';
              tag = 'Discharge';
              break;
            case 'discharged':
              statusText = 'Not checked-in';
              tag = null;
              break;
            case 'day-off':
              statusText = 'Day Off';
              tag = null;
              break;
            default:
              statusText = 'Checked-in';
              tag = 'Discharge';
          }

          return {
            'name': name,
            'checkIn': data['checkIn'],
            'checkOut': data['checkOut'],
            'status': statusText,
            'tag': tag,
            'dischargedAt': data['dischargedAt'],
            'expectedCheckIn': data['expectedCheckIn'],
          };
        }).toList();

    final bottomList = [
      {
        'title': 'Check-in Reminder',
        'subtitle': 'Would you like Maria to check in at 8:00 AM tomorrow?',
      },
      {
        'title': 'End of Work Hours',
        'subtitle':
            'Maria work hours are ending in 30 minutes\nWould you like to discharge?',
      },
    ];
    String convertNameToInitials(String name) {
      final parts = name.trim().split(RegExp(r'\s+'));
      if (parts.length < 2) return '';
      String firstInitial = parts.first[0].toUpperCase();
      String lastInitial = parts.last[0].toUpperCase();
      return '$lastInitial$firstInitial'; // Last name initial first
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                DateFormat('EEEE, MMMM d, y').format(selectedDate.value),
                size: 18,
                weight: FontWeight.bold,
              ),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().subtract(
                      Duration(days: 1),
                    ), // disables today and future
                    helpText: 'Select a Date',
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: appTheme.primaryColor,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (picked != null && picked != selectedDate.value) {
                    selectedDate.value = picked;
                  }
                },
                child: Icon(
                  Icons.calendar_month_rounded,
                  color: appTheme.primaryColor,
                  size: 25,
                ),
              ),
              // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ],
          ),
          SizedBox(height: 20),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: topList.length,
            itemBuilder: (context, index) {
              final item = topList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: appTheme.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: appTheme.primaryColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  // boxShadow: [BoxShadow(blurRadius: 6, color: appTheme.main.withValues(alpha: 0.3))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: appTheme.lightBlueTwo,
                            radius: 18,
                            child: CText(
                              convertNameToInitials(item['name']!),
                              color: appTheme.primaryColor,
                              size: 11,
                              weight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  item['name']!,
                                  weight: FontWeight.bold,
                                  size: 16.sp,
                                ),
                                SizedBox(height: 5),

                                // Show different details based on status
                                if (item['status'] == 'Checked-in') ...[
                                  CText(
                                    'Checked-in: ${item['checkIn']}',
                                    size: 14.sp,
                                    color: appTheme.grey,
                                    weight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 5),
                                  CText(
                                    'Expected check-out: ${item['checkOut']}',
                                    size: 14.sp,
                                    color: appTheme.grey,
                                  ),
                                ] else if (item['status'] ==
                                    'Not checked-in') ...[
                                  CText(
                                    'Discharged at: ${item['dischargedAt'] ?? 'N/A'}',
                                    size: 14.sp,
                                    color: appTheme.grey,
                                    weight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 5),
                                  CText(
                                    'Expected check-in: ${item['expectedCheckIn'] ?? 'N/A'}',
                                    size: 14.sp,
                                    color: appTheme.grey,
                                  ),
                                ] else if (item['status'] == 'Day Off') ...[
                                  CText(
                                    'Day Off',
                                    size: 14.sp,
                                    color: appTheme.grey,
                                    weight: FontWeight.w500,
                                  ),
                                ],

                                if (item['tag'] != null) SizedBox(height: 7),
                                if (item['tag'] != null)
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            insetPadding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),

                                            child: Container(
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                color: appTheme.white,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(width: 32),
                                                      Expanded(
                                                        child: CText(
                                                          "Discharge",
                                                          textAlign:
                                                              TextAlign.center,
                                                          size: 18,
                                                          weight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // NavigatorService.goBack();
                                                          AppNavigator.pop();
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 16,
                                                          backgroundColor:
                                                              appTheme
                                                                  .lightBlueTwo,
                                                          child: Icon(
                                                            Icons.close,
                                                            color:
                                                                appTheme
                                                                    .primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  CText(
                                                    "Is tomorrow’s check-in time the same as default or custom?",
                                                    textAlign: TextAlign.center,
                                                    size: 15,
                                                    weight: FontWeight.w500,
                                                  ),
                                                  SizedBox(height: 15),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                right: 6,
                                                              ), // half of 12
                                                          child: Material(
                                                            child: OutlinedButton(
                                                              style: ButtonStyle(
                                                                shape: WidgetStateProperty.all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          15,
                                                                        ),
                                                                  ),
                                                                ),
                                                                side: WidgetStateProperty.all(
                                                                  BorderSide(
                                                                    color:
                                                                        appTheme
                                                                            .primaryColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                // _handleDischarge(
                                                                //   item['name']!,
                                                                //   'default',
                                                                // );
                                                                AppNavigator.pop();
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10.0,
                                                                      vertical:
                                                                          15,
                                                                    ),
                                                                child: CText(
                                                                  "Default",
                                                                  size: 14,
                                                                  color:
                                                                      appTheme
                                                                          .primaryColor,
                                                                  weight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "PoppinsMedium",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                left: 6,
                                                              ), // half of 12
                                                          child: ElevatedButton(
                                                            style: ButtonStyle(
                                                              shape: WidgetStateProperty.all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        15,
                                                                      ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  WidgetStateProperty.all(
                                                                    appTheme
                                                                        .primaryColor,
                                                                  ),
                                                            ),
                                                            onPressed: () {
                                                              AppNavigator.pop();
                                                              reminderPopup(
                                                                context,
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        10.0,
                                                                    vertical:
                                                                        15,
                                                                  ),
                                                              child: CText(
                                                                "Custom",
                                                                color:
                                                                    appTheme
                                                                        .white,
                                                                size: 14,
                                                                weight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "PoppinsMedium",
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: appTheme.lightPink.withValues(
                                          alpha: 0.6,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: CText(
                                        item['tag']!,
                                        color: appTheme.darkRed,
                                        size: 14,
                                        weight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (item['status'] == 'Day Off')
                            _buildTag(
                              'Day Off',
                              appTheme.lightPink.withValues(alpha: 0.6),
                              appTheme.darkRed,
                            )
                          else
                            _buildTag(
                              item['status']!,
                              appTheme.lightYellow,
                              appTheme.amber,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: appTheme.silver.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: appTheme.grey,
                          ),
                          SizedBox(width: 5),
                          CText(
                            "123 Main St (within geo-fence)",
                            size: 14,
                            color: appTheme.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomImageView(imagePath: ImageConstant.line),
          ),
          SizedBox(height: 20),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: bottomList.length,
            itemBuilder: (context, index) {
              final item = bottomList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                // padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: appTheme.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: appTheme.primaryColor),
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
                            item['title']!,
                            weight: FontWeight.bold,
                            color: appTheme.primaryColor,
                            size: 16,
                          ),
                          const SizedBox(height: 8),
                          CText(
                            item['subtitle']!,
                            size: 14,
                            color: appTheme.grey,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              OutlinedButton(
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all(
                                    BorderSide(color: appTheme.primaryColor),
                                  ),
                                ),
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 0,
                                  ),
                                  child: CText(
                                    "No",
                                    size: 14,
                                    color: appTheme.primaryColor,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    appTheme.primaryColor,
                                  ),
                                ),
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 1,
                                  ),
                                  child: CText(
                                    "Yes",
                                    color: appTheme.white,
                                    size: 14,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // void _handleDischarge(String memberName, String type) {
  //   setState(() {
  //     final now = DateTime.now();
  //     final currentTime = DateFormat('h:mm a').format(now);
  //     final tomorrowTime = DateFormat(
  //       'h:mm a',
  //     ).format(now.add(Duration(days: 1)));

  //     attendanceData[memberName]!['status'] = 'discharged';
  //     attendanceData[memberName]!['dischargedAt'] = currentTime;
  //     attendanceData[memberName]!['expectedCheckIn'] = tomorrowTime;
  //   });

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('$memberName has been discharged successfully!'),
  //       backgroundColor: appTheme.mintGreen,
  //       behavior: SnackBarBehavior.floating,
  //     ),
  //   );
  // }

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: CText(
        text,
        color: textColor,
        weight: FontWeight.bold,
        size: 14,
        fontFamily: "PoppinsMedium",
      ),
    );
  }
}
