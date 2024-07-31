import 'package:flutter/material.dart';

class GoalWidget extends StatefulWidget {
  const GoalWidget({
    super.key,
    required this.title,
    required this.check,
    required this.onTap,
  });
  final String title;
  final bool check;
  final Function(bool?) onTap;

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.grey.shade100),
      child: Row(
        children: [
          SizedBox(width: 20),
          Checkbox(value: widget.check, onChanged: widget.onTap),
          SizedBox(width: 20),
           Text(
            widget.title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
