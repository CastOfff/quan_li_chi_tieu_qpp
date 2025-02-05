import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime focusDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;

  const CalendarWidget({
    Key? key,
    required this.focusDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  }) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TableCalendar(
        focusedDay: selectedDay??focusDay,
        firstDay: DateTime.utc(2025),
        lastDay: DateTime(2026),
        headerVisible: true,
        calendarFormat: calendarFormat,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,
        onFormatChanged: onFormatChanged,
        onPageChanged: onPageChanged,
      ),
    );
  }
}