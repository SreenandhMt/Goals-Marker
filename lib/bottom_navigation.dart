import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:goal_marker/services/profile/profile_provider.dart';

import 'pages/home/home_page.dart';

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

  void ontap(int index){
     widget.child.goBranch(index);
        if(index==1){
          context.read<ProfileServcies>().loadUserProgress();
        }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width>1000)
    {
      return Scaffold(
        body: Row(
          children: [
            Container(
                  width: 240,
                  color: Colors.grey.shade200,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ListTile(title: Text(
                                 FirebaseAuth.instance.currentUser!.email!.split("@").first,
                                 style: GoogleFonts.aDLaMDisplay(),
                       ),leading: CircleAvatar(child: Center(child: Text(FirebaseAuth.instance.currentUser!.email!.split("").first,style: TextStyle(fontSize: 25),)),),subtitle:  Text(
                                 FirebaseAuth.instance.currentUser!.email!
                       ),),
                       SizedBox(height: 20),
                   AccountLeftMenu(ontap: (p0) => ontap(p0)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: widget.child),
                ],
              ),
            )
          ],
        )
      );
    }
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.child.currentIndex,
        items: const[
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded),label: "Profile")
      ],
      onTap: (index){
        widget.child.goBranch(index);
        if(index==1){
          context.read<ProfileServcies>().loadUserProgress();
        }
      },
      ),
    );
  }

}

class AccountLeftMenu extends StatefulWidget {
  const AccountLeftMenu({
    Key? key,
    required this.ontap,
  }) : super(key: key);
  final Function(int) ontap;

  @override
  State<AccountLeftMenu> createState() => _AccountLeftMenuState();
}

class _AccountLeftMenuState extends State<AccountLeftMenu> {
  int onPressed = 0;
  int currentSubPage = pageController.initialPage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Container(
            decoration: BoxDecoration(color: onPressed==0?Colors.grey.shade300:Colors.transparent,borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                ListTile(
              contentPadding: EdgeInsets.only(left: 9, right: 9),
              title: Text(
                "Account",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              leading: Icon(
                Icons.home_outlined,
                color: Colors.grey.shade600,
              ),
              onTap: () {
                setState(() {
                  onPressed=0;
                });
                widget.ontap(0);
              },
            ),
            if(onPressed==0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                    pageController.jumpToPage(0);
                    setState(() {
                      currentSubPage=0;
                    });
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(color: currentSubPage==0?Colors.green:Colors.transparent,borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 9, right: 9),
                    child: Text(
                      "Dey",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            if(onPressed==0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                    pageController.jumpToPage(1);
                    setState(() {
                      currentSubPage=1;
                    });
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(color: currentSubPage==1?Colors.green:Colors.transparent,borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 9, right: 9),
                    child: Text(
                      "Week",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            if(onPressed==0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                    pageController.jumpToPage(2);
                    setState(() {
                      currentSubPage=2;
                    });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  decoration: BoxDecoration(color: currentSubPage==2?Colors.green:Colors.transparent,borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 9, right: 9),
                    child: Text(
                      "Month",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            if(onPressed==0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                    pageController.jumpToPage(3);
                    setState(() {
                      currentSubPage=3;
                    });
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(color: currentSubPage==3?Colors.green:Colors.transparent,borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 9, right: 9),
                    child: Text(
                      "Year",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
              ],
            ),
          ),
        ),
        Padding(
                     padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    child:  Container(
        decoration: BoxDecoration(color: onPressed==1?Colors.grey.shade300:Colors.transparent,borderRadius: BorderRadius.circular(10)),
                      child: ListTile(contentPadding: EdgeInsets.only(left: 9,right: 9),title: Text(
                                     "Profile",style: TextStyle(fontWeight: FontWeight.w600),
                           ),leading: Icon(Icons.account_circle_outlined,color: Colors.grey.shade600,),onTap: () {
                            setState(() {
                              onPressed=1;
                            });
                             widget.ontap(1);
                           },),
                    ),
                  )
      ],
    );
  }
}
