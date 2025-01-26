import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [Colors.green, Colors.blue, Colors.red, Colors.orange];

    return Scaffold(
      backgroundColor: Color(0xffebdfeb),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              height: 240,
              decoration: const BoxDecoration(
                color: Color(0xffA4C3A2),
                gradient: LinearGradient(
                  colors: [Color(0xffbfaee3), Color(0xfffec5e6)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(height: 20,),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notification_add_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      CircleAvatar(
                        radius: 30, // Bán kính của hình tròn
                        backgroundColor: Colors.white, // Màu viền
                        child: CircleAvatar(
                          radius: 27, // Bán kính nhỏ hơn để tạo viền
                          backgroundImage: AssetImage('assets/images/502378.png'), // URL hình ảnh
                        ),
                      ),
                      Text(
                          '  Hello\n  Lã Mạnh Cường',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Center(
              heightFactor: 3.3,
              child: LayoutBuilder(
                  builder: (context, constraints){
                    return Container(
                      padding: EdgeInsets.all(16),
                      width: constraints.maxWidth * 0.7, //
                      height: constraints.maxHeight * 0.18,
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'My balance',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              Spacer(),
                              Text(
                                '1,000,000 VND',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 7,),
                          Divider(
                            color: Colors.black, //
                            thickness: 2, //
                          ),
                          Expanded(
                            child: ListView.builder(

                              scrollDirection: Axis.horizontal,
                              itemCount: colors.length,
                              itemBuilder: (context, index) {

                                return SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.only(left: 14, right: 14),
                                        icon: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: colors[index],
                                          child: Icon(Icons.person, color: Colors.white),
                                        ),
                                        onPressed: () {
                                          print('CircleAvatar $index được nhấn!');
                                        },
                                      ),
                                      Text('data')
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.wallet),
                label: 'my wallet'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications),
                label: 'setting'),
          ],
      ),
    );
  }
}
