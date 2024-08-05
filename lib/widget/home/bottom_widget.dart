import 'package:flutter/material.dart';

class HomeBottomWidget extends StatelessWidget {
  const HomeBottomWidget({
    super.key,
    this.onTap,
    required this.text,
    required this.selected,
  });
  final Function()? onTap;
  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width>1000)
    {
      return const SizedBox();
    }
    return GestureDetector(onTap: onTap,child: Container(width: size.width*0.2,height: size.width*0.1,margin: const EdgeInsets.all(5), decoration: BoxDecoration(color:selected?const Color.fromARGB(255, 104, 212, 109): Colors.grey.shade300,borderRadius: BorderRadius.circular(8)),child: Center(child: Text(text),),));
  }
}
