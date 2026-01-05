import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homekru_owner/core/theme/app_colors.dart';

class CustomAssignDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final String? hintText;
  final void Function(String?) onChanged;
  final Color? borderColor;
  final Widget? leading;

  const CustomAssignDropdown({
    super.key,
    required this.selectedValue,
    this.hintText,
    required this.items,
    required this.onChanged,
    this.borderColor,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 57.h,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: ShapeDecoration(
        color: appColors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: borderColor ?? appColors.lightBorder,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: appColors.shadowColor,
            blurRadius: 50,
            offset: const Offset(10, 20),
          ),
        ],
      ),
      child: Row(
        children: [
          if (leading != null) ...[leading!, SizedBox(width: 12.w)],
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                hint: Text(
                  hintText ?? 'Select Task',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: appColors.grey,
                    // fontFamily: "Poppins",
                  ),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: appColors.grey,
                  size: 20,
                ),
                // style: GoogleFonts.poppins(
                //   fontSize: 16.sp,
                //   fontWeight: FontWeight.w400,
                //   color: appTheme.grey,
                //   // fontFamily: "Poppins",
                // ),
                dropdownColor: appColors.white,
                borderRadius: BorderRadius.circular(12),
                items:
                    items
                        .map(
                          (task) => DropdownMenuItem<String>(
                            value: task,
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: appColors.blueAccentCustom
                                        .withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      (() {
                                        final parts = task.trim().split(
                                          RegExp(r'\s+'),
                                        );
                                        if (parts.isEmpty) return '';
                                        final first =
                                            parts.first.isNotEmpty
                                                ? parts.first[0]
                                                : '';
                                        final last =
                                            parts.length > 1 &&
                                                    parts.last.isNotEmpty
                                                ? parts.last[0]
                                                : '';
                                        return (first + last).toUpperCase();
                                      })(),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: appColors.blueAccentCustom,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    task,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: appColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
