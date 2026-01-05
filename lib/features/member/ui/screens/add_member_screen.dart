import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/features/member/ui/providers/add_member_form_provider.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/shared/widgets/custom_app_bar.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_radio_options.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddMemberScreen extends ConsumerWidget {
  const AddMemberScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(addMemberFormProvider);
    final notifier = ref.read(addMemberFormProvider.notifier);

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      appBar: CustomCommonAppBar(title: "Add Helper"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          // SizedBox(height: 20.h),

          /// Helper Profile Setup
          CText(
            'Helper Profile Setup',
            color: colorScheme.onSurface,
            size: 18.sp,
            weight: FontWeight.w500,
          ),
          SizedBox(height: 20.h),

          /// Name
          CustomTextFormField(
            hintText: "Enter helper's full name",
            initialValue: state.name,
            onChanged: notifier.setName,
          ),
          SizedBox(height: 15.h),

          /// Phone Number
          CustomTextFormField(
            hintText: 'Enter helper\'s phone number',
            initialValue: state.phone,
            onChanged: notifier.setPhone,
          ),
          SizedBox(height: 15.h),

          /// Role of helper
          CustomTextFormField(
            hintText: 'Role of helper ',
            initialValue: state.role,
            onChanged: notifier.setRole,
          ),
          SizedBox(height: 20.h),

          /// Live-in status
          CText(
            'Live-in status',
            color: colorScheme.onSurface,
            size: 18.sp,
            weight: FontWeight.w500,
          ),
          SizedBox(height: 18.h),

          /// Live-in Helper
          CustomRadioOption<LiveInStatus>(
            value: LiveInStatus.liveIn,
            groupValue: state.liveInStatus,
            onChanged: notifier.setLiveInStatus,
            label: AppStrings.liveInHelper,
          ),
          SizedBox(height: 12.h),

          /// Non Live-in Helper
          CustomRadioOption<LiveInStatus>(
            value: LiveInStatus.nonLiveIn,
            groupValue: state.liveInStatus,
            onChanged: notifier.setLiveInStatus,
            label: AppStrings.nonLiveInHelper,
          ),
          SizedBox(height: 35.h),

          /// Continue Button
          CustomElevatedButton(
            text: AppStrings.continueText,
            height: 50.h,
            width: double.infinity,
            isLoading: state.isLoading,
            onPressed:
            // provider.isFormValid && !provider.isLoading
            //     ?
            () {
              if (state.liveInStatus == LiveInStatus.liveIn) {
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
  }
}
