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

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_image.jpg'), // Đường dẫn tới ảnh nền
              fit: BoxFit.cover, // Để ảnh phủ toàn bộ màn hình
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          //backgroundColor: Color(0xffebdfeb),
          appBar: AppBar(
            backgroundColor: Colors.transparent, // Đặt AppBar trong suốt
            elevation: 0,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notification_add_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],// Loại bỏ bóng của AppBar
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: Container(
                    height: 200,
                    width: 400,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(colors.length, (index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: CircleAvatar(
                                      radius: 30, // Kích thước của CircleAvatar
                                      backgroundColor: colors[index], // Màu nền từ danh sách colors
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white, // Màu icon
                                      ),
                                    ),
                                    onPressed: () {
                                      print('CircleAvatar $index được nhấn!'); // Hành động khi nhấn
                                    },
                                  ),
                                  Text(
                                    'Data $index', // Hiển thị văn bản
                                    style: TextStyle(fontSize: 14), // Kích thước chữ
                                  ),
                                ],
                              );
                            }),
                          ),
                        )
                      ],
                    ),
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
        ),
      ],
    );
  }
}
