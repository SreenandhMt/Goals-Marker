import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class BottomPageRouting extends StatefulWidget {
  const BottomPageRouting({
    super.key,
    required this.child,
  });
  final StatefulNavigationShell child;

  @override
  State<BottomPageRouting> createState() => _BottomPageRoutingState();
}

class _BottomPageRoutingState extends State<BottomPageRouting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.child.currentIndex,
        items: const[
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded),label: "Profile")
      ],
      onTap: (index)=>widget.child.goBranch(index),
      ),
    );
  }
}