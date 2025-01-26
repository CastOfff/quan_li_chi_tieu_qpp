import 'package:flutter/material.dart';
import 'package:quan_li_chi_tieu_ca_nhan/page/calender_screen.dart';

import 'package:quan_li_chi_tieu_ca_nhan/page/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            shadowColor: Colors.black,
              elevation: 5,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
              ),
            backgroundColor: Color(0xfff8eff8)
          ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            color: Colors.red,
            fontSize: 10,
          )
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white60,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.black45
        )
      ),
      home: CalenderScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
