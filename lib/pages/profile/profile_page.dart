import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:goal_marker/services/profile/profile_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ProfileServcies>(builder: (context, state, ___) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: GoogleFonts.aDLaMDisplay(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Container(
            width: size.width>1000?size.width*0.5:double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                Text(
                "Hi "+ FirebaseAuth.instance.currentUser!.email!.split("@").first,
                style: GoogleFonts.aDLaMDisplay(fontSize: 25),
              ),
              SizedBox(height: 7),
              Text(
                "Your Activity",
                style: GoogleFonts.aDLaMDisplay(),
              ),
              SizedBox(height: 10),
                HeatMap(
                  defaultColor: Colors.white,
                  endDate: DateTime.now(),
                  startDate:
                      DateTime(DateTime.now().year, DateTime.now().month - 3, 1),
                  colorMode: ColorMode.color,
                  textColor: Colors.black,
                  scrollable: true,
                  showText: true,
                  margin: EdgeInsets.all(4),
                  size: 35,
                  fontSize: 10,
                  datasets: state.progress,
                  colorsets: {
                    1: Colors.green[50]!,
                    2: Colors.green[100]!,
                    3: Colors.green[200]!,
                    4: Colors.green[300]!,
                    5: Colors.green[400]!,
                    6: Colors.green,
                    7: Colors.green[600]!,
                    8: Colors.green[700]!,
                    9: Colors.green[800]!,
                    10: Colors.green[900]!,
                  },
                  onClick: (value) {},
                  showColorTip: false,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
