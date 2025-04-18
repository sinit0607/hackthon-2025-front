// /*
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:go_restro/app/data/components/app_color.dart';
// import 'package:go_restro/app/data/components/app_icons_path.dart';
// import 'package:lottie/lottie.dart';
//
// import 'custom_text.dart';
// import 'get_size.dart';
//
// class LoaderController extends GetxController {
//   void showCircularProgressLottie(bool isLoading) {
//     AlertDialog dialog = AlertDialog(
//       backgroundColor: Colors.transparent,
//       contentPadding: EdgeInsets.zero,
//       elevation: 0.0,
//       content: Center(
//         child: Lottie.asset(AppIcons.loader),
//       ),
//     );
//
//     if (!isLoading) {
//       Get.back();
//     } else {
//       Get.dialog(dialog, barrierDismissible: true);
//     }
//   }
//
//   showConfirmationBottomSheet({
//     required BuildContext context,
//     required String title,
//     required String confirmText,
//     required Function() success,
//     Color? iconColor,
//     required Widget? centerWidget,
//     Color? buttonColor,
//     Color? buttonBorderColor,
//     Color? outLineButtonTextColor,
//     Color? buttonTextColor,
//   }) {
//     return Get.dialog(Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(25),
//             child: Container(
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                   color: AppColors.appWhite,
//                   borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: H.h3(context),
//                   ),
//                   Center(child: centerWidget),
//                   SizedBox(
//                     height: H.h3(context),
//                   ),
//                   CommonText(
//                     isPopins: true,
//                     text: title,
//                     fontSize: 18,
//                     maxLines: 2,
//                     textAlign: TextAlign.center,
//                     color: AppColors.appBlack,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   SizedBox(
//                     height: H.h3(context),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: success,
//                             child: Container(
//                               height: 50,
//                               padding: const EdgeInsets.all(10),
//                               width: double.infinity,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: AppColors.appColor,
//                                 border: Border.all(color: AppColors.appColor),
//                                 borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     bottomLeft: Radius.circular(10)),
//                               ),
//                               child: CommonText(
//                                 isPopins: true,
//                                 text: confirmText,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColors.appWhite,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                               height: 50,
//                               padding: const EdgeInsets.all(10),
//                               width: double.infinity,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color:
//                                         AppColors.borderColor.withOpacity(0.4)),
//                                 borderRadius: const BorderRadius.only(
//                                     topRight: Radius.circular(10),
//                                     bottomRight: Radius.circular(10)),
//                               ),
//                               child: const CommonText(
//                                 text: "Cancel",
//                                 isPopins: true,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColors.appBlack,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: H.h1(context),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }
// */
