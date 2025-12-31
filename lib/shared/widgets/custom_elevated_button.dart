import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'base_button.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.isLoading = false,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    required super.text,
    this.isOutline = false,
  });

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool isLoading;
  final bool isOutline;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.center,
          child: buildElevatedButtonWidget,
        )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
    height: height ?? 50.h,
    width: width ?? double.maxFinite,
    margin: margin,
    decoration: decoration,
    child: ElevatedButton(
      style:
          buttonStyle ??
          ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              isOutline ? Colors.white : appTheme.primaryColor,
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
                side: BorderSide(color: appTheme.primaryColor),
              ),
            ),
          ),

      onPressed: (isDisabled ?? false) || isLoading ? null : onPressed ?? () {},
      child:
          isLoading
              ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  valueColor: AlwaysStoppedAnimation<Color>(appTheme.white),
                ),
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leftIcon ?? const SizedBox.shrink(),
                  Text(
                    text,
                    style:
                        buttonTextStyle ??
                        GoogleFonts.karla(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color:
                              isOutline
                                  ? appTheme.primaryColor
                                  : appTheme.white,
                        ),
                  ),
                  rightIcon ?? const SizedBox.shrink(),
                ],
              ),
    ),
  );
}
