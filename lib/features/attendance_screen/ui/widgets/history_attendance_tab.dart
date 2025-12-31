import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class HistoryAttendanceTab extends HookWidget {
  const HistoryAttendanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState<DateTime>(
      DateTime.now().subtract(Duration(days: 1)),
    );

    final topList = [
      {
        'name': 'James Miller',
        'checkIn': '8:15 AM',
        'checkOut': '5:00 PM',
        'status': '10M Ago',
        'tag': 'Discharge',
      },
      {
        'name': 'James Miller',
        'checkIn': '8:15 AM',
        'checkOut': '5:00 PM',
        'status': 'Day Off',
        'tag': null,
      },
      {
        'name': 'James Miller',
        'checkIn': '8:15 AM',
        'checkOut': '5:00 PM',
        'status': 'Day Off',
        'tag': null,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20,
                ),
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
                    Row(
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
                                size: 16,
                              ),
                              SizedBox(height: 5),
                              CText(
                                'Check-in: ${item['checkIn']}',
                                size: 14,
                                color: appTheme.grey,
                              ),
                              SizedBox(height: 5),
                              CText(
                                'Expected check-out: ${item['checkOut']}',
                                size: 14,
                                color: appTheme.grey,
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
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

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
