import 'package:flutter/material.dart';

import '../category_item.dart';

class MoneyIncomePage extends StatefulWidget {
  const MoneyIncomePage({super.key});

  @override
  State<MoneyIncomePage> createState() => _MoneyIncomePageState();
}

class _MoneyIncomePageState extends State<MoneyIncomePage> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Ăn uống', 'icon': Icons.restaurant, 'color': Colors.orange},
    {'name': 'Quần áo', 'icon': Icons.shopping_bag, 'color': Colors.pink},
    {'name': 'Chi tiêu', 'icon': Icons.attach_money, 'color': Colors.green},
    {'name': 'Mỹ phẩm', 'icon': Icons.face, 'color': Colors.purple},
    {'name': 'Phí giao dịch', 'icon': Icons.credit_card, 'color': Colors.blue},
    {'name': 'Y tế', 'icon': Icons.medical_services, 'color': Colors.red},
    {'name': 'Giáo dục', 'icon': Icons.school, 'color': Colors.teal},
    {'name': 'Điện nước', 'icon': Icons.electrical_services, 'color': Colors.indigo},
    {'name': 'Đi lại', 'icon': Icons.directions_car, 'color': Colors.blueGrey},
    {'name': 'Mạng', 'icon': Icons.wifi, 'color': Colors.cyan},
    {'name': 'Tiền nhà', 'icon': Icons.home, 'color': Colors.brown},
    {'name': 'Giải trí', 'icon': Icons.movie, 'color': Colors.deepPurple},
  ];

  late String day;
  late String month;



  late String year;
  late String weekday;
  void _getDateTime() {
    DateTime now = DateTime.now();

    // Lấy giá trị ngày, tháng, năm
    day = now.day.toString();
    month = now.month.toString();
    year = now.year.toString();

    // Lấy tên thứ trong tuần
    List<String> daysOfWeek = [
      'Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy'
    ];
    weekday = daysOfWeek[now.weekday % 7];
  }

  int selectedItem = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDateTime();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                right: 20,
                left: 20
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Ngày', style: Theme.of(context).textTheme.titleMedium,)),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.only(
                        right: 20,
                        left: 20
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xfffff1ec),
                    ),
                    width: 250,
                    child: TextFormField(
                      enableInteractiveSelection: true,
                      initialValue: '$weekday $day/$month/$year',
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        suffixIcon: GestureDetector(
                          onTap: () {

                          },
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.deepOrange,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
            height: 20,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
                right: 20,
                left: 20
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Ghi chú', style: Theme.of(context).textTheme.titleMedium,)),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 20,
                        left: 20
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfffff1ec),
                    ),
                    width: 300,
                    child: TextFormField(
                      //initialValue: 'ghi chú',
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập ghi chú vào đây',
                          hintStyle: TextStyle(color: Colors.black26,)
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
            height: 20,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 20,
                left: 20
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text('Tiền chi', style: Theme.of(context).textTheme.titleMedium,)),
                Expanded(
                  flex: 9,
                  child: Container(
                    padding: const EdgeInsets.only(
                        right: 20,
                        left: 20
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xfffff1ec),
                    ),
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '0',
                          hintStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(
                    'đ',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
            height: 20,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Danh mục', style: Theme.of(context).textTheme.titleMedium,),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,

              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryItem(
                  onTap: () {
                    setState(() {
                      selectedItem = index;
                    });
                  },
                  frameColor: selectedItem == index ? Colors.red : Colors.grey,
                  category: categories[index]['name'],
                  categoryIcon: Icon(
                    categories[index]['icon'],
                    size: 40,
                    color: categories[index]['color'],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
