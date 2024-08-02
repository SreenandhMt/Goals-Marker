import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goal_marker/services/home/home_provider.dart';
import 'package:goal_marker/widget/home/bottom_widget.dart';
import 'package:goal_marker/widget/home/home_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List bottomPages = ["Dey", "Week", "Month", "Year"];
  int currentpage = 0;
  void changePage(int index) {
    setState(() {
      currentpage = index;
      _pageController.jumpToPage(currentpage);
    });
  }

  void onTap(bool? status, int index,id,map) {
    context.read<HomeServices>().complete(type: map["type"], datetime: DateTime.now().toString(), id: id, status: status!, map: map,index: index);
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeServices>().loadData(datetime: DateTime.now().toString());
    return Consumer<HomeServices>(
      builder: (context,state,__) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              bottomPages[currentpage],
              style: GoogleFonts.aDLaMDisplay(),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListView(
                children: List.generate(
                  state.deylyGoals.length,
                  (index) => GoalWidget(
                    title: state.deylyGoals[index]["title"],
                    check: state.deylyGoals[index]["completed"],
                    map: state.deylyGoals[index],
                    onTap: (p0) => onTap(p0, index,state.deylyGoals[index]["id"],state.deylyGoals[index]),
                  ),
                ),
              ),
              ListView(
                children: List.generate(
                  state.weeklyGoals.length,
                  (index) => GoalWidget(
                    title: state.weeklyGoals[index]["title"],
                    check: state.weeklyGoals[index]["completed"],
                    map: state.weeklyGoals[index],
                    onTap: (p0) => onTap(p0, index,state.weeklyGoals[index]["id"],state.weeklyGoals[index]),
                  ),
                ),
              ),
              ListView(
                children: List.generate(
                  state.monthlyGoals.length,
                  (index) => GoalWidget(
                    title: state.monthlyGoals[index]["title"],
                    check: state.monthlyGoals[index]["completed"],
                    map: state.monthlyGoals[index],
                    onTap: (p0) => onTap(p0, index,state.monthlyGoals[index]["id"],state.monthlyGoals[index]),
                  ),
                ),
              ),
              ListView(
                children: List.generate(
                  state.yearlyGoals.length,
                  (index) => GoalWidget(
                    title: state.yearlyGoals[index]["title"],
                    check: state.yearlyGoals[index]["completed"],
                    map: state.yearlyGoals[index],
                    onTap: (p0) => onTap(p0, index,state.yearlyGoals[index]["id"],state.yearlyGoals[index]),
                  ),
                ),
              ),
                    ],
                  )),
              Row(
                children: List.generate(
                  bottomPages.length,
                  (index) => HomeBottomWidget(
                    onTap: () => changePage(index),
                    text: bottomPages[index],
                    selected: currentpage == index,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(onPressed: (){context.go("/edit");}),
        );
      }
    );
  }
}
