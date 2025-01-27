import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime today = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<String>> _events = {
    DateTime(2025, 1, 27): ['100'],
    DateTime(2025, 2, 5): ['200'],
    DateTime(2025, 2, 10): ['300'],
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8eff8),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Lịch'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TableCalendar(
                focusedDay: today,
                firstDay: DateTime.utc(2025),
                lastDay: DateTime(2026),
              headerVisible: true,
              calendarFormat: _calendarFormat,

              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },

              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  today = focusedDay;
                });
              },

              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                  setState(() {
                    today = focusedDay;
                  });
              },
              // eventLoader: (day) {
              //   return _events[day] ?? [];
              // },
              calendarBuilders: CalendarBuilders(
                // TODO: điều chỉnh sự kiện trong ô ngày
                defaultBuilder: (context, day, forcusedDay) {
                  final normalizedDay = DateTime(day.year, day.month, day.day);
                  final events = _events[normalizedDay] ?? [];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${day.day}',
                        //style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (events.isNotEmpty)
                        ...events.map((events)
                        => Text(
                            '$events.000',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        ).toList(),
                    ],
                  );
                }
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Tiền thu'),
                    Text('money')
                  ],
                ),
                Column(
                  children: [
                    const Text('Tiền chi'),
                    Text('money')
                  ],
                ),
                Column(
                  children: [
                    const Text('Tổng'),
                    Text('money')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
