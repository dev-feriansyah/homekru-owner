import 'package:flutter/material.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/features/bottom_navigation_bar/provider/dashboard_provider.dart';
import 'package:homekru_owner/features/side_drawer/side_drawer.dart';

import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return
        // provider.isDrawerOpen
        // ?  Scaffold(
        //   body: provider.screens[provider.selectedIndex],
        //   ) // Hide when drawer is open
        // :
        Scaffold(
          drawer: Sidebar(),
          body: provider.screens[provider.selectedIndex],
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
              children: List.generate(provider.icons.length, (index) {
                final isSelected = provider.selectedIndex == index;

                return GestureDetector(
                  onTap: () => provider.onItemTapped(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: SizeUtils.width / 4,
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
                          width: isSelected ? SizeUtils.width / 4 : 0,
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Column(
                                  children: [
                                    CustomImageView(
                                      imagePath: provider.icons[index],
                                      color:
                                          isSelected
                                              ? appTheme.primaryColor
                                              : Colors.grey.shade700,
                                      height: 25,
                                    ),

                                    const SizedBox(height: 7),
                                    Text(
                                      provider.labels[index],
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
      },
    );
  }
}
