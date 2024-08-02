import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile",style: GoogleFonts.aDLaMDisplay(),),actions: [IconButton(onPressed: (){FirebaseAuth.instance.signOut();}, icon: const Icon(Icons.logout))],),
      body: Column(
        children: [
          HeatMapCalendar(
  defaultColor: Colors.white,
  flexible: true,
  colorMode: ColorMode.color,
  datasets: {
    DateTime(2021, 1, 6): 3,
    DateTime(2021, 1, 7): 7,
    DateTime(2021, 1, 8): 10,
    DateTime(2021, 1, 9): 13,
    DateTime(2021, 1, 13): 6,
  },
  colorsets: const {
    1: Colors.red,
    3: Colors.orange,
    5: Colors.yellow,
    7: Colors.green,
    9: Colors.blue,
    11: Colors.indigo,
    13: Colors.purple,
  },
  onClick: (value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
  },
),
        ],
      ),
    );
  }
}