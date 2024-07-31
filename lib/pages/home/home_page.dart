import 'package:flutter/material.dart';
import 'package:goal_marker/widget/home/bottom_widget.dart';
import 'package:goal_marker/widget/home/home_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List allData = [
    [
    ["Read 3 Page Book",false],
    ["Complite Ui",false],
    ["Plan All database",false],
    ["setup",false]
  ],
  [
    ["Read 50 Page Book ",false],
    ["Get a Job",false],
    ["setup",false]
  ],
  [
    ["Read 80 Page Book",false],
    ["setup",false]
  ],
  [

  ]
  ];
  List bottomPages = ["Dey","Week","Month","Year"];
  int currentpage=0;
  void changePage(int index){
    setState(() {
      currentpage=index;
    });
  }
  void onTap(bool? status,int index){
    setState(() {
      allData[currentpage][index][1]=!allData[currentpage][index][1];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(bottomPages[currentpage],style: GoogleFonts.aDLaMDisplay(),),),
      body: Column(
        children: [
          Expanded(child: ListView(
            children: List.generate(allData[currentpage].length, (index) => GoalWidget(title: allData[currentpage][index][0],check: allData[currentpage][index][1],onTap: (p0) => onTap(p0, index),),),
          )),
          Row(
            children: List.generate(bottomPages.length, (index) => HomeBottomWidget(onTap: () => changePage(index),text: bottomPages[index],selected: currentpage==index,),),
          ),
        ],
      ),
    );
  }
}