import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _faqItems = [
    {
      'question': 'How do I add a new helper?',
      'answer':
          'Go to the Members section and tap the "+" button to add a new helper. Fill in their details and assign tasks.',
      'category': 'Helpers',
    },
    {
      'question': 'How can I track task completion?',
      'answer':
          'You can view task completion in the Home screen dashboard or go to the Tasks section for detailed tracking.',
      'category': 'Tasks',
    },
    {
      'question': 'How do I set up recurring tasks?',
      'answer':
          'When creating a task, you can set it as recurring by selecting the frequency (daily, weekly, monthly).',
      'category': 'Tasks',
    },
    {
      'question': 'How can I contact support?',
      'answer':
          'You can contact support through the app, email, or phone. Use the contact options below for immediate assistance.',
      'category': 'Support',
    },
    {
      'question': 'How do I manage co-owners?',
      'answer':
          'Go to the Co-owners section to add, edit, or remove co-owners and manage their permissions.',
      'category': 'Co-owners',
    },
    {
      'question': 'How can I view reports?',
      'answer':
          'Access detailed reports and analytics in the Reports section to track performance and statistics.',
      'category': 'Reports',
    },
  ];

  final List<Map<String, dynamic>> _contactOptions = [
    {
      'title': 'Live Chat',
      'subtitle': 'Get instant help from our support team',
      'icon': Icons.chat,
      'color': appTheme.primaryColor,
    },
    {
      'title': 'Email Support',
      'subtitle': 'support@homekru.com',
      'icon': Icons.email,
      'color': appTheme.brightGreen,
    },
    {
      'title': 'Phone Support',
      'subtitle': '+1 (555) 123-4567',
      'icon': Icons.phone,
      'color': appTheme.orange,
    },
    {
      'title': 'Video Call',
      'subtitle': 'Schedule a video consultation',
      'icon': Icons.video_call,
      'color': appTheme.amber,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: const CustomCommonAppBar(title: "Help & Support"),
      body: Stack(
        children: [
          bottomWaveWidget(),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   child: CustomImageView(
          //     imagePath: ImageConstant.backgroundImage2,
          //     height: 200,
          //   ),
          // ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                _buildSearchBar(),
                SizedBox(height: 24.h),

                // Quick Actions
                _buildQuickActions(),
                SizedBox(height: 24.h),

                // Contact Options
                _buildContactOptions(),
                SizedBox(height: 24.h),

                // FAQ Section
                _buildFAQSection(),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            "How can we help you?",
            size: 18.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 16.h),
          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: "Search for help topics...",
              hintStyle: TextStyle(color: appTheme.grey, fontSize: 14.sp),
              prefixIcon: Icon(Icons.search, color: appTheme.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: appTheme.veryLightGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: appTheme.veryLightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: appTheme.primaryColor),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            "Quick Actions",
            size: 18.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionItem(
                  "User Guide",
                  Icons.book,
                  appTheme.primaryColor,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildQuickActionItem(
                  "Tutorials",
                  Icons.play_circle,
                  appTheme.brightGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionItem(
                  "Video Help",
                  Icons.video_library,
                  appTheme.orange,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildQuickActionItem(
                  "Report Bug",
                  Icons.bug_report,
                  appTheme.darkRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle quick action tap
        _showComingSoonDialog(title);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24.sp),
            SizedBox(height: 8.h),
            CText(
              title,
              size: 12.sp,
              color: color,
              weight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOptions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            "Contact Support",
            size: 18.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 16.h),
          ..._contactOptions
              .map((option) => _buildContactOption(option))
              ,
        ],
      ),
    );
  }

  Widget _buildContactOption(Map<String, dynamic> option) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _handleContactOption(option['title']);
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: appTheme.veryLightGrey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: option['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    option['icon'],
                    color: option['color'],
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        option['title'],
                        size: 14.sp,
                        weight: FontWeight.w600,
                        color: appTheme.textPrimary,
                      ),
                      SizedBox(height: 2.h),
                      CText(
                        option['subtitle'],
                        size: 12.sp,
                        color: appTheme.grey,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: appTheme.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    final filteredFAQs =
        _searchQuery.isEmpty
            ? _faqItems
            : _faqItems
                .where(
                  (item) =>
                      item['question'].toLowerCase().contains(_searchQuery) ||
                      item['answer'].toLowerCase().contains(_searchQuery) ||
                      item['category'].toLowerCase().contains(_searchQuery),
                )
                .toList();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            "Frequently Asked Questions",
            size: 18.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 16.h),
          if (filteredFAQs.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: CText(
                  "No results found for your search.",
                  size: 14.sp,
                  color: appTheme.grey,
                ),
              ),
            )
          else
            ...filteredFAQs.map((faq) => _buildFAQItem(faq)),
        ],
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: appTheme.veryLightGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ExpansionTile(
        title: CText(
          faq['question'],
          size: 14.sp,
          weight: FontWeight.w600,
          color: appTheme.textPrimary,
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: CText(
            faq['category'],
            size: 12.sp,
            color: appTheme.primaryColor,
            weight: FontWeight.w500,
          ),
        ),
        iconColor: appTheme.primaryColor,
        collapsedIconColor: appTheme.grey,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: CText(
              faq['answer'],
              size: 13.sp,
              color: appTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _handleContactOption(String title) {
    switch (title) {
      case 'Live Chat':
        _showComingSoonDialog('Live Chat');
        break;
      case 'Email Support':
        _showEmailDialog();
        break;
      case 'Phone Support':
        _showPhoneDialog();
        break;
      case 'Video Call':
        _showComingSoonDialog('Video Call');
        break;
    }
  }

  void _showComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: CText(
            "Coming Soon",
            size: 18.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          content: CText(
            "$feature feature will be available soon. Please use other contact methods for now.",
            size: 14.sp,
            color: appTheme.textPrimary,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: CText(
                "OK",
                size: 14.sp,
                color: appTheme.primaryColor,
                weight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: CText(
            "Email Support",
            size: 18.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CText(
                "Send us an email at:",
                size: 14.sp,
                color: appTheme.textPrimary,
              ),
              SizedBox(height: 8.h),
              CText(
                "support@homekru.com",
                size: 16.sp,
                color: appTheme.primaryColor,
                weight: FontWeight.w600,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: CText(
                "OK",
                size: 14.sp,
                color: appTheme.primaryColor,
                weight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPhoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: CText(
            "Phone Support",
            size: 18.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CText("Call us at:", size: 14.sp, color: appTheme.textPrimary),
              SizedBox(height: 8.h),
              CText(
                "+1 (555) 123-4567",
                size: 16.sp,
                color: appTheme.primaryColor,
                weight: FontWeight.w600,
              ),
              SizedBox(height: 8.h),
              CText("Available 24/7", size: 12.sp, color: appTheme.grey),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: CText(
                "OK",
                size: 14.sp,
                color: appTheme.primaryColor,
                weight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}
