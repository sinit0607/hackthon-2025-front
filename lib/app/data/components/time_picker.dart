import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  const TimePicker(
      {super.key, required this.onItemSelected, required this.child});

  final dynamic Function(String? selectedValue) onItemSelected;

  final Widget child;

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: selectedTime,
              builder: (BuildContext context, Widget? child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child!,
                );
              });

          if (pickedTime != null && pickedTime != selectedTime) {
            setState(() {
              selectedTime = pickedTime;
            });
            widget.onItemSelected(formatTimeOfDay(selectedTime));
          }
        },
        child: widget.child);
  }
  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final time = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formatter = DateFormat.jm(); // jm format represents "hh:mm a"
    return formatter.format(time);
  }
}
