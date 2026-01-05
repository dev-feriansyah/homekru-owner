import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/app_colors.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.lightBlue,
      appBar: CustomCommonAppBar(title: "Privacy Policy"),
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
                      "Privacy Policy",
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
                      "1. Information We Collect",
                      "We collect information you provide directly to us, such as when you create an account, use our services, or contact us for support. This may include:\n\n• Personal information (name, email address, phone number)\n• Household information (address, family members)\n• Helper information (staff details, schedules, performance data)\n• Usage data (app interactions, feature usage)\n• Device information (device type, operating system, unique device identifiers)",
                    ),

                    _buildSection(
                      "2. How We Use Your Information",
                      "We use the information we collect to:\n\n• Provide, maintain, and improve our services\n• Process transactions and send related information\n• Send technical notices, updates, security alerts, and support messages\n• Respond to your comments, questions, and requests\n• Monitor and analyze trends, usage, and activities\n• Personalize and improve your experience\n• Ensure compliance with legal obligations",
                    ),

                    _buildSection(
                      "3. Information Sharing and Disclosure",
                      "We may share your information in the following circumstances:\n\n• With your consent\n• To comply with legal obligations\n• To protect our rights and prevent fraud\n• In connection with a business transfer\n• With service providers who assist us in operating our services\n\nWe do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy.",
                    ),

                    _buildSection(
                      "4. Data Security",
                      "We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.",
                    ),

                    _buildSection(
                      "5. Data Retention",
                      "We retain your personal information for as long as necessary to provide our services and fulfill the purposes outlined in this privacy policy, unless a longer retention period is required or permitted by law. When we no longer need your information, we will securely delete or anonymize it.",
                    ),

                    _buildSection(
                      "6. Your Rights and Choices",
                      "Depending on your location, you may have certain rights regarding your personal information:\n\n• Access: Request access to your personal information\n• Correction: Request correction of inaccurate information\n• Deletion: Request deletion of your personal information\n• Portability: Request a copy of your data in a portable format\n• Objection: Object to certain processing of your information\n• Withdrawal of consent: Withdraw consent where processing is based on consent",
                    ),

                    _buildSection(
                      "7. Children's Privacy",
                      "Our services are not intended for children under 13 years of age. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete such information.",
                    ),

                    _buildSection(
                      "8. International Data Transfers",
                      "Your information may be transferred to and processed in countries other than your own. We ensure that such transfers comply with applicable data protection laws and implement appropriate safeguards to protect your information.",
                    ),

                    _buildSection(
                      "9. Changes to This Policy",
                      "We may update this privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page and updating the 'Last updated' date. We encourage you to review this privacy policy periodically for any changes.",
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
                            "Contact Us",
                            size: 16.sp,
                            weight: FontWeight.bold,
                            color: appColors.primaryColor,
                          ),
                          SizedBox(height: 8.h),
                          CText(
                            "If you have any questions about this Privacy Policy, please contact us at:",
                            size: 14.sp,
                            color: appColors.grey,
                          ),
                          SizedBox(height: 8.h),
                          CText(
                            "Email: privacy@homekru.com\nPhone: +62 21 1234 5678\nAddress: Jakarta, Indonesia",
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
