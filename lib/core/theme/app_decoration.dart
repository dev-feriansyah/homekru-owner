// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:fortune/core/utils/image_constant.dart';
// import 'package:fortune/core/utils/size_utils.dart';
// import 'package:fortune/theme/theme_helper.dart';

// class AppDecoration{
//   //Fill decoration
//   static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
//     color: theme.colorScheme.onPrimaryContainer,
//   );
//   //Gradient decoration
//   static BoxDecoration get gradientCyanToBlue => BoxDecoration(
//     gradient: LinearGradient(
//       begin: Alignment(0,0.06),
//       end: Alignment(1, 0.06),
//       colors: [appTheme.cyan300, appTheme.blue200],
//     ),
//   );
//   static BoxDecoration get gradientLightBlueToBlue => BoxDecoration(
//     gradient: LinearGradient(
//       begin: Alignment(0,0.5),
//       end: Alignment(1, 0.5),
//       colors: [appTheme.lightBlue300, appTheme.blue20001],
//     ),
//   );
//  //outline decoration
//   static BoxDecoration get outlineBlack => BoxDecoration(
//     color: theme.colorScheme.onPrimaryContainer,
//     boxShadow: [
//     BoxShadow(
//       color: appTheme.black90033.withOpacity(0.65),
//       spreadRadius: 2.h,
//       blurRadius: 2.h,
//         offset: Offset(0, 4)
//     ),
//     ]
//   );

//   static BoxDecoration get outlineOrangA => BoxDecoration(
//     color: theme.colorScheme.secondaryContainer,
//     border: Border.all(
//       color: appTheme.orangeA100,
//       width: 1.h,
//     ),
//   );



//  static var searchDecoration =  InputDecoration(
//     filled: true,
//     fillColor: Colors.white70,
//     isDense: true,
//     hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.normal, fontSize: 15),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(15.0)),
//       borderSide: BorderSide(color: appTheme.searchBorder,width: 1.5),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(15.0)),
//       borderSide: BorderSide(color: appTheme.searchBorder,width: 1.5),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(15.0)),
//       borderSide: BorderSide(color: appTheme.amber300,width: 1.5),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(15.0)),
//       borderSide: BorderSide(color: appTheme.searchBorder,width: 1.5),
//     ),
//   );

// }

// class BorderRadiusStyle {
//   //custom border
//   static BorderRadius get customBorderBR34  => BorderRadius.only(
//     topLeft: Radius.circular(20.h),
//     bottomRight: Radius.circular(34.4),
//   );

//   static BorderRadius get customBorderTL20  => BorderRadius.horizontal(
//     left: Radius.circular(20.h),
//   );

//   static BorderRadius get customBorderTL50  => BorderRadius.vertical(
//     top: Radius.circular(50.h),
//   );

//   static BorderRadius get roundedBorder10  => BorderRadius.circular(10.h );

// }