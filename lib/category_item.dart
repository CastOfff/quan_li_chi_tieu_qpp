import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  final String category;
  final Icon categoryIcon;
  final Color frameColor;
  final VoidCallback onTap;

  const CategoryItem(
      {super.key,
      required this.category,
      required this.categoryIcon,
      required this.frameColor,
      required this.onTap,
      });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.frameColor,
              width: 2.0, // Độ dày của khung
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.categoryIcon,
              SizedBox(
                height: 8,
              ),
              Text(
                widget.category,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
