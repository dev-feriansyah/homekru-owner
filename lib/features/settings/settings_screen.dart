import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/domain/value_objects/app_language.dart';
import 'package:homekru_owner/shared/domain/value_objects/notification_setting.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_home_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/task_dropdown.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController changePassController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        // onBackTap: () {
        //   AppNavigator.pop();
        // },
      ),
      backgroundColor: appTheme.lightBlue,
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
          Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              children: [
                _SectionHeader(title: 'Account Settings'),
                vGap(12.h),
                buildTextField(
                  "Update Phone Number",
                  phoneController,
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Please enter phone number'
                              : null,
                  keyboardType: TextInputType.phone,
                ),
                vGap(14.h),
                buildTextField(
                  "Change Password",
                  changePassController,
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Please enter password'
                              : null,
                  keyboardType: TextInputType.visiblePassword,
                ),
                vGap(24.h),

                // _FilledTile(label: 'Update Phone Number', onTap: () {}),
                // vGap(14),
                // _FilledTile(label: 'Change Password', onTap: () {}),
                _SectionHeader(title: 'Manage People'),
                vGap(12.h),
                _TrailingArrowTile(
                  label: 'Co-owners',
                  onTap: () {
                    AppNavigator.pushNamed(AppRoutes.coownerList);
                  },
                ),
                vGap(14.h),
                _TrailingArrowTile(
                  label: 'Helper',
                  onTap: () {
                    AppNavigator.pushNamed(AppRoutes.helperList);
                  },
                ),

                vGap(24.h),
                _SectionHeader(title: 'Home Setup'),
                vGap(12.h),
                _TrailingArrowTile(
                  label: 'Setup',
                  onTap: () => AppNavigator.pushNamed(AppRoutes.homeSetup),
                ),

                vGap(24.h),
                _SectionHeader(title: 'Preferences'),
                vGap(12.h),

                /// 🔹 Language Dropdown
                TaskDropdown(
                  hintText: "Select Language",
                  selectedTask: null,
                  tasks: AppLanguage.values.map((e) => e.label).toList(),
                  onChanged: (value) => {},
                ),
                vGap(14.h),

                /// 🔹 Notification Preference Dropdown
                TaskDropdown(
                  hintText: "Notification Preference",
                  selectedTask: null,
                  tasks:
                      NotificationSetting.values.map((e) => e.label).toList(),
                  onChanged: (value) => {},
                ),

                vGap(35.h),
                // Container(
                //   decoration: BoxDecoration(
                //     color: const Color(0xFFFFE9EB),
                //     borderRadius: BorderRadius.circular(12),
                //     border: Border.all(color: const Color(0xFFFFCCD1)),
                //   ),
                //   child: CustomElevatedButton(
                //     text: 'Mark as Inactive',

                //     buttonStyle: ButtonStyle(
                //       elevation: WidgetStateProperty.all(0),

                //       shape: WidgetStateProperty.all(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(15.r),
                //         ),
                //       ),
                //       backgroundColor: WidgetStateProperty.all(
                //         Colors.transparent,
                //       ),
                //     ),
                //     buttonTextStyle: TextStyle(
                //       color: appTheme.darkRed,
                //       fontWeight: FontWeight.w600,
                //       fontSize: 18.sp,
                //     ),
                //     onPressed: () {},
                //   ),
                // ),

                // vGap(12.h),
                CustomElevatedButton(
                  text: 'Save change',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                ),
                vGap(30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CText(
          title,
          size: 18.sp,
          weight: FontWeight.w500,
          color: appTheme.textPrimary,
        ),
      ],
    );
  }
}

class _TrailingArrowTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _TrailingArrowTile({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: appTheme.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CText(
              label,
              size: 16,
              weight: FontWeight.w400,
              color: appTheme.grey,
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

Widget buildTextField(
  String label,
  TextEditingController controller, {
  FormFieldValidator<String>? validator,
  TextInputType? keyboardType,
  int? minLines,
  int? maxLines,
}) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: appTheme.shadowColor,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      readOnly: false,
      style: TextStyle(
        color: appTheme.grey,
        fontSize: 14.sp,
        fontFamily: "Poppins",
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        // label  label,
        hintText: label,
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: appTheme.grey,
          // fontFamily: "Poppins",
        ),
        filled: true,
        fillColor: appTheme.white,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red, width: 0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appTheme.offWhite, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appTheme.offWhite, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appTheme.offWhite, width: 0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red, width: 0),
        ),
      ),
      validator: validator,
    ),
  );
}
