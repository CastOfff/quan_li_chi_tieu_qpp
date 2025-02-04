
import 'package:quan_li_chi_tieu_ca_nhan/data/cash_flow_data.dart';

class CalendarLogic {
  final ListData listData;

  CalendarLogic({required this.listData});
  Map<String, int> getEventsForDay(DateTime selectedDay) {
    final eventsForDay = listData.data.where((cashFlow) =>
    cashFlow.date.year == selectedDay.year &&
        cashFlow.date.month == selectedDay.month &&
        cashFlow.date.day == selectedDay.day);

    int totalIncome = 0;
    int totalExpense = 0;

    for (var cashFlow in eventsForDay) {
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

  List<CashFlowData> getTransactionsForDay(DateTime selectedDay, Transactions type) {
    bool isIncomeType;
    if (type == Transactions.income) {
      isIncomeType = true;
    } else if (type == Transactions.expense) {
      isIncomeType = false;
    } else {
      throw Exception("Loại giao dịch không hợp lệ. Vui lòng chọn 'Income' hoặc 'Expense'.");
    }

    return listData.data.where((cashFlow) {
      final isSameDay = cashFlow.date.year == selectedDay.year &&
          cashFlow.date.month == selectedDay.month &&
          cashFlow.date.day == selectedDay.day;
      return isSameDay && (cashFlow.isIncome == isIncomeType);
    }).toList();
  }

  Map<String, int> getEventsForMonth(DateTime selectedDay) {
    final eventsForMonth = listData.data.where((cashFlow) =>
    cashFlow.date.year == selectedDay.year &&
        cashFlow.date.month == selectedDay.month);

    int totalIncome = 0;
    int totalExpense = 0;

    for (var cashFlow in eventsForMonth) {
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

  List<CashFlowData> getTransactionsForMonth(DateTime selectedDay, Transactions type) {
    bool isIncomeType;
    if (type == Transactions.income) {
      isIncomeType = true;
    } else if (type == Transactions.expense) {
      isIncomeType = false;
    } else {
      throw Exception("Loại giao dịch không hợp lệ. Vui lòng chọn 'Income' hoặc 'Expense'.");
    }

    return listData.data.where((cashFlow) {
      final isSameDay = cashFlow.date.year == selectedDay.year &&
          cashFlow.date.month == selectedDay.month;
      return isSameDay && (cashFlow.isIncome == isIncomeType);
    }).toList();
  }

  List<CashFlowData> getTransactionsByCategoryInAMonth(DateTime selectedDay, CategoryType type) {
    return listData.data.where((cashFlow) {
      final isSameDay = cashFlow.date.year == selectedDay.year &&
          cashFlow.date.month == selectedDay.month &&
          cashFlow.category == type;
      return isSameDay;
    }).toList();
  }

  List<CashFlowData> getTop4TransactionsByCategory(DateTime selectedDay) {
    Map<CategoryType, int?> categoryTotals = {};

    for (var cashFlow in listData.data) {
      if (cashFlow.date.year == selectedDay.year && cashFlow.date.month == selectedDay.month) {
        categoryTotals.update(
          cashFlow.category,
              (value) => value! + cashFlow.amount!,
          ifAbsent: () => cashFlow.amount,
        );
      }
    }

    var topCategories = categoryTotals.entries
        .toList()
      ..sort((a, b) => b.value!.compareTo(a.value!));

    var selectedCategories = topCategories.take(4).map((e) => e.key).toSet();

    return listData.data.where((cashFlow) =>
    selectedCategories.contains(cashFlow.category) &&
        cashFlow.date.year == selectedDay.year &&
        cashFlow.date.month == selectedDay.month).toList();
  }

}
