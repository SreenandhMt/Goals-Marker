import 'package:flutter/material.dart';

class HomeBottomWidget extends StatelessWidget {
  const HomeBottomWidget({
    Key? key,
    this.onTap,
    required this.text,
    required this.selected,
  }) : super(key: key);
  final Function()? onTap;
  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,child: Container(padding: const EdgeInsets.only(left: 27,right: 27,top: 10,bottom: 10),margin: const EdgeInsets.all(5), decoration: BoxDecoration(color:selected?Colors.grey.shade600: Colors.grey.shade300,borderRadius: BorderRadius.circular(10)),child: Center(child: Text(text),),));
  }
}
