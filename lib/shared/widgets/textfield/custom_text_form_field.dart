import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;

  final String? initialValue;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? labelWidget;
  final String? labelText;
  final InputDecoration? decoration;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool? obscureText;
  final Widget? prefix;

  final Widget? suffix;
  final bool? enabled;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final BorderRadius? borderRadius;
  final FocusNode? focusNode;
  final Widget? suffixIcon;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.validator,
    this.hintText,
    this.labelWidget,
    this.labelText,
    this.decoration,
    this.border,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.obscureText,
    this.prefix,
    this.suffix,
    this.enabled,
    this.onEditingComplete,
    this.onChanged,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    this.hintStyle,
    this.contentPadding,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.focusNode,
    this.suffixIcon,
  }) : assert(
         controller == null || initialValue == null,
         'Cannot provide both controller and initialValue',
       );

  @override
  Widget build(BuildContext context) {
    // final colors = getColorScheme();
    return Container(
      height: maxLines != null ? null : height ?? 57.h,
      width: double.infinity,
      padding: EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: appTheme.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: appTheme.offWhite),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: appTheme.shadowColor,
            blurRadius: 50,
            offset: const Offset(10, 20),
          ),
        ],
      ),
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        // autocorrect: false, // disable iOS corrections
        // enableSuggestions: false,
        initialValue: controller == null ? initialValue : null,
        textInputAction: TextInputAction.done,
        keyboardType: keyboardType ?? TextInputType.text,
        maxLength: maxLength,
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        enabled: enabled ?? true,
        obscureText: obscureText ?? false,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        onTap: onTap,
        readOnly: readOnly,
        enableIMEPersonalizedLearning: false,
        cursorColor: appTheme.primaryColor,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          // label  label,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: appTheme.grey,
            // fontFamily: "Poppins",
          ),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: appTheme.white,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: appTheme.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: appTheme.red, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: appTheme.offWhite, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: appTheme.offWhite, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: appTheme.primaryColor, width: 1),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
