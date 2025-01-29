import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu_ca_nhan/data/cash_flow_data.dart';
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
  Map<String, int> selected = {'Income': 0, 'Expense': 0};
  final List<Map<String, dynamic>> _events = CashFlowData;
  late int sum = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      today = focusedDay;

      // Tìm sự kiện phù hợp với ngày được chọn
      final event = _events.firstWhere(
            (event) {
          final eventDate = event['Date'] as DateTime;
          return eventDate.year == selectedDay.year &&
              eventDate.month == selectedDay.month &&
              eventDate.day == selectedDay.day;
        },
        orElse: () => {'Income': 0, 'Expense': 0}, // Nếu không tìm thấy, trả về giá trị mặc định
      );

      // Cập nhật giá trị selected
      selected['Income'] = event['Income'];
      selected['Expense'] = event['Expense'];

      sum = selected['Income']! - selected['Expense']!;
    });
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

              onDaySelected: _onDaySelected,

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
              // calendarBuilders: CalendarBuilders(
              //   // TODO: điều chỉnh sự kiện trong ô ngày
              //   defaultBuilder: (context, day, forcusedDay) {
              //     final normalizedDay = DateTime(day.year, day.month, day.day);
              //     final events = _events.where((event) {
              //       final eventDate = event['Date'] as DateTime; // Lấy ngày từ sự kiện
              //       return eventDate.year == normalizedDay.year &&
              //           eventDate.month == normalizedDay.month &&
              //           eventDate.day == normalizedDay.day;
              //     }).map((event) {
              //       return {
              //         'Income': event['Income'],
              //         'Expense': event['Expense'],
              //       };
              //     }).toList();
              //     return Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           '${day.day}',
              //           //style: Theme.of(context).textTheme.bodySmall,
              //         ),
              //         if (events.isNotEmpty)
              //           ...events.map((events)
              //           => Text(
              //               '$events.000',
              //             style: Theme.of(context).textTheme.bodySmall,
              //           ),
              //           ).toList(),
              //       ],
              //     );
              //   }
              // ),
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
                    Text('${selected['Income']}₫',
                      style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                        color: Colors.blue
                    ),)
                  ],
                ),
                Column(
                  children: [
                    const Text('Tiền chi'),
                    Text('${selected['Expense']}₫',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      ),)
                  ],
                ),
                Column(
                  children: [
                    const Text('Tổng'),
                    Text('$sum₫',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: sum > 0 ? Colors.blue : Colors.red
                      ),)
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
