import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class CommonText extends StatelessWidget {
  final String text;
  final bool isPopins;
  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final int maxLines;
  final bool softWrap;

  const CommonText({
    super.key,
    required this.text,
    this.color = AppColors.appWhite,
    this.textAlign = TextAlign.center,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.isPopins = true,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isPopins == true) {
      return Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        style: GoogleFonts.jost(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      );
    } else {
      return Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        style: GoogleFonts.jost(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      );
    }
  }
}
