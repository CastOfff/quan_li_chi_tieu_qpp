import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDateTime();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging) {
    //     print('Tab changed to index: ${_tabController.index}');
    //   }
    // }
    // );
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              tabs: [
                const Tab(text: 'Tiền chi',),
                const Tab(text: 'Tiền thu',)
              ],
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
                child: Text('Ngày', style: Theme.of(context).textTheme.titleMedium,)),
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
                    width: 250,
                    child: TextFormField(
                      enableInteractiveSelection: true,
                      initialValue: '$weekday $day/$month/$year',
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.deepOrange,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
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
          Divider(
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
                  flex: 2,
                    child: Text('Tiền chi', style: Theme.of(context).textTheme.titleMedium,)),
                Expanded(
                  flex: 9,
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
                Expanded(
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
          Divider(
            thickness: 1,
            color: Colors.grey,
            height: 20,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
