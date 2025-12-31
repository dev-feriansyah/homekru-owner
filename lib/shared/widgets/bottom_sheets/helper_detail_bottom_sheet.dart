import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/constants/app_strings.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart' show SizeUtils;
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_radio_options.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/dialogs/note_dialog.dart';

enum LiveInStatus { liveIn, nonLiveIn }

enum SetupProfile { yes, no }

class HelperDetailsBottomSheet extends StatefulWidget {
  const HelperDetailsBottomSheet({super.key});

  @override
  State<HelperDetailsBottomSheet> createState() =>
      _HelperDetailsBottomSheetState();
}

class _HelperDetailsBottomSheetState extends State<HelperDetailsBottomSheet> {
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  LiveInStatus? _liveInStatus = LiveInStatus.nonLiveIn;
  SetupProfile? _setupProfile = SetupProfile.no;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 40.h,
            width: SizeUtils.width,
            decoration: BoxDecoration(
              color: appTheme.silver2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),

            child: Center(
              child: Container(
                width: 90.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 20.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 25.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Drag indicator

                /// Title
                Center(
                  child: CText(
                    AppStrings.helperDetails,
                    size: 20.sp,
                    weight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    color: appTheme.textPrimary,
                  ),
                ),
                vGap(30.h),

                buildLabelTextField(
                  AppStrings.enterYourRole,
                  AppStrings.roleOfHelper,
                  _roleController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppStrings.pleaseEnterRole;
                    }
                    final emailRegex = RegExp(r'^[a-zA-Z\s-]+$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return AppStrings.enterValidRole;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                vGap(8.h),

                vGap(16.h),

                /// Phone number
                buildLabelTextField(
                  AppStrings.enterYourPhoneNumber,
                  AppStrings.phoneNumber,
                  _phoneController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppStrings.pleaseEnterPhoneNumber;
                    }
                    if (value.length > 10 || value.length < 10) {
                      return AppStrings.enterValidPhoneNumber;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),

                vGap(20.h),

                /// Live-in status
                CText(
                  AppStrings.liveInStatus,
                  size: 16.sp,
                  weight: FontWeight.w500,
                  color: appTheme.textPrimary,
                ),
                vGap(12.h),
                CustomRadioOption<LiveInStatus>(
                  value: LiveInStatus.liveIn,
                  groupValue: _liveInStatus,
                  onChanged: (val) => setState(() => _liveInStatus = val),
                  label: AppStrings.liveInHelper,
                ),
                vGap(12.h),
                CustomRadioOption<LiveInStatus>(
                  value: LiveInStatus.nonLiveIn,
                  groupValue: _liveInStatus,
                  onChanged: (val) => setState(() => _liveInStatus = val),
                  label: AppStrings.nonLiveInHelper,
                ),
                vGap(20.h),

                /// Setup profile
                Padding(
                  padding: EdgeInsets.only(right: 20.0.w),
                  child: CText(
                    AppStrings.wouldYouLikeToSetupHelperProfile,
                    size: 16.sp,
                    weight: FontWeight.w500,
                    color: appTheme.textPrimary,
                  ),
                ),
                vGap(12.h),
                CustomRadioOption<SetupProfile>(
                  value: SetupProfile.yes,
                  groupValue: _setupProfile,
                  onChanged: (val) => setState(() => _setupProfile = val),
                  label: AppStrings.yes,
                ),
                vGap(12.h),
                CustomRadioOption<SetupProfile>(
                  value: SetupProfile.no,
                  groupValue: _setupProfile,
                  onChanged: (val) => setState(() => _setupProfile = val),
                  label: AppStrings.noSkipForLater,
                ),
                vGap(24.h),

                /// Submit button
                CustomElevatedButton(
                  text: AppStrings.inviteViaCode,
                  height: 50.h,
                  width: double.infinity,
                  onPressed: () {
                    final details = {
                      "role": _roleController.text,
                      "phone": _phoneController.text,
                      "liveInStatus": _liveInStatus,
                      "setupProfile": _setupProfile,
                    };
                    Navigator.pop(context, details); // return entered values
                    showNoteDialog(context);
                  },
                  buttonTextStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Function to open bottom sheet
void showHelperDetailsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => const HelperDetailsBottomSheet(),
  );
}

Widget buildLabelTextField(
  String label,
  String labelText,
  TextEditingController controller, {
  FormFieldValidator<String>? validator,
  TextInputType? keyboardType,
}) {
  return TextFormField(
    controller: controller,
    readOnly: false,
    style: TextStyle(
      color: appTheme.grey,
      fontSize: 14.sp,
      fontFamily: "Poppins",
    ),
    keyboardType: keyboardType,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      // label  label,
      hintText: label,
      hintStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: appTheme.grey,
        // fontFamily: "Poppins",
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: appTheme.black,
        fontFamily: "PoppinsMedium",
      ),

      filled: true,
      fillColor: appTheme.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appTheme.offWhite, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appTheme.offWhite, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: appTheme.offWhite, width: 2),
      ),
    ),
    validator: validator,
  );
}
