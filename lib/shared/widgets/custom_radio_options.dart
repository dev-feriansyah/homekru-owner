import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class CustomRadioOption<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final double? width;
  final String label;

  const CustomRadioOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        height: 57.h,
        width: width ?? 1.sw,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
        decoration: ShapeDecoration(
          color: appTheme.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.w, color: appTheme.offWhite),
            borderRadius: BorderRadius.circular(15.r),
          ),
          shadows: [
            BoxShadow(
              color: appTheme.offWhite,
              blurRadius: 10.r,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CText(
              label.toString(),
              color: appTheme.grey,
              size: 16.sp,
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: 20,
              width: 20,
              child: Radio<T>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: appTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
