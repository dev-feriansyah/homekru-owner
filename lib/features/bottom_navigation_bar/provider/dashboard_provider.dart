import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/features/home_screen/ui/screens/home_screen.dart';
import 'package:homekru_owner/features/settings/settings_screen.dart';
import 'package:homekru_owner/features/member/helper/screen/member_screen.dart';
import 'package:homekru_owner/features/side_drawer/side_drawer.dart';
import 'package:homekru_owner/features/task/screens/task_screen.dart';

class DashboardProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final AwesomeDrawerBarController _drawerController =
      AwesomeDrawerBarController();
  AwesomeDrawerBarController get drawerController => _drawerController;

  bool _isDrawerOpen = false;
  bool get isDrawerOpen => _isDrawerOpen;

  void changeOpenDrawer(val) {
    _isDrawerOpen = val;
    notifyListeners();
  }

  // ✅ Use a getter instead of initializing directly
  List<Widget> get screens => [
    AwesomeDrawerBar(
      type: StyleState.scaleRotate,
      mainScreen: HomeScreen(
        toggle: () async {
          await _drawerController.toggle?.call();
          // Toggle the state when drawer is opened/closed
          _isDrawerOpen = !_isDrawerOpen;
          notifyListeners();
        },
      ),
      menuScreen: Sidebar(),
      controller: _drawerController,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.fastEaseInToSlowEaseOut,
      slideHeight: 30,
      angle: -5.0,

      // backgroundColor: appTheme.grey,
      // slideWidth: MediaQuery.of(context).size.width*(AwesomeDrawerBar.isRTL()? .45: 0.65),
    ),
    // const Center(child: Text('Tasks')),
    const TaskScreen(),
    MemberScreen(),
    SettingsScreen(),
  ];

  final List<String> icons = [
    ImageConstant.home,
    ImageConstant.task,
    ImageConstant.member,
    ImageConstant.setting,
  ];

  final List<String> labels = ['Home', 'Task', 'Members', 'Settings'];

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
