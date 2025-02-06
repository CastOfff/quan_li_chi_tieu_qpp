import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_li_chi_tieu_ca_nhan/data/cash_flow_data.dart';
import '../category_item.dart';
import '../data/cash_flow_provider.dart';

class MoneyExpensePage extends StatefulWidget {
  const MoneyExpensePage({super.key});

  @override
  State<MoneyExpensePage> createState() => _MoneyExpensePageState();
}

class _MoneyExpensePageState extends State<MoneyExpensePage> {
  final List<Map<String, dynamic>> categories = [
    {'name': CategoryType.eating, 'icon': Icons.restaurant, 'color': Colors.orange},
    {'name': CategoryType.clothes, 'icon': Icons.shopping_bag, 'color': Colors.pink},
    {'name': CategoryType.spending, 'icon': Icons.attach_money, 'color': Colors.green},
    {'name': CategoryType.cosmetics, 'icon': Icons.face, 'color': Colors.purple},
    {'name': CategoryType.transactionFee, 'icon': Icons.credit_card, 'color': Colors.blue},
    {'name': CategoryType.healthcare, 'icon': Icons.medical_services, 'color': Colors.red},
    {'name': CategoryType.education, 'icon': Icons.school, 'color': Colors.teal},
    {'name': CategoryType.utilities, 'icon': Icons.electrical_services, 'color': Colors.indigo},
    {'name': CategoryType.transport, 'icon': Icons.directions_car, 'color': Colors.blueGrey},
    {'name': CategoryType.internet, 'icon': Icons.wifi, 'color': Colors.cyan},
    {'name': CategoryType.rent, 'icon': Icons.home, 'color': Colors.brown},
    {'name': CategoryType.entertainment, 'icon': Icons.movie, 'color': Colors.deepPurple},
  ];
  final TextEditingController _controller = TextEditingController();

  late String day;
  late String month;
  late String year;
  late String weekday;
  late TextEditingController _dateController;
  void _getDateTime([DateTime? date]) {
    date ??= DateTime.now();

    day = date.day.toString();
    month = date.month.toString();
    year = date.year.toString();

    List<String> daysOfWeek = [
      'Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy'
    ];
    weekday = daysOfWeek[date.weekday % 7];
  }

  Future<void> _selectDate() async {
    final DateTime currentDate = DateTime(int.parse(year), int.parse(month),int.parse(day));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );

    if (picked != null && picked != currentDate) {
      setState(() {
        _getDateTime(picked);
        _dateController.text = '$weekday $day/$month/$year';
      });
    }
  }

  int selectedItem = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDateTime();
    _dateController = TextEditingController(text: '$weekday $day/$month/$year');
  }
  @override
  void dispose() {
    _dateController.dispose();
    _controller.dispose();
    super.dispose();
  }

  int? _getIntValue() {
    String textValue = _controller.text;

    int? intValue = int.tryParse(textValue);

    if (intValue == null) {
      return 0;
    } else {
      return intValue.toInt();
    }
  }

  void _saveTransaction(BuildContext context) {
    final provider = Provider.of<CashFlowProvider>(context, listen: false);
    provider.addTransaction(
        date: DateTime(int.parse(year), int.parse(month), int.parse(day)),
        isIncome: false,
        amount: _getIntValue()!.toInt(),
        category: categories[selectedItem]['name'],
    );
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
                  flex: 4,
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
                      controller: _dateController,
                      readOnly: true,
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 14.0),
                        suffixIcon: GestureDetector(
                          onTap: _selectDate,
                          child: const Icon(
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
            padding: const EdgeInsets.only(
                right: 20,
                left: 20
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Ghi chú', style: Theme.of(context).textTheme.titleMedium,)),
                Expanded(
                  flex: 4,
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
                  flex: 7,
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
                      controller: _controller,
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
                const Text(
                  'đ',
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline,
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
            flex: 8,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  category: categories[index]['name'] as CategoryType,
                  categoryIcon: Icon(
                    categories[index]['icon'],
                    size: 40,
                    color: categories[index]['color'],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepOrange,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.red,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                        return AlertDialog(
                          title: const Text('Thông báo'),
                          content: const Text('Bạn chắc chắn muốn thêm giao dịch này?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, child: const Text('Hủy'),
                          ),
                            TextButton(
                              onPressed: () {
                                _saveTransaction(context);
                                Navigator.pop(context);
                                /// đặt
                              },
                              child: const Text('Xác nhận'),
                          )
                          ]
                        );
                      },
                      );
                    },
                    child: const Center(
                      child: Text(
                        'Xác nhận',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),
                    ),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
