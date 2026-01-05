import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/app_colors.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  final List<FAQItem> faqs = [
    FAQItem(
      question: "How do I add a new helper to my household?",
      answer:
          "To add a new helper, go to the Members tab and tap the '+' button. Fill in the helper's details including name, phone number, role, and working hours. You can also set up live-in or non-live-in preferences and configure their specific settings.",
    ),
    FAQItem(
      question: "How does the attendance tracking work?",
      answer:
          "Our app uses GPS-based check-in/out system. Helpers can check in when they arrive at your location and check out when they leave. The app automatically tracks their working hours and calculates overtime. You can view daily attendance reports and manage schedules from the Attendance tab.",
    ),
    FAQItem(
      question: "Can I create custom tasks for my helpers?",
      answer:
          "Yes! You can create custom tasks in two ways: 1) Use our pre-built task templates from the room setup, or 2) Create tasks from scratch with custom descriptions, subtasks, and schedules. You can assign tasks to specific helpers and set recurring schedules.",
    ),
    FAQItem(
      question: "How do I manage overtime and deductions?",
      answer:
          "The app automatically tracks overtime based on check-in/out times. You can view overtime reports in the Overtime tab and manage deductions in the Deduction tab. Set up overtime rates and deduction rules in helper settings to automate calculations.",
    ),
    FAQItem(
      question: "What if my helper doesn't have a smartphone?",
      answer:
          "No problem! You can manage check-ins manually from your end, or set up a shared device at your home for helpers to use. The app also supports alternative check-in methods like PIN codes or QR codes.",
    ),
    FAQItem(
      question: "How do I add co-owners to manage my household?",
      answer:
          "Go to Settings > Manage People > Co-owners and tap 'Add Co-owner'. Enter their email address and select which features they can access. They'll receive an invitation to join your household management.",
    ),
    FAQItem(
      question: "Can I export reports for accounting purposes?",
      answer:
          "Yes! You can export detailed reports for attendance, overtime, and deductions. These reports include all necessary information for payroll processing and can be downloaded in PDF or Excel format.",
    ),
    FAQItem(
      question: "How do I set up room-specific tasks?",
      answer:
          "First, set up your home rooms in the Home Setup section. Then, when creating tasks, you can select specific rooms and the app will suggest relevant tasks based on the room type. You can also create custom tasks for any room.",
    ),
    FAQItem(
      question: "What happens if my helper is late or absent?",
      answer:
          "The app will notify you of late arrivals or absences. You can set up automatic notifications and configure how to handle these situations. You can also track attendance patterns and discuss any issues with your helpers.",
    ),
    FAQItem(
      question: "How do I change my subscription plan?",
      answer:
          "Go to Settings > Manage Subscription to view your current plan and available options. You can upgrade, downgrade, or change your billing cycle. Changes will take effect at your next billing date.",
    ),
    FAQItem(
      question: "Is my data secure and private?",
      answer:
          "Absolutely! We use industry-standard encryption to protect your data. All information is stored securely and we never share your personal data with third parties. You can read our full Privacy Policy for more details.",
    ),
    FAQItem(
      question: "How do I contact support if I need help?",
      answer:
          "You can contact our support team through the app's Help & Support section, or email us at support@homekru.com. We also have a live chat feature available during business hours for immediate assistance.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.lightBlue,
      appBar: CustomCommonAppBar(title: "Frequently Asked Questions"),
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
                      "Frequently Asked Questions",
                      size: 24.sp,
                      weight: FontWeight.bold,
                      color: appColors.primaryColor,
                    ),
                    SizedBox(height: 8.h),
                    CText(
                      "Find answers to common questions about HomeKru Owner",
                      size: 14.sp,
                      color: appColors.grey,
                    ),
                    SizedBox(height: 24.h),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: faqs.length,
                      itemBuilder: (context, index) {
                        return _buildFAQItem(faqs[index], index);
                      },
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
                            "Still have questions?",
                            size: 16.sp,
                            weight: FontWeight.bold,
                            color: appColors.primaryColor,
                          ),
                          SizedBox(height: 8.h),
                          CText(
                            "If you can't find the answer you're looking for, our support team is here to help!",
                            size: 14.sp,
                            color: appColors.grey,
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to contact support
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: appColors.primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: CText(
                                    "Contact Support",
                                    size: 14.sp,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    // Navigate to help center
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: appColors.primaryColor,
                                    side: BorderSide(
                                      color: appColors.primaryColor,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: CText(
                                    "Help Center",
                                    size: 14.sp,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
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

  Widget _buildFAQItem(FAQItem faq, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: appColors.grey.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          title: CText(
            faq.question,
            size: 16.sp,
            weight: FontWeight.w600,
            color: appColors.primaryColor,
          ),
          children: [
            CText(faq.answer, size: 14.sp, color: appColors.grey, height: 1.5),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
