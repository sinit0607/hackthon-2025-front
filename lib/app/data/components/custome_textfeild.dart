import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';
import 'get_size.dart';

class CommonTextField extends StatefulWidget {
  CommonTextField({
    super.key,
    this.controller,
    this.width,
    this.input,
    this.expand = false,
    this.label = '',
    this.maxLines,
    this.maxLength,
    this.fieldHeight = 45,
    this.borderRadius,
    this.borderColor,
    this.backGroundColor,
    required this.focusNode,
    this.hintText,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.initialValue,
    this.readOnly = false,
    this.suffix,
    this.prefixIcon,
    this.suffixVisibility = false,
    this.obscureText = false,
    this.validate,
    this.errorText,
    this.hintStyle,
    this.onSaved,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final TextInputType? input;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final String? label;
  final String? errorText;
  final Color? borderColor;
  final Color? backGroundColor;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? maxLength;
  final double fieldHeight;
  final double? width;
  final double? borderRadius;
  final FocusNode focusNode;
  final String? hintText;
  final TextStyle? hintStyle;
  final Function()? onTap;
  final String? initialValue;
  final bool readOnly;
  final bool expand;
  final Widget? suffix;
  bool suffixVisibility;
  bool obscureText;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  toggle() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.width ?? W.w100(context),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + (1) * 4),
        textInputAction: widget.textInputAction,
        validator: widget.validate,
        obscureText: widget.obscureText,
        readOnly: widget.readOnly,
        maxLength: widget.maxLength,
        cursorColor: AppColors.appWhite,
        controller: widget.controller,
        maxLines: widget.suffixVisibility == false
            ? (widget.expand == true ? null : widget.maxLines)
            : 1,
        keyboardType: widget.input,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        expands: widget.expand,
        onTap: widget.onTap,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.textCapitalization,
        style: GoogleFonts.poppins(color: AppColors.appWhite, fontSize: 18),
        decoration: InputDecoration(
          labelText: widget.hintText ?? "",
          labelStyle: widget.hintStyle,
          counterText: "",
          fillColor: AppColors.appColor,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.appWhite, width: 0.0),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.appWhite, width: 0.0),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.appRed, width: 2.0),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.appRed, width: 2.0),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          prefixIcon: widget.prefixIcon,
          errorText: widget.errorText,
          suffixIcon: (widget.suffixVisibility == true && widget.suffix == null)
              ? IconButton(
                  icon: widget.obscureText == true
                      ? Icon(
                          Icons.visibility,
                          color: AppColors.appWhite,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: AppColors.appWhite,
                        ),
                  // ? ImageIcon(
                  //     Image.asset(AppIcons.eyeIcon).image,
                  //     size: 20,
                  //     color: AppColors.appBlack.withOpacity(0.7),
                  //   )
                  // : ImageIcon(
                  //     Image.asset(AppIcons.closeEyeIcon).image,
                  //     size: 20,
                  //     color: AppColors.appBlack.withOpacity(0.7),
                  //   ),
                  onPressed: toggle)
              : widget.suffix,
        ),
      ),
    );
  }
}
