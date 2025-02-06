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
  late final CalendarLogic _calendarLogic;
  List<CashFlowData> incomeTransactions = [];
  List<CashFlowData> expenseTransactions = [];
  final provider = CashFlowProvider();

  @override
  void initState() {
    _calendarLogic = CalendarLogic(listData: provider.cashFlowData);
    _onDaySelected(
      DateTime.now(),
    );
    super.initState();
  }

  void _onDaySelected(
    DateTime selectedDay,
  ) {
    setState(() {
      final event = _calendarLogic.getEventsForDay(selectedDay);

      selected['Income'] = event['Income']!;
      selected['Expense'] = event['Expense']!;

      sum = selected['Income']! - selected['Expense']!;

      // Lấy mảng Income hoặc Expense
      incomeTransactions = _calendarLogic.getTransactionsForDay(
          selectedDay, Transactions.income);
      expenseTransactions = _calendarLogic.getTransactionsForDay(
          selectedDay, Transactions.expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CashFlowProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xfff8eff8),
          appBar: AppBar(
            centerTitle: false,
            title: const Text('Thu chi theo ngày'),
          ),
          body: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                CalendarWidget(
                  focusDay: today,
                  selectedDay: _selectedDay ?? today,
                  calendarFormat: _calendarFormat,
                  onDaySelected: (_, date) {
                    _selectedDay = date;
                    _onDaySelected(_selectedDay ?? DateTime.now());
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
                ),
                SummaryWidget(
                  income: selected['Income']!,
                  expense: selected['Expense']!,
                  sum: sum,
                ),
                if (incomeTransactions.isNotEmpty)
                  Text(
                    'Danh sách thu',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: incomeTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = incomeTransactions[index];
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${transaction.category.description}:',
                              style: const TextStyle(
                                color: Colors.brown,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${transaction.amount}₫',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          removeIcon(
                            context,
                            transaction,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                if (expenseTransactions.isNotEmpty)
                  Text(
                    'Danh sách chi',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: expenseTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = expenseTransactions[index];
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${transaction.category.description}:',
                              style: const TextStyle(
                                color: Colors.brown,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${transaction.amount}₫',
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          removeIcon(
                            context,
                            transaction,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget removeIcon(
      BuildContext context,
      CashFlowData transaction,
      ) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Thông báo'),
                content: Text('Bạn chắc chắn muốn xóa giao dịch này?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Hủy'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<CashFlowProvider>(context, listen: false)
                          .removeTransaction(transaction);
                      _onDaySelected(_selectedDay ?? DateTime.now());
                      Navigator.pop(context);
                    },
                    child: Text("Xóa"),
                  ),
                ],
              );
            });
        // provider.removeTransaction(transaction);
      },
      icon: const Icon(
        Icons.delete,
        color: Color(0xff743a3a),
        size: 20,
      ),
    );
  }

}
