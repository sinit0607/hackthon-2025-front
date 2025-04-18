import 'package:flutter/material.dart';

import 'app_color.dart';
import 'get_size.dart';

class CustomButton extends StatelessWidget {
  final Widget buttonTitle;
  final Color buttonColor, textColor;
  final Color borderColor;
  final Function() onPress;
  final bool onPressDisabled;
  final List<Color>? gradiantColorsList;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool gradiantColors;

  const CustomButton({
    super.key,
    required this.buttonTitle,
    this.width,
    this.height,
    required this.borderRadius,
    this.gradiantColors = false,
    this.buttonColor = AppColors.appColor,
    this.textColor = Colors.white,
    this.borderColor = Colors.white,
    required this.onPress,
    this.gradiantColorsList,
    this.onPressDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressDisabled ? () {} : onPress,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? H.h3(context),
        decoration: gradiantColors
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: const Alignment(0.1, 0.0),
                  colors: gradiantColorsList?.length != 0
                      ? gradiantColorsList!
                      : <Color>[AppColors.appColor, AppColors.kTabBar],
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : BoxDecoration(
                color: buttonColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          child: Center(child: buttonTitle),
        ),
      ),
    );
  }
}
