import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';
import 'custome_button.dart';
import 'get_size.dart';

class Button {
  appButton(context, String title, Function() onTap, {Color? color}) {
    return CustomButton(
      textColor: Colors.white,
      height: H.h7(context),
      width: MediaQuery.of(context).size.width - 35,
      borderColor: AppColors.appColor,
      gradiantColors: false,
      buttonColor: color ?? AppColors.appColor,
      onPress: onTap,
      buttonTitle: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
          color: color == null ? AppColors.appWhite : AppColors.appColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        )),
      ),
      borderRadius: 10,
    );
  }
}
