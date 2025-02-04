import 'package:flutter/material.dart';

class MoneyIncomePage extends StatefulWidget {
  const MoneyIncomePage({super.key});

  @override
  State<MoneyIncomePage> createState() => _MoneyIncomePageState();
}

class _MoneyIncomePageState extends State<MoneyIncomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Text('data'),
      ),
    );
  }
}
