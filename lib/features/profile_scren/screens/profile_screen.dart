import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/constants/image_constant.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';

import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_image_view.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedImage = useState<File?>(null);

    final emailController = useTextEditingController(
      text: 'sarah.johnson@example.com',
    );
    final phoneController = useTextEditingController(text: '+1 (555) 123-4567');
    final addressController = useTextEditingController(
      text: '123 Main Street Anytown, ST 12345',
    );
    final householdController = useTextEditingController(
      text: 'Household Name',
    );
    final planController = useTextEditingController(text: 'Premium Plan');

    final imagePicker = useMemoized(() => ImagePicker());
    Future<void> pickImage(ImageSource source) async {
      final XFile? image = await imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    }

    return Scaffold(
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
          SizedBox(
            height: SizeUtils.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 40,
                    ),
                    width: SizeUtils.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageConstant.profileBackground),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                AppNavigator.pop();
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: appTheme.white,
                                size: 20,
                              ),
                            ),
                            CText(
                              "Profile",
                              size: 18,
                              color: appTheme.white,
                              weight: FontWeight.bold,
                              fontFamily: "PoppinsMedium",
                            ),
                            SizedBox(width: 30),
                          ],
                        ),
                        SizedBox(height: 20),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              // _showImagePickerBottomSheet(context),
                              child: Container(
                                height: SizeUtils.width * 0.3,
                                width: SizeUtils.width * 0.3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        selectedImage.value != null
                                            ? FileImage(selectedImage.value!)
                                            : AssetImage(ImageConstant.profile)
                                                as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: appTheme.white),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -7.2,
                              bottom: 0,
                              // left: 0,
                              // top: 0,
                              child: IconButton(
                                onPressed: () {
                                  _showImagePickerBottomSheet(
                                    context: context,
                                    onPickCamera:
                                        () => pickImage(ImageSource.camera),
                                    onPickGallery:
                                        () => pickImage(ImageSource.gallery),
                                  );
                                },
                                icon: CustomImageView(
                                  imagePath: ImageConstant.editIcon,
                                  height: 32,
                                  width: 32,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CText(
                          "Maria Johnson",
                          size: 16,
                          color: appTheme.white,
                          weight: FontWeight.bold,
                          fontFamily: "PoppinsMedium",
                        ),
                        SizedBox(height: 5),
                        CText(
                          "Homeowner",
                          size: 14,
                          color: appTheme.offWhite,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CText(
                              "Personal Details",
                              size: 18,
                              weight: FontWeight.bold,
                              // fontFamily: "PoppinsMedium",
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        buildTextField("email", emailController),
                        SizedBox(height: 20),
                        buildTextField("phone", phoneController),
                        SizedBox(height: 20),
                        buildTextField("address", addressController),
                        SizedBox(height: 20),
                        buildTextField("houseHoldName", householdController),
                        SizedBox(height: 20),
                        buildTextField("plan", planController),
                        vGap(35.h),
                        CustomElevatedButton(
                          text: 'Updates Profile',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: false,
      style: TextStyle(
        color: appTheme.grey,
        fontSize: 14,
        fontFamily: "Poppins",
      ),
      decoration: InputDecoration(
        // label  label,
        filled: true,
        fillColor: appTheme.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appTheme.offWhite),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appTheme.offWhite),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appTheme.offWhite),
        ),
      ),
    );
  }

  void _showImagePickerBottomSheet({
    required BuildContext context,
    required VoidCallback onPickCamera,
    required VoidCallback onPickGallery,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: appTheme.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    CText(
                      "Select Profile Photo",
                      size: 18,
                      weight: FontWeight.bold,
                      color: appTheme.textPrimary,
                    ),
                    SizedBox(height: 20),

                    // Camera option
                    _buildImagePickerOption(
                      icon: Icons.camera_alt,
                      title: "Take Photo",
                      subtitle: "Use camera to take a new photo",
                      onTap: () async {
                        Navigator.pop(context);
                        onPickCamera();
                      },
                    ),

                    SizedBox(height: 12),

                    // Gallery option
                    _buildImagePickerOption(
                      icon: Icons.photo_library,
                      title: "Choose from Gallery",
                      subtitle: "Select photo from your gallery",
                      onTap: () async {
                        Navigator.pop(context);
                        onPickGallery();
                      },
                    ),

                    SizedBox(height: 12),

                    // Remove photo option (only show if image is selected)
                    // Consumer<ProfileProvider>(
                    //   builder: (context, provider, child) {
                    //     if (provider.selectedImage != null) {
                    //       return _buildImagePickerOption(
                    //         icon: Icons.delete,
                    //         title: "Remove Photo",
                    //         subtitle: "Remove current profile photo",
                    //         iconColor: appTheme.darkRed,
                    //         onTap: () {
                    //           Navigator.pop(context);
                    //           provider.removeSelectedImage();
                    //         },
                    //       );
                    //     }
                    //     return SizedBox.shrink();
                    //   },
                    // ),
                    // SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImagePickerOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: appTheme.veryLightGrey.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: appTheme.veryLightGrey),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (iconColor ?? appTheme.primaryColor).withValues(
                  alpha: 0.1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor ?? appTheme.primaryColor,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    title,
                    size: 16,
                    weight: FontWeight.w600,
                    color: appTheme.textPrimary,
                  ),
                  SizedBox(height: 4),
                  CText(subtitle, size: 12, color: appTheme.grey),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: appTheme.grey),
          ],
        ),
      ),
    );
  }
}
