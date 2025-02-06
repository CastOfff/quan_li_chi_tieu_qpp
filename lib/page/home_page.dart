import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu_ca_nhan/page/calender_screen.dart';
import 'package:quan_li_chi_tieu_ca_nhan/page/note_page.dart';
import 'package:quan_li_chi_tieu_ca_nhan/page/report_page_second.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  List<Widget> pages = [NotePage(), CalenderScreen(), ReportPageSecond()];
  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          controller: tabController,
          children: [NotePage(), CalenderScreen(), ReportPageSecond()]),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          setState(() {
            currentPage = value;
            tabController.animateTo(value);
          });
        },
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions), label: 'Nhập'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: 'Lịch'),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart), label: 'báo cáo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_outlined), label: 'khác'),
        ],
      ),
    );
  }
}
