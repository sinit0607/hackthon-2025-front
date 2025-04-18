import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.onItemSelected, required this.child});
  final dynamic Function(DateTime? selectedValue) onItemSelected;

  final Widget child;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime selectedDateValue;

  @override
  void initState() {
    super.initState();
    selectedDateValue = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDateValue,
              firstDate: DateTime(1900, 8),
              lastDate: DateTime(2101),
          );
          if (picked != null && picked != selectedDateValue) {
            setState(() {
              selectedDateValue = picked;
            });
            widget.onItemSelected(selectedDateValue);
          }
        },
        child: widget.child);
  }
}
