import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoneyEarnedPage extends StatefulWidget {
  const MoneyEarnedPage({super.key});

  @override
  State<MoneyEarnedPage> createState() => _MoneyEarnedPageState();
}

class _MoneyEarnedPageState extends State<MoneyEarnedPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.red,
      child: Text('data'),
    );
  }
}
