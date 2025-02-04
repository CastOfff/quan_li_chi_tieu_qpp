import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  final int income;
  final int expense;
  final int sum;

  const SummaryWidget({
    Key? key,
    required this.income,
    required this.expense,
    required this.sum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(
                '$income₫',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text('Tiền chi'),
              Text(
                '$expense₫',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text('Tổng'),
              Text(
                '$sum₫',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: sum > 0 ? Colors.blue : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}