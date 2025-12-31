import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/features/settings/settings_screen.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';

class AddCoOwnerScreen extends StatefulWidget {
  const AddCoOwnerScreen({super.key});

  @override
  State<AddCoOwnerScreen> createState() => _AddCoOwnerScreenState();
}

class _AddCoOwnerScreenState extends State<AddCoOwnerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _accessTask = false;
  bool _accessActionItems = false;
  bool _accessCheckInOut = false;
  bool _accessOvertime = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightBlue,
      appBar: const CustomCommonAppBar(title: "Add Co-owner"),
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
          SizedBox(
            // color: appTheme.lightBlue,
            height: SizeUtils.height,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: SingleChildScrollView(
                // padding: const EdgeInsets.symmetric(
                //   horizontal: 20,
                //   vertical: 16,
                // ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextField(
                        "Full Name",
                        _nameController,
                        validator:
                            (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Please enter full name'
                                    : null,
                      ),

                      vGap(12.h),
                      buildTextField(
                        "Email",
                        _emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter email';
                          }
                          final emailRegex = RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          );
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                      ),
                      // vGap(12.h),
                      // Consumer<SettingsProvider>(
                      //   builder:
                      //       (context, provider, _) => TaskDropdown(
                      //         hintText: "Relationship with homeowner",
                      //         selectedTask:
                      //             provider.selectedRelationshipWithHomeowner,
                      //         tasks: provider.relationshipWithHomeownerOptions,
                      //         onChanged:
                      //             (value) => provider
                      //                 .setRelationshipWithHomeowner(value!),
                      //       ),
                      // ),
                      vGap(20.h),
                      CText(
                        'Access given for',
                        size: 18.sp,
                        weight: FontWeight.w500,
                        color: appTheme.textPrimary,
                      ),
                      vGap(6.h),
                      _buildCheckbox(
                        value: _accessTask,
                        onChanged:
                            (v) => setState(() => _accessTask = v ?? false),
                        text:
                            'Task management access (create, edit and delete)',
                      ),
                      _buildCheckbox(
                        value: _accessActionItems,
                        onChanged:
                            (v) =>
                                setState(() => _accessActionItems = v ?? false),
                        text:
                            'Action items access (view, edit and mark completed)',
                      ),
                      _buildCheckbox(
                        value: _accessCheckInOut,
                        onChanged:
                            (v) =>
                                setState(() => _accessCheckInOut = v ?? false),
                        text:
                            'Check in check out access (discharge, create and edit check in and check out times)',
                      ),
                      _buildCheckbox(
                        value: _accessOvertime,
                        onChanged:
                            (v) => setState(() => _accessOvertime = v ?? false),
                        text: 'Overtime access (view and mark as paid)',
                      ),
                      vGap(24.h),
                      CustomElevatedButton(
                        text: 'Submit',
                        onPressed: _onSubmit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24.w,
            width: 24.w,
            child: Checkbox(
              checkColor: appTheme.white,
              activeColor: appTheme.primaryColor,
              value: value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              side: BorderSide(color: appTheme.lightGrey),
              onChanged: onChanged,
            ),
          ),

          hGap(6.w),
          Expanded(
            child: CText(
              text,
              size: 16.sp,
              color: appTheme.grey,
              weight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // For now, just pop after validation. Hook API here later.
      AppNavigator.pop();
    }
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appTheme.lightBlue,
//       appBar: const CustomCommonAppBar(title: "Add Co-Owners"),
//       body: Stack(
//         children: [
//           Positioned(
//             bottom: 0,
//             left: 0,
//             child: Image.asset(ImageConstant.backgroundImage2, height: 200),
//           ),
//           SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTextField(
//                     controller: _nameController,
//                     hintText: 'Full Name',
//                     validator:
//                         (value) =>
//                             (value == null || value.trim().isEmpty)
//                                 ? 'Please enter full name'
//                                 : null,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     controller: _emailController,
//                     hintText: 'Email',
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Please enter email';
//                       }
//                       final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
//                       if (!emailRegex.hasMatch(value.trim()))
//                         return 'Enter valid email';
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   _buildRelationDropdown(),
//                   const SizedBox(height: 24),
//                   CText(
//                     'Access given for',
//                     size: 16,
//                     weight: FontWeight.w600,
//                     color: appTheme.black,
//                   ),
//                   const SizedBox(height: 8),
//                   _buildCheckbox(
//                     value: _accessTask,
//                     onChanged: (v) => setState(() => _accessTask = v ?? false),
//                     text: 'Task management access (create, edit and delete)',
//                   ),
//                   _buildCheckbox(
//                     value: _accessActionItems,
//                     onChanged:
//                         (v) => setState(() => _accessActionItems = v ?? false),
//                     text: 'Action items access (view, edit and mark completed)',
//                   ),
//                   _buildCheckbox(
//                     value: _accessCheckInOut,
//                     onChanged:
//                         (v) => setState(() => _accessCheckInOut = v ?? false),
//                     text:
//                         'Check in check out access (discharge, create and edit check in and check out times)',
//                   ),
//                   _buildCheckbox(
//                     value: _accessOvertime,
//                     onChanged:
//                         (v) => setState(() => _accessOvertime = v ?? false),
//                     text: 'Overtime access (view and mark as paid)',
//                   ),
//                   const SizedBox(height: 24),
//                   CustomElevatedButton(text: 'Submit', onPressed: _onSubmit),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     String? Function(String?)? validator,
//     TextInputType? keyboardType,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       cursorColor: appTheme.lightGrey,
//       validator: validator,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: TextStyle(
//           color: appTheme.lightGrey,
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//         ),
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 15,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: appTheme.veryLightGrey),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: appTheme.veryLightGrey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: appTheme.veryLightGrey),
//         ),
//       ),
//     );
//   }

//   void _onSubmit() {
//     if (_formKey.currentState?.validate() ?? false) {
//       // For now, just pop after validation. Hook API here later.
//       Navigator.of(context).pop();
//     }
//   }
// }
