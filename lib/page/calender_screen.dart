import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_li_chi_tieu_ca_nhan/data/cash_flow_data.dart';
import 'package:table_calendar/table_calendar.dart';

import '../calender/calender_logic.dart';
import '../calender/calender_widget.dart';
import '../calender/summary_widget.dart';
import '../data/cash_flow_provider.dart';

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
  late int sum = 0;
  final CalendarLogic _calendarLogic = CalendarLogic(listData: data);
  late List<dynamic> incomeTransactions = [];
  late List<dynamic> expenseTransactions = [];
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      today = focusedDay;

      final event = _calendarLogic.getEventsForDay(selectedDay);

      selected['Income'] = event['Income']!;
      selected['Expense'] = event['Expense']!;

      sum = selected['Income']! - selected['Expense']!;

      // Lấy mảng Income hoặc Expense
      incomeTransactions = _calendarLogic.getTransactionsForDay(selectedDay, 'Income');
      expenseTransactions = _calendarLogic.getTransactionsForDay(selectedDay, 'Expense');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8eff8),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Thu chi theo ngày'),
      ),
      body: Column(
        children: [
          CalendarWidget(
            today: today,
            selectedDay: _selectedDay,
            calendarFormat: _calendarFormat,
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
          ),
          SummaryWidget(
            income: selected['Income']!,
            expense: selected['Expense']!,
            sum: sum,
          ),
          Expanded(
            child: Text('Danh sách thu', style: Theme.of(context).textTheme.titleMedium,),
            flex: 1,
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView.builder(
                itemCount: incomeTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = incomeTransactions[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${transaction['Category']}:',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${transaction['Amount']}₫',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Text('Danh sách chi', style: Theme.of(context).textTheme.titleMedium,),
            flex: 1,
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView.builder(
                itemCount: expenseTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = expenseTransactions[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: [
                      Text(
                        '${transaction['Category']}:',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${transaction['Amount']}₫',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

