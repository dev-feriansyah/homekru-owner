import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/app_colors.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.lightBlue,
      appBar: CustomCommonAppBar(title: "Terms and Conditions"),
      body: Stack(
        children: [
          bottomWaveWidget(),
          SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Container(
              decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      "Terms and Conditions",
                      size: 24.sp,
                      weight: FontWeight.bold,
                      color: appColors.primaryColor,
                    ),
                    SizedBox(height: 8.h),
                    CText(
                      "Last updated: January 1, 2024",
                      size: 14.sp,
                      color: appColors.grey,
                    ),
                    SizedBox(height: 24.h),

                    _buildSection(
                      "1. Acceptance of Terms",
                      "By accessing and using HomeKru Owner app, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.",
                    ),

                    _buildSection(
                      "2. Use License",
                      "Permission is granted to temporarily download one copy of HomeKru Owner app for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not:\n\n• Modify or copy the materials\n• Use the materials for any commercial purpose or for any public display\n• Attempt to reverse engineer any software contained in the app\n• Remove any copyright or other proprietary notations from the materials",
                    ),

                    _buildSection(
                      "3. Disclaimer",
                      "The materials within HomeKru Owner app are provided on an 'as is' basis. HomeKru makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.",
                    ),

                    _buildSection(
                      "4. Limitations",
                      "In no event shall HomeKru or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on HomeKru Owner app, even if HomeKru or a HomeKru authorized representative has been notified orally or in writing of the possibility of such damage. Because some jurisdictions do not allow limitations on implied warranties, or limitations of liability for consequential or incidental damages, these limitations may not apply to you.",
                    ),

                    _buildSection(
                      "5. Accuracy of Materials",
                      "The materials appearing in HomeKru Owner app could include technical, typographical, or photographic errors. HomeKru does not warrant that any of the materials on its app are accurate, complete, or current. HomeKru may make changes to the materials contained in its app at any time without notice. However HomeKru does not make any commitment to update the materials.",
                    ),

                    _buildSection(
                      "6. Links",
                      "HomeKru has not reviewed all of the sites linked to its app and is not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement by HomeKru of the site. Use of any such linked website is at the user's own risk.",
                    ),

                    _buildSection(
                      "7. Modifications",
                      "HomeKru may revise these terms of service for its app at any time without notice. By using this app you are agreeing to be bound by the then current version of these terms of service.",
                    ),

                    _buildSection(
                      "8. Governing Law",
                      "These terms and conditions are governed by and construed in accordance with the laws of Indonesia and you irrevocably submit to the exclusive jurisdiction of the courts in that state or location.",
                    ),

                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: appColors.lightBlue.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            "Contact Information",
                            size: 16.sp,
                            weight: FontWeight.bold,
                            color: appColors.primaryColor,
                          ),
                          SizedBox(height: 8.h),
                          CText(
                            "If you have any questions about these Terms and Conditions, please contact us at:",
                            size: 14.sp,
                            color: appColors.grey,
                          ),
                          SizedBox(height: 8.h),
                          CText(
                            "Email: support@homekru.com\nPhone: +62 21 1234 5678\nAddress: Jakarta, Indonesia",
                            size: 14.sp,
                            color: appColors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            title,
            size: 18.sp,
            weight: FontWeight.bold,
            color: appColors.primaryColor,
          ),
          SizedBox(height: 8.h),
          CText(content, size: 14.sp, color: appColors.grey, height: 1.5),
        ],
      ),
    );
  }
}
