import 'package:flutter/material.dart';

import 'cash_flow_data.dart';

class CashFlowProvider extends ChangeNotifier {
  ListData cashFlowData = data;

  void addTransaction({
    required DateTime date,
    required bool isIncome,
    required int amount,
    required CategoryType category,
  }) {

    // Tạo đối tượng CashFlowData mới với thông tin giao dịch
    final newTransaction = CashFlowData(
      date: date,
      isIncome: isIncome,
      amount: amount,
      category: category,
    );

    // Thêm giao dịch vào danh sách
    cashFlowData.addCashFlowData(newTransaction);

    // Thông báo cho các listener rằng dữ liệu đã thay đổi
    notifyListeners();
  }
}
