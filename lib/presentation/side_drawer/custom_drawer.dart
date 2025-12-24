import 'package:flutter/material.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A90E2), // Light blue
              Color(0xFF2E5BBA), // Darker blue
            ],
          ),
        ),
        child: Column(
          children: [
            // User Profile Section
            Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      'assets/profile_image.jpg',
                    ), // Replace with your image
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Maria Johnson',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Homeowner',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Main Navigation Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Main Navigation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // Navigation Items
                  _buildNavItem(
                    icon: Icons.assignment,
                    title: 'Action Items',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Action Items
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.people,
                    title: 'Attendance',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Attendance
                    },
                    isSelected: true, // This appears selected in the image
                  ),
                  _buildNavItem(
                    icon: Icons.receipt_long,
                    title: 'Deduction',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Deduction
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.access_time,
                    title: 'Overtime',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Overtime
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.subscriptions,
                    title: 'Manage Subscription',
                    onTap: () {
                      AppNavigator.pushNamed(AppRoutes.manageSubscription);
                      // Navigate to Manage Subscription
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Settings
                    },
                  ),

                  const Spacer(),

                  // About Us Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  _buildNavItem(
                    icon: Icons.description,
                    title: 'Terms and Conditions',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Terms and Conditions
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Privacy Policy
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.article,
                    title: 'Blog',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Blog
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.help_outline,
                    title: 'FAQs',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to FAQs
                    },
                  ),
                ],
              ),
            ),

            // Logout Button
            Container(
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle logout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF4A90E2),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 22),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
