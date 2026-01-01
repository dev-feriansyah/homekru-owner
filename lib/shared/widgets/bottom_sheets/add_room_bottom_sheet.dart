import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/common_utils.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';
import 'package:homekru_owner/shared/widgets/custom_elevated_button.dart';
import 'package:homekru_owner/shared/widgets/custom_text.dart';

class AddRoomBottomSheet extends StatefulWidget {
  const AddRoomBottomSheet({super.key});

  @override
  State<AddRoomBottomSheet> createState() => _AddRoomBottomSheetState();
}

class _AddRoomBottomSheetState extends State<AddRoomBottomSheet> {
  final TextEditingController _roomNameController = TextEditingController();
  String selectedRoomType = "Bedroom";

  final List<String> roomTypes = [
    "Bedroom",
    "Kitchen",
    "Bathroom",
    "Dining room",
    "Drawing room",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40.h,
                width: 1.sw,
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
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle bar
                    vGap(20.h),

                    // Title
                    Center(
                      child: CText(
                        "Add Room",
                        size: 20.sp,
                        weight: FontWeight.w600,
                        color: appTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Room name section
                    CText(
                      "Room name",
                      size: 18.sp,
                      weight: FontWeight.w600,
                      color: appTheme.textPrimary,
                    ),
                    vGap(2.h),

                    CText(
                      "You can select room type or enter a custom room type to add.",
                      size: 16.sp,
                      color: appTheme.grey,
                      weight: FontWeight.w400,
                      // height: 1.4,
                    ),
                    vGap(15.h),

                    // Text field for room name
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: appTheme.white,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: appTheme.offWhite),
                        boxShadow: [
                          BoxShadow(
                            color: appTheme.offWhite,
                            blurRadius: 10.r,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _roomNameController,
                        decoration: InputDecoration(
                          hintText: selectedRoomType,
                          hintStyle: TextStyle(
                            color: appTheme.grey,
                            fontSize: 16.sp,
                            fontFamily: "Poppins",
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: "Poppins",
                          color: appTheme.grey,
                        ),
                      ),
                    ),
                    vGap(20.h),

                    // Room type chips
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children:
                          roomTypes.map((roomType) {
                            final isSelected = selectedRoomType == roomType;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedRoomType = roomType;
                                  _roomNameController.text = roomType;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? appTheme.blueAccentCustom
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(9.r),
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? appTheme.blueAccentCustom
                                            : appTheme.blueAccentCustom,
                                    width: 1.0,
                                  ),
                                ),
                                child: CText(
                                  roomType,
                                  size: 14.sp,
                                  color:
                                      isSelected
                                          ? appTheme.white
                                          : appTheme.blueAccentCustom,
                                  weight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    vGap(30.h),

                    // Save button
                    CustomElevatedButton(
                      text: "Save",
                      height: 48.h,
                      onPressed: () {
                        // Handle save logic here
                        Navigator.pop(context, {
                          'roomName':
                              _roomNameController.text.isEmpty
                                  ? selectedRoomType
                                  : _roomNameController.text,
                          'roomType': selectedRoomType,
                        });
                      },
                    ),
                    vGap(30.h), // Bottom padding for safe area
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    super.dispose();
  }
}

// Helper function to show the bottom sheet
Future<Map<String, String>?> showAddRoomBottomSheet(BuildContext context) {
  return showModalBottomSheet<Map<String, String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddRoomBottomSheet(),
        ),
  );
}
// ---- Add Room Bottom Sheet ----
// Future<Map<String, String>?> showAddRoomBottomSheet(BuildContext context) {
//   return showModalBottomSheet<Map<String, String>?>(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => const AddRoomBottomSheet(),
//   );
// }

// class AddRoomBottomSheet extends StatefulWidget {
//   const AddRoomBottomSheet({super.key});

//   @override
//   State<AddRoomBottomSheet> createState() => _AddRoomBottomSheetState();
// }

// class _AddRoomBottomSheetState extends State<AddRoomBottomSheet> {
//   final TextEditingController roomController = TextEditingController();
//   final TextEditingController sowController = TextEditingController();

//   String? selectedRoom;

//   final List<String> roomTypes = [
//     "Bedroom",
//     "Kitchen",
//     "Bathroom",
//     "Dining room",
//     "Drawing room",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Handle bar
//             Center(
//               child: Container(
//                 width: 60.w,
//                 height: 4.h,
//                 margin: EdgeInsets.only(bottom: 16.h),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(4.r),
//                 ),
//               ),
//             ),

//             Center(
//               child: CText(
//                 "Add Room",
//                 size: 18.sp,
//                 weight: FontWeight.w600,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 20.h),

//             CText("Room name", size: 16.sp, weight: FontWeight.w600),
//             CText(
//               "You can select room type or enter a custom room type to add.",
//               size: 13.sp,
//               color: appTheme.grey,
//             ),
//             SizedBox(height: 10.h),

//             TextField(
//               controller: roomController,
//               decoration: InputDecoration(
//                 hintText: "Bedroom",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 12.w,
//                   vertical: 12.h,
//                 ),
//               ),
//             ),
//             SizedBox(height: 12.h),

//             Wrap(
//               spacing: 8.w,
//               runSpacing: 8.h,
//               children:
//                   roomTypes.map((room) {
//                     return CustomRadioOption<String>(
//                       value: room,
//                       groupValue: selectedRoom,
//                       label: room,
//                       onChanged: (val) {
//                         setState(() {
//                           selectedRoom = val;
//                           roomController.text = val!;
//                         });
//                       },
//                     );
//                   }).toList(),
//             ),

//             SizedBox(height: 20.h),

//             CText("Scope of work", size: 16.sp, weight: FontWeight.w600),
//             CText(
//               'Enter the scope of work for the room in 2 words like "Floor cleaning" or "Dry mopping".',
//               size: 13.sp,
//               color: appTheme.grey,
//             ),
//             SizedBox(height: 10.h),

//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: sowController,
//                     decoration: InputDecoration(
//                       hintText: "Enter SOW",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: 12.w,
//                         vertical: 12.h,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10.w),
//                 Container(
//                   height: 48.h,
//                   width: 48.h,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: appTheme.grey),
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: Icon(Icons.add, color: appTheme.grey),
//                 ),
//               ],
//             ),

//             SizedBox(height: 24.h),

//             CustomElevatedButton(
//               text: "Save",
//               onPressed: () {
//                 // Handle save action
//                 Navigator.pop(context, {
//                   "room": roomController.text,
//                   "sow": sowController.text,
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
