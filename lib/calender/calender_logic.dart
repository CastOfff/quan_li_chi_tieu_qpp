
import 'package:quan_li_chi_tieu_ca_nhan/data/cash_flow_data.dart';

class CalendarLogic {
  final ListData listData;

  CalendarLogic({required this.listData});

  /// Phương thức để lấy tổng số tiền Income và Expense của một ngày được chọn.
  Map<String, int> getEventsForDay(DateTime selectedDay) {
    // Lọc ra các giao dịch trong ngày được chọn.
    final eventsForDay = listData.data.where((cashFlow) =>
    cashFlow.date.year == selectedDay.year &&
        cashFlow.date.month == selectedDay.month &&
        cashFlow.date.day == selectedDay.day);

    int totalIncome = 0;
    int totalExpense = 0;

    // Tính tổng Income và Expense dựa vào trường isIncome.
    for (var cashFlow in eventsForDay) {
      // Nếu amount có giá trị null, mặc định là 0.
      int amount = cashFlow.amount ?? 0;
      if (cashFlow.isIncome == true) {
        totalIncome += amount;
      } else {
        totalExpense += amount;
      }
    }

    return {
      'Income': totalIncome,
      'Expense': totalExpense,
    };
  }

  /// Phương thức lấy danh sách các giao dịch của một ngày theo kiểu (Income hoặc Expense).
  List<CashFlowData> getTransactionsForDay(DateTime selectedDay, String type) {
    // Xác định kiểu giao dịch cần lấy: true với 'Income', false với 'Expense'
    bool isIncomeType;
    if (type.toLowerCase() == 'income') {
      isIncomeType = true;
    } else if (type.toLowerCase() == 'expense') {
      isIncomeType = false;
    } else {
      throw Exception("Loại giao dịch không hợp lệ. Vui lòng chọn 'Income' hoặc 'Expense'.");
    }

    // Lọc các giao dịch trong ngày và theo kiểu đã chọn.
    return listData.data.where((cashFlow) {
      final isSameDay = cashFlow.date.year == selectedDay.year &&
          cashFlow.date.month == selectedDay.month &&
          cashFlow.date.day == selectedDay.day;
      return isSameDay && (cashFlow.isIncome == isIncomeType);
    }).toList();
  }
}
