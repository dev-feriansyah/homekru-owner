import 'package:flutter/material.dart';

final appTheme = LightCodeColors();

class LightCodeColors {
  LightCodeColors();

  Color get amber300 => const Color.fromRGBO(251, 166, 41, 1);
  Color get intro1 => const Color(0xFFD96A89);
  Color get intro2 => const Color(0xFF89A371);
  Color get intro3 => const Color.fromRGBO(227, 152, 91, 1);
  Color get grey => const Color(0xFF616161);
  Color get lightBackground => const Color(0xFFF8F9FA);

  Color get shadowColor => const Color(0xff3B70B9).withValues(alpha: 0.08);
  Color get lightBorder => const Color(0xFFE5E7EB);

  Color get textPrimary => const Color(0xFF212121);
  Color get textSecondary => const Color(0xFF747474);

  Color get black => Colors.black;
  Color get white => Colors.white;
  Color get darkGrey => const Color(0xFF5F6368);
  Color get mediumGrey => const Color(0xFF666666);
  Color get lightGrey => const Color(0xFF747474);
  Color get veryLightGrey => const Color(0xFFE0E0E0);
  Color get primaryColor => const Color(0xFF3B70B9);
  Color get darkCharcoal => const Color(0xFF333333);
  Color get lightGreen => const Color(0xFFD0FFB8);
  Color get paleGreen => const Color(0xFFEEFFE6);
  Color get brightGreen => const Color(0xFF41B607);
  Color get bgGreen => const Color(0xFFC9F2CB);
  Color get orange => const Color(0xFFC95D05);
  Color get paleOrange => const Color(0xFFFFF1E5);
  Color get lightOrange => const Color(0xFFFFCBA1);
  Color get lightBlue => const Color(0xFFEEF3F9);
  Color get lightBlueTwo => const Color(0xFFE3ECF7);
  Color get lightBlueThree => Color.fromARGB(255, 153, 185, 224);
  Color get darkRed => const Color(0xFFC62828);
  Color get red => Colors.red;

  Color get amber => const Color(0xFFF9A825);
  Color get lightPink => const Color(0xFFFAC0CA);
  Color get lightYellow => const Color(0xFFFFF3CC);
  Color get mediumYellow => const Color(0xFFF5DF97);
  Color get silver => const Color(0xFFBDBDBD);
  Color get silver2 => const Color(0xFFF5F5F5).withValues(alpha: 10);
  Color get offWhite => const Color(0xFFF4F4F4);
  Color get mintGreen => const Color(0xFFE8F5E9);
  Color get darkGreen => const Color(0xFF2E7D32);
  Color get blueAccentCustom => Color(0xFF2E5BA2);
  Color get greyAA => const Color(0xFFAAAAAA);

  // Accent colors
  Color get successColor => const Color(0xFF4CAF50);
  Color get warningColor => const Color(0xFFFF9800);
  Color get errorColor => const Color(0xFFE53E3E);
  Color get infoColor => const Color(0xFF2196F3);
}
