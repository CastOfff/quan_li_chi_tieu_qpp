import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_li_chi_tieu_ca_nhan/calender/calender_logic.dart';

import '../data/cash_flow_provider.dart';

class ReportPageSecond extends StatefulWidget {
  const ReportPageSecond({super.key});

  @override
  State<ReportPageSecond> createState() => _ReportPageSecondState();
}

class _ReportPageSecondState extends State<ReportPageSecond> {
  DateTime selectedMonth = DateTime.now();
  int totalIncome = 0;
  int totalExpense = 0;
  int balance = 0;
  final provider = CashFlowProvider();
  late final calendarLogic;

  @override
  void initState() {
    calendarLogic = CalendarLogic(listData: provider.cashFlowData);
    updateFocusedMonth(DateTime.now());
    super.initState();
  }

  ///SET STATE
  void updateFocusedMonth(DateTime newMonth) {
    setState(() {
      selectedMonth = newMonth;
      final monthlyCashFlow = calendarLogic.calculateMonthlyCashFlow(
          provider.cashFlowData, selectedMonth);
      totalIncome = monthlyCashFlow['Income']!;
      totalExpense = monthlyCashFlow['Expense']!;
      balance = monthlyCashFlow['Balance']!;
    });
  }

  /// BUILD
  @override
  Widget build(BuildContext context) {
    return Consumer<CashFlowProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Báo cáo'),
            ),
            body: Column(
              children: [
                MonthPicked(
                  focusedMonth: selectedMonth,
                  onMonthChanged: updateFocusedMonth,
                ),
                Text('month: ${selectedMonth.month}'),
                Text(
                    'lastest expense: ${provider.cashFlowData.data[provider.cashFlowData.data.length - 1].amount}'),
                Text('totalIncome: $totalIncome'),
                Text('totalExpense: $totalExpense'),
                Text('balance: $balance')
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                updateFocusedMonth(selectedMonth);
              },
              child: const Icon(Icons.refresh),
            ),
          );
        });
  }
}

/// Hàm hiển thị lịch chọn tháng
class MonthPicked extends StatefulWidget {
  final DateTime focusedMonth;
  final Function(DateTime) onMonthChanged;

  const MonthPicked({
    super.key,
    required this.focusedMonth,
    required this.onMonthChanged,
  });

  @override
  State<MonthPicked> createState() => _MonthPickedState();
}

class _MonthPickedState extends State<MonthPicked> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final DateTime? picked = await showMonthYearPicker(
              context: context,
              initialDate: widget.focusedMonth,
              firstDate: DateTime(2025),
              lastDate: DateTime(2026),
            );
            if (picked != null && picked != widget.focusedMonth) {
              widget.onMonthChanged(picked);
            }
          },
          icon: const Icon(Icons.calendar_month_outlined),
        ),
      ],
    );
  }
}

/// Hàm tính tổng các chi tiêu trong tháng
// class CategoryCashFlowInMonth {
//   ListData listData;
//   DateTime selectedMonth;
//   CategoryCashFlowInMonth({required this.listData, required this.selectedMonth});
//
//   Map<CategoryType, int> calculateCategoryCashFlowInMonth() {
//
//   }
// }
