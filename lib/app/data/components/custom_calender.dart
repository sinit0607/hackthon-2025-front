import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'app_color.dart';
import 'get_size.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();
  final List<DateTime> _eventDates = [
    DateTime(2024, 3, 30)
  ]; // Example event date

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.appColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(
            height: H.h2(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildWeekDays(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildDays(),
          ),
          SizedBox(
            height: H.h2(context),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final monthYearFormat = DateFormat('MMMM yyyy');
    final formattedDate = monthYearFormat.format(_currentMonth);

    return Container(
      decoration: const BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.appWhite,
            ),
            onPressed: _currentMonth.isAfter(DateTime.now())
                ? () {
                    setState(() {
                      _currentMonth =
                          DateTime(_currentMonth.year, _currentMonth.month - 1);
                    });
                  }
                : null,
          ),
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 20, color: AppColors.appWhite),
          ),
          IconButton(
            icon:
                const Icon(Icons.arrow_forward_ios, color: AppColors.appWhite),
            onPressed: () {
              setState(() {
                _currentMonth =
                    DateTime(_currentMonth.year, _currentMonth.month + 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    final List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays
          .map(
            (day) => SizedBox(
              width: 30,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.appColor),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDays() {
    final List<Widget> rows = [];
    const int daysInWeek = 7;
    final int monthLength =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final int startingWeekday =
        DateTime(_currentMonth.year, _currentMonth.month, 1).weekday;
    int currentDay = 1;

    for (int i = 0; i < (monthLength + startingWeekday - 1) / daysInWeek; i++) {
      List<Widget> days = [];
      for (int j = 0; j < daysInWeek; j++) {
        if ((i == 0 && j < startingWeekday - 1) || currentDay > monthLength) {
          // Add an empty SizedBox if it's before the start of the month or after the end of the month
          days.add(
            const SizedBox(width: 30),
          );
        } else {
          final DateTime currentDate =
              DateTime(_currentMonth.year, _currentMonth.month, currentDay);
          final bool isSelectable = currentDate.isAfter(DateTime.now()) ||
              currentDate.isAtSameMomentAs(DateTime.now());
          final bool hasEvent = _eventDates.contains(currentDate);

          days.add(
            GestureDetector(
              onTap: isSelectable
                  ? () {
                      if (hasEvent) {
                        setState(() {
                          _selectedDate = currentDate;
                        });
                        _showEventDetails(currentDate);
                      } else {
                        setState(() {
                          _selectedDate = currentDate;
                        });
                      }
                    }
                  : null, // Disable onTap if the date is not selectable
              child: Stack(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: _selectedDate.day == currentDay
                          ? AppColors.appColor
                          : null,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      currentDay.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: _selectedDate.day == currentDay
                              ? AppColors.appWhite
                              : AppColors.secondaryAppColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                  if (hasEvent)
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Icon(
                        Icons.circle,
                        color: AppColors.secondaryAppColor,
                        size: 10,
                      ),
                    ),
                ],
              ),
            ),
          );
          currentDay++;
        }
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days,
      ));
    }
    return Column(children: rows);
  }

  void _showEventDetails(DateTime date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Event Details'),
          content: Text('Event on ${DateFormat('MMMM dd, yyyy').format(date)}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
