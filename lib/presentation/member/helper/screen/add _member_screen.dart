import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/utils/constants/app_strings.dart';
import 'package:homekru_owner/presentation/member/provider/add_member_provider.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_radio_options.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize controllers when the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddMemberProvider>().initializeControllers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddMemberProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: appTheme.lightBlue,
          appBar: CustomCommonAppBar(title: "Add Helper"),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              // SizedBox(height: 20.h),

              /// Helper Profile Setup
              CText(
                'Helper Profile Setup',
                color: appTheme.textPrimary,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              SizedBox(height: 20.h),

              /// Name
              CustomTextFormField(
                hintText: "Enter helper's full name",
                controller: provider.nameController,
              ),
              SizedBox(height: 15.h),

              /// Phone Number
              CustomTextFormField(
                hintText: 'Enter helper\'s phone number',
                controller: provider.phoneController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 15.h),

              /// Role of helper
              CustomTextFormField(
                hintText: 'Role of helper ',
                controller: provider.roleController,
              ),
              SizedBox(height: 20.h),

              /// Live-in status
              CText(
                'Live-in status',
                color: appTheme.textPrimary,
                size: 18.sp,
                weight: FontWeight.w500,
              ),
              SizedBox(height: 18.h),

              /// Live-in Helper
              CustomRadioOption<LiveInStatus>(
                value: LiveInStatus.liveIn,
                groupValue: provider.selectedLiveInStatus,
                onChanged: (val) => provider.setLiveInStatus(val),
                label: AppStrings.liveInHelper,
              ),
              SizedBox(height: 12.h),

              /// Non Live-in Helper
              CustomRadioOption<LiveInStatus>(
                value: LiveInStatus.nonLiveIn,
                groupValue: provider.selectedLiveInStatus,
                onChanged: (val) => provider.setLiveInStatus(val),
                label: AppStrings.nonLiveInHelper,
              ),
              SizedBox(height: 35.h),

              /// Continue Button
              CustomElevatedButton(
                text: AppStrings.continueText,
                height: 50.h,
                width: double.infinity,
                isLoading: provider.isLoading,
                onPressed:
                // provider.isFormValid && !provider.isLoading
                //     ?
                () {
                  if (provider.selectedLiveInStatus == LiveInStatus.liveIn) {
                    AppNavigator.pushNamed(AppRoutes.liveInHelperSettings);
                  } else {
                    AppNavigator.pushNamed(AppRoutes.nonLiveInHelperSettings);
                  }
                },
                // : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
