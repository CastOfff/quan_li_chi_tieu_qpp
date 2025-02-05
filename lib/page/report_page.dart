import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../calender/calender_logic.dart';
import '../calender/summary_widget.dart';
import '../data/cash_flow_data.dart';
import '../data/cash_flow_provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Báo cáo'),
      ),
      body:Column(
        children: [
          PieChartSample1(),
        ],
      ),
    );
  }
}

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex = -1;

  late String day;
  late String month;
  late String year;
  late String weekday;

  late TextEditingController _dateController;

  late final CashFlowProvider provider;
  @override
  void initState() {
    provider = context.read<CashFlowProvider>();
    _calendarLogic = CalendarLogic(listData: provider.cashFlowData);
    _getDateTime();
    getData();
    _dateController = TextEditingController(text: '$month/$year');
    super.initState();
  }

  void _getDateTime([DateTime? date]) {
    date ??= DateTime.now();

    day = date.day.toString();
    month = date.month.toString();
    year = date.year.toString();

    List<String> daysOfWeek = [
      'Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy'
    ];
    weekday = daysOfWeek[date.weekday % 7];
  }

  Future<void> _selectDate() async {
    final DateTime currentDate = DateTime(int.parse(year), int.parse(month),int.parse(day));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),

    );

    if (picked != null && picked != currentDate) {
      setState(() {
        _getDateTime(picked);
        _dateController.text = '$month/$year';
        getData();
      });
    }
  }

  void getData() {
    _onDaySelected(DateTime.now(),DateTime.now());
  }

  DateTime today = DateTime.now();
  DateTime? _selectedDay;
  Map<String, int> selected = {'Income': 0, 'Expense': 0};
  late int sum = 0;
  late final CalendarLogic _calendarLogic;
  List<CashFlowData> incomeTransactions = [];
  List<CashFlowData> expenseTransactions = [];

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      today = focusedDay;

      final event = _calendarLogic.getEventsForMonth(selectedDay);

      selected['Income'] = event['Income']!;
      selected['Expense'] = event['Expense']!;

      sum = selected['Income']! - selected['Expense']!;

      // Lấy mảng Income hoặc Expense
      incomeTransactions = _calendarLogic.getTransactionsForMonth(selectedDay, Transactions.income);
      expenseTransactions = _calendarLogic.getTransactionsForMonth(selectedDay, Transactions.expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          monthBox(),
          pieChart(),
          dataField(),
        ],
      ),
    );
  }

  Widget monthBox() {
    return Container(
      padding: const EdgeInsets.only(
          right: 20,
          left: 20
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xfffff1ec),
      ),
      width: 250,
      child: TextFormField(
        controller: _dateController,
        readOnly: true,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          suffixIcon: GestureDetector(
            onTap: _selectDate,
            child: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.deepOrange,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget pieChart() {
    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = pieTouchResponse
                    .touchedSection!.touchedSectionIndex;
              });
            },
          ),
          startDegreeOffset: 180,
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 1,
          centerSpaceRadius: 0,
          sections: showingSections(),
        ),
      ),
    );
  }

  Widget dataField() {
    List<CashFlowData> data = _calendarLogic.getTop4TransactionsByCategory(DateTime.now(),);
    return Column(
      children: [
        SummaryWidget(
          income: selected['Income']!,
          expense: selected['Expense']!,
          sum: sum,
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index].date.toString()),
              subtitle: Text(data[index].category.description),
              trailing: Text(data[index].amount.toString()),
            );
          },
          itemCount: data.length,
          shrinkWrap: true,
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    double badgeOffset = 1.2;
    return List.generate(
      5,
          (i) {
        final isTouched = i == touchedIndex;
        const color0 = Colors.blue;
        const color1 = Colors.yellow;
        const color2 = Colors.pink;
        const color3 = Colors.green;
        const color4 = Colors.black;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 25,
              showTitle: false,
              badgeWidget: Text('data', style: TextStyle(
                  color: color0,
                  fontSize: 16
              ),),
              radius: 80,
              badgePositionPercentageOffset: badgeOffset,
              borderSide: isTouched
                  ? const BorderSide(
                  color: Colors.white, width: 6)
                  : BorderSide(
                  color: Colors.white.withValues(alpha: 0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: 25,
              showTitle: false,
              badgeWidget: Text('data', style: TextStyle(
                  color: color1,
                  fontSize: 16
              ),),
              radius: 80,
              badgePositionPercentageOffset: badgeOffset,
              borderSide: isTouched
                  ? const BorderSide(
                  color: Colors.white, width: 6)
                  : BorderSide(
                  color: Colors.white.withValues(alpha: 0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: 25,
              showTitle: false,
              badgeWidget: Text('data', style: TextStyle(
                  color: color2,
                  fontSize: 16
              ),),
              radius: 80,
              badgePositionPercentageOffset: badgeOffset,
              borderSide: isTouched
                  ? const BorderSide(
                  color: Colors.white, width: 6)
                  : BorderSide(
                  color: Colors.white.withValues(alpha: 0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: 25,
              showTitle: false,
              badgeWidget: Text('data', style: TextStyle(
                  color: color3,
                  fontSize: 16
              ),),
              radius: 80,
              badgePositionPercentageOffset: badgeOffset,
              borderSide: isTouched
                  ? const BorderSide(
                  color: Colors.white, width: 6)
                  : BorderSide(
                  color: Colors.white.withValues(alpha: 0)),
            );
          case 4:
            return PieChartSectionData(
              color: color4,
              value: 25,
              showTitle: false,
              badgeWidget: Text('data', style: TextStyle(
                color: color4,
                fontSize: 16
              ),),
              radius: 80,
              badgePositionPercentageOffset: badgeOffset,
              borderSide: isTouched
                  ? const BorderSide(
                  color: Colors.white, width: 6)
                  : BorderSide(
                  color: Colors.white.withValues(alpha: 0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}
