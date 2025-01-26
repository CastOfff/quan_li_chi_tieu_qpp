import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  final Image imageService;
  final String nameService;
  const Service(
      {
        super.key,
        required this.imageService,
        required this.nameService,
      }
      );



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green, // Màu nền
            child: Icon(Icons.person, color: Colors.white), // Icon
          ),
          onPressed: () {
            // Xử lý khi nhấn vào CircleAvatar
            print('CircleAvatar được nhấn!');
          },
        ),
        Text('data'),
      ],
    );
  }
}
