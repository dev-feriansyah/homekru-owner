import 'package:flutter/material.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/features/home_screen/ui/screens/home_screen.dart';
import 'package:homekru_owner/features/member/ui/screens/member_screen.dart';
import 'package:homekru_owner/features/settings/settings_screen.dart';
import 'package:homekru_owner/features/task/ui/screens/task_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/features/side_drawer/side_drawer.dart';

import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/dashboard_index.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  static const _pages = [
    HomeScreen(),
    TaskScreen(),
    MemberScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardIndex = ref.watch(dashboardIndexProvider);
    final notifier = ref.read(dashboardIndexProvider.notifier);

    final List<String> icons = [
      ImageConstant.home,
      ImageConstant.task,
      ImageConstant.member,
      ImageConstant.setting,
    ];

    final List<String> labels = ['Home', 'Task', 'Members', 'Settings'];

    return Scaffold(
      drawer: Sidebar(),
      body: _pages[dashboardIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (i) {
            final isSelected = i == dashboardIndex;

            return GestureDetector(
              onTap: () => notifier.set(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 1.sw / 4,
                decoration: BoxDecoration(
                  gradient:
                      isSelected
                          ? LinearGradient(
                            colors: [
                              Color.fromARGB(255, 218, 230, 247),
                              Color.fromARGB(255, 241, 247, 255),

                              Colors.white,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                          : null,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Top animated line
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 3,
                      width: isSelected ? 1.sw / 4 : 0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: appTheme.primaryColor,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                CustomImageView(
                                  imagePath: icons[i],
                                  color:
                                      isSelected
                                          ? appTheme.primaryColor
                                          : Colors.grey.shade700,
                                  height: 25,
                                ),

                                const SizedBox(height: 7),
                                Text(
                                  labels[i],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w600,
                                    color:
                                        isSelected
                                            ? appTheme.black
                                            : Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
