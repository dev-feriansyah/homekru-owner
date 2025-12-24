import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/common_utils.dart';
import 'package:homekru_owner/core/utils/size_utils.dart';
import 'package:homekru_owner/presentation/settings/provider/settings_provider.dart';
import 'package:homekru_owner/presentation/settings/settings_screen.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/task_dropdown.dart';
import 'package:provider/provider.dart';

class AddHelperScreen extends StatefulWidget {
  const AddHelperScreen({super.key});

  @override
  State<AddHelperScreen> createState() => _AddHelperScreenState();
}

class _AddHelperScreenState extends State<AddHelperScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
      appBar: const CustomCommonAppBar(title: "Add Helper"),
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
          Container(
            // color: appTheme.lightBlue,
            height: SizeUtils.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      CText(
                        "Helper",
                        size: 18,
                        weight: FontWeight.bold,
                        fontFamily: "PoppinsMedium",
                      ),
                      vGap(18.h),
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
                          if (!emailRegex.hasMatch(value.trim()))
                            return 'Enter valid email';
                          return null;
                        },
                      ),
                      vGap(12.h),
                      Consumer<SettingsProvider>(
                        builder:
                            (context, provider, _) => TaskDropdown(
                              hintText: "Role/Position",
                              selectedTask: provider.selectedRole,
                              tasks: provider.roleOptions,
                              onChanged: (value) => provider.setRole(value!),
                            ),
                      ),
                      vGap(12.h),
                      Consumer<SettingsProvider>(
                        builder:
                            (context, provider, _) => TaskDropdown(
                              hintText: "Live-in Status",
                              selectedTask: provider.selectedLiveInStatus,
                              tasks: provider.liveInStatusOptions,
                              onChanged:
                                  (value) => provider.setLiveInStatus(value!),
                            ),
                      ),
                      vGap(12.h),
                      Consumer<SettingsProvider>(
                        builder:
                            (context, provider, _) => TaskDropdown(
                              hintText: "Working House",
                              selectedTask: provider.selectedWorkingHouse,
                              tasks: provider.workingHouseOptions,
                              onChanged:
                                  (value) => provider.setWorkingHouse(value!),
                            ),
                      ),
                      vGap(12.h),
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

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // For now, just pop after validation. Hook API here later.
      AppNavigator.pop();
    }
  }
}
