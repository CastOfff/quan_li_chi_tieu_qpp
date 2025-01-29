import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu_ca_nhan/page/money_income_page.dart';
import 'package:quan_li_chi_tieu_ca_nhan/page/money_expense_page.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghi chép thu chi'),
      ),
      body: Column(
        children: [
          TabBar(
            labelStyle: const TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.w400,
              fontSize: 20
            ),
            padding: const EdgeInsets.all(10.0),
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: Colors.deepOrange), // Độ dày và màu sắc
              insets: EdgeInsets.symmetric(horizontal: 2.0),
              // Khoảng cách từ viền
            ),
            indicatorColor: Colors.deepOrange,
            unselectedLabelColor: Colors.grey,
              tabs: const [
              Tab(
                text: 'Tiền chi',
              ),
              Tab(
                text: 'Tiền thu',
              )
            ],
          ),
          Expanded(child: TabBarView(
            controller: _tabController,
            children: const [
              MoneyIncomePage(),
              MoneyEarnedPage(),
            ],
          ),)
        ],
      ),
    );
  }
}
