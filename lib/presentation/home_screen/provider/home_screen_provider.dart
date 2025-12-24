import 'package:flutter/material.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';

class HomeScreenProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, dynamic>> requests = [
    {
      "icon": ImageConstant.camera,
      "title": "Task Proof",
      "subtitle": "Verify Kitchen Cleaning Proof",
    },
    {
      "icon": ImageConstant.deadline,
      "title": "Deadline extension",
      "subtitle": "Verify Kitchen Cleaning Proof",
    },
    {
      "icon": ImageConstant.resource,
      "title": "Resource request",
      "subtitle": "Verify Kitchen Cleaning Proof",
    },
    {
      "icon": ImageConstant.person,
      "title": "Leave request",
      "subtitle": "Verify Kitchen Cleaning Proof",
    },
  ];
}
