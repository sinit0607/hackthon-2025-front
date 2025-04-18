import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../components/Helpers/shared_pref_helper.dart';
import 'app_color.dart';


class Config {
}

SharedPref sharedPref = sl<SharedPref>();


String? kToken;

String dayFormatConverterWithAt(String day) {
  var dateFormat = DateFormat("dd-MM-yyyy hh:mm aa");
  var utcDate =
      dateFormat.format(DateTime.parse(day)); // pass the UTC time here
  var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
  var output = DateFormat('dd MMM, yy').format(DateTime.parse(localDate));
  var output2 = DateFormat('hh:mm a').format(DateTime.parse(localDate));
  var output3 = "$output at $output2";
  return output3;
}

String dayFormatConverter(String day) {
  var dateFormat =
      DateFormat("dd-MM-yyyy hh:mm aa"); // you can change the format here
  var utcDate =
      dateFormat.format(DateTime.parse(day)); // pass the UTC time here
  var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
  var output =
      DateFormat('dd MMM, yy hh:mm a').format(DateTime.parse(localDate));
  return output;
}


TextStyle buildCommonStyle() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: AppColors.appWhite,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  );
}