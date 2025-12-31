import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  String _selectedCategory = 'General';
  int _selectedRating = 5;
  bool _isAnonymous = false;

  final List<String> _categories = [
    'General',
    'Bug Report',
    'Feature Request',
    'Service Quality',
    'Helper Performance',
    'App Usability',
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: const CustomCommonAppBar(title: "Feedback"),
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating Section
                  _buildRatingSection(),
                  SizedBox(height: 24.h),

                  // Category Selection
                  _buildCategorySection(),
                  SizedBox(height: 24.h),

                  // Feedback Form
                  _buildFeedbackForm(),
                  SizedBox(height: 24.h),

                  // Anonymous Option
                  _buildAnonymousOption(),
                  SizedBox(height: 32.h),

                  // Submit Button
                  CustomElevatedButton(
                    text: "Submit Feedback",
                    onPressed: _submitFeedback,
                  ),
                  SizedBox(height: 24.h),

                  // Recent Feedback
                  _buildRecentFeedback(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
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
            "How would you rate your experience?",
            size: 16.sp,
            weight: FontWeight.w600,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedRating = index + 1;
                  });
                },
                child: Icon(
                  index < _selectedRating ? Icons.star : Icons.star_border,
                  size: 32.sp,
                  color: appTheme.amber,
                ),
              );
            }),
          ),
          SizedBox(height: 8.h),
          Center(
            child: CText(
              _getRatingText(_selectedRating),
              size: 14.sp,
              color: appTheme.grey,
              weight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
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
            "Category",
            size: 16.sp,
            weight: FontWeight.w600,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 12.h),
          DropdownButtonFormField<String>(
            initialValue: _selectedCategory,
            decoration: InputDecoration(
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
                vertical: 8.h,
              ),
            ),
            items:
                _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: CText(
                      category,
                      size: 14.sp,
                      color: appTheme.textPrimary,
                    ),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackForm() {
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
            "Tell us more about your experience",
            size: 16.sp,
            weight: FontWeight.w600,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _feedbackController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText:
                  "Please share your thoughts, suggestions, or report any issues...",
              hintStyle: TextStyle(color: appTheme.grey, fontSize: 14.sp),
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
              contentPadding: EdgeInsets.all(12.w),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please provide your feedback';
              }
              if (value.trim().length < 10) {
                return 'Please provide more detailed feedback (at least 10 characters)';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnonymousOption() {
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
      child: Row(
        children: [
          Checkbox(
            value: _isAnonymous,
            onChanged: (value) {
              setState(() {
                _isAnonymous = value ?? false;
              });
            },
            activeColor: appTheme.primaryColor,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: CText(
              "Submit feedback anonymously",
              size: 14.sp,
              color: appTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentFeedback() {
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
            "Recent Feedback",
            size: 18.sp,
            weight: FontWeight.bold,
            color: appTheme.textPrimary,
          ),
          SizedBox(height: 16.h),
          _buildFeedbackItem(
            "Great service! The helper was very professional.",
            "5 stars",
            "2 days ago",
            appTheme.brightGreen,
          ),
          _buildFeedbackItem(
            "App could be more user-friendly.",
            "3 stars",
            "1 week ago",
            appTheme.amber,
          ),
          _buildFeedbackItem(
            "Excellent cleaning service, highly recommended!",
            "5 stars",
            "2 weeks ago",
            appTheme.brightGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackItem(
    String feedback,
    String rating,
    String date,
    Color ratingColor,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: appTheme.veryLightGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                rating,
                size: 12.sp,
                color: ratingColor,
                weight: FontWeight.w600,
              ),
              CText(date, size: 12.sp, color: appTheme.grey),
            ],
          ),
          SizedBox(height: 8.h),
          CText(feedback, size: 14.sp, color: appTheme.textPrimary),
        ],
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return "Poor";
      case 2:
        return "Fair";
      case 3:
        return "Good";
      case 4:
        return "Very Good";
      case 5:
        return "Excellent";
      default:
        return "";
    }
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            title: CText(
              "Thank You!",
              size: 18.sp,
              weight: FontWeight.bold,
              color: appTheme.textPrimary,
            ),
            content: CText(
              "Your feedback has been submitted successfully. We appreciate your input!",
              size: 14.sp,
              color: appTheme.textPrimary,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Reset form
                  _feedbackController.clear();
                  setState(() {
                    _selectedRating = 5;
                    _selectedCategory = 'General';
                    _isAnonymous = false;
                  });
                },
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
}
