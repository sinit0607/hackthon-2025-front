import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_color.dart';
import 'custom_text.dart';
import 'get_size.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu(
      {Key? key,
      required this.defaultValue,
      required this.values,
      required this.icon,
      required this.onItemSelected,
      required this.width})
      : super(key: key);
  final dynamic Function(String? selectedValue) onItemSelected;
  final String defaultValue;
  final double width;
  final Widget icon;
  final List<String> values;

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.width,
          height: H.h7(context),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.appWhite,
                border: Border.all(
                    color: AppColors.borderColor.withOpacity(0.5), width: 0.5)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: CommonText(
                  text: widget.defaultValue,
                  isPopins: true,
                  color: AppColors.borderColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                dropdownColor: AppColors.appWhite,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                isExpanded: true,
                isDense: true,
                icon: widget.icon,
                value: dropdownValue,
                items: widget.values.map((dropValue) {
                  return DropdownMenuItem<String>(
                    value: dropValue,
                    child: CommonText(
                      text: dropValue,
                      isPopins: true,
                      color: AppColors.borderColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                }).toList(),
                onChanged: (newDropdownValue) {
                  setState(() {
                    dropdownValue = newDropdownValue!;
                  });
                  widget.onItemSelected(newDropdownValue);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
