import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoalWidget extends StatefulWidget {
  const GoalWidget({
    Key? key,
    required this.title,
    required this.check,
    required this.map,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final bool check;
  final Map<String,dynamic> map;
  final Function(bool?) onTap;

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.go("/edit",extra: widget.map);
      },
      child: Container(
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.grey.shade100),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Checkbox(value: widget.check, onChanged: widget.onTap),
            const SizedBox(width: 20),
             Text(
              widget.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
