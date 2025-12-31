import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';
import 'package:homekru_owner/shared/widgets/textfield/custom_text_form_field.dart';

final formKey = GlobalKey<FormState>();
void scopeOfWorkPopup(context) {
  // State variables declared outside StatefulBuilder to persist across rebuilds
  TextEditingController scopeOfWorkController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 30),
        child: StatefulBuilder(
          builder: (context, setState) {
            // Create controller and set its text if we have a selected time

            return Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appTheme.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      hGap(42),
                      Expanded(
                        child: CText(
                          "Scope of Work",
                          textAlign: TextAlign.start,
                          size: 18.sp,
                          weight: FontWeight.w600,
                          color: appTheme.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // NavigatorService.goBack();
                          AppNavigator.pop();
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: appTheme.lightBlueTwo,
                          child: Icon(
                            Icons.close,
                            color: appTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  vGap(20),

                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          hintText: "Enter scope of work",
                          controller: scopeOfWorkController,
                          onChanged: (value) {
                            setState(() {
                              scopeOfWorkController.text = value;
                            });
                          },
                        ),
                        vGap(15),
                        CText(
                          "Already added",
                          textAlign: TextAlign.start,
                          size: 14.sp,
                          weight: FontWeight.w600,
                          color: appTheme.textPrimary,
                        ),
                        TaskChips(
                          tasks: [
                            "Clean room",
                            "Dusting",
                            "Dusting",
                            "Clean room",
                          ],
                        ),

                        // Container(
                        //   // padding: const EdgeInsets.symmetric(
                        //   //   horizontal: 10,
                        //   //   vertical: 5,
                        //   // ),
                        //   decoration: ShapeDecoration(
                        //     color: appTheme.white,
                        //     shape: RoundedRectangleBorder(
                        //       side: BorderSide(
                        //         width: 1,
                        //         color: appTheme.primaryColor,
                        //       ),
                        //       borderRadius: BorderRadius.circular(9),
                        //     ),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //       top: 8.0,
                        //       left: 8.0,
                        //       bottom: 8.0,
                        //     ),
                        //     child: Stack(
                        //       children: [
                        //         Positioned(
                        //           right: 0,
                        //           top: 0,
                        //           child: Icon(
                        //             Icons.close,
                        //             size: 18.sp,
                        //             color: appTheme.primaryColor,
                        //           ),
                        //         ),

                        //         Padding(
                        //           padding: const EdgeInsets.only(
                        //             top: 8.0,
                        //             right: 8.0,
                        //           ),
                        //           child: CText(
                        //             'Clean room ',
                        //             textAlign: TextAlign.center,
                        //             size: 14.sp,
                        //             weight: FontWeight.w500,
                        //             color: appTheme.primaryColor,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        vGap(15),
                      ],
                    ),
                  ),

                  vGap(15),
                  CustomElevatedButton(
                    text: "Save",
                    onPressed: () {
                      AppNavigator.pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

class TaskChips extends StatelessWidget {
  final List<String> tasks;

  const TaskChips({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      // runSpacing: 2,
      children:
          tasks
              .map(
                (task) => Chip(
                  padding: EdgeInsets.all(0),
                  backgroundColor: appTheme.white,
                  label: CText(
                    task,
                    size: 16.sp,
                    color: appTheme.primaryColor,
                    weight: FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: appTheme.primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  deleteIcon: Icon(
                    Icons.close,
                    size: 18.sp,
                    color: appTheme.primaryColor,
                  ),
                  onDeleted: () {
                    // handle delete action here
                  },
                ),
              )
              .toList(),
    );
  }
}
