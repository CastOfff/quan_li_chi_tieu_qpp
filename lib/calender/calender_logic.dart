
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

  /// Tính Tổng thu chi trong tháng
  Map<String, int> calculateMonthlyCashFlow(ListData listData, DateTime selectedMonth){
    int income = 0;
    int expense = 0;
    int balance = 0;
    for (var entry in listData.data) {
      if (entry.date.year == selectedMonth.year && entry.date.month == selectedMonth.month) {
        if (entry.isIncome == true) {
          income += entry.amount!;
        }
        else {
          expense += entry.amount!;
        }
      }
      balance = income - expense;
    }
    return {
      'Income': income,
      'Expense': expense,
      'Balance': balance,
    };
  }
  /// Hàm tổng hợp các giao dịch theo loại
  Map<bool, Map<CategoryType, int>> calculateCategorySummary(ListData listData, DateTime selectedMonth) {
    Map<CategoryType, int> incomeTotals = {};
    Map<CategoryType, int> expenseTotals = {};

    for (var cashFlow in listData.data) {
      if (cashFlow.date.year == selectedMonth.year && cashFlow.date.month == selectedMonth.month) {
        if (cashFlow.isIncome == true) {
          incomeTotals[cashFlow.category] = (incomeTotals[cashFlow.category] ?? 0) + cashFlow.amount!;
        } else {
          expenseTotals[cashFlow.category] = (expenseTotals[cashFlow.category] ?? 0) + cashFlow.amount!;
        }
      }
    }
    return {true: incomeTotals, false: expenseTotals};
  }
  // Map<CategoryType, Map<String, int>> calculateMonthCategory(ListData listData, DateTime selectedMonth) {
  //   final Map<CategoryType, Map<String, int>> categoryExpenseSummary = {};
  //   final Map<CategoryType, Map<String, int>> categoryIncomeSummary = {};
  //
  //   for (final transaction in listData.data) {
  //     if (transaction.date.year == selectedMonth.year && transaction.date.month == selectedMonth.month) {
  //       // Sử dụng ??= để khởi tạo giá trị ban đầu nếu chưa tồn tại
  //       categoryExpenseSummary[transaction.category] ??= {'CategoryExpense': 0};
  //       categoryIncomeSummary[transaction.category] ??= {'CategoryIncome': 0};
  //
  //       if (transaction.isIncome == true) {
  //         categoryIncomeSummary['CategoryIncome'] = (categoryIncomeSummary['CategoryIncome'] ?? 0) + transaction.amount!;
  //       } else {
  //         categoryExpenseSummary['CategoryExpense'] = (categoryExpenseSummary['CategoryExpense'] ?? 0) + transaction.amount!;
  //       }
  //     }
  //   }
  //
  //   return categorySummary;
  // }
}


