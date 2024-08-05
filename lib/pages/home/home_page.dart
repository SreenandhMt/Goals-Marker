import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goal_marker/services/home/home_provider.dart';
import 'package:goal_marker/widget/home/bottom_widget.dart';
import 'package:goal_marker/widget/home/home_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

PageController pageController = PageController();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List bottomPages = ["Dey", "Week", "Month", "Year"];
  int currentpage = 0;

  @override
  void initState() {
    context.read<HomeServices>().loadData();
    super.initState();
  }
  void changePage(int index) {
    setState(() {
      currentpage = index;
      pageController.jumpToPage(currentpage);
    });
  }

  void onTap(bool? status, int index,id,map) {
    context.read<HomeServices>().complete(type: map["type"], datetime: DateTime.now().toString(), id: id, status: status!, map: map,index: index);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<HomeServices>(
      builder: (context,state,__) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              bottomPages[currentpage],
              style: GoogleFonts.aDLaMDisplay(),
            ),
          ),
          body: Container(
            width: size.width>1000?size.width*0.78:double.infinity,
            child: Column(
              children: [
                Expanded(
                    child: PageView(
                      onPageChanged: (value) {
                        setState(() {
                          currentpage=value;
                        });
                      },
                      controller: pageController,
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          ),
          floatingActionButtonLocation: size.width>1000?FloatingActionButtonLocation.startFloat:FloatingActionButtonLocation.endFloat,
          floatingActionButton: Padding(padding: EdgeInsets.only(bottom: 50),child: FloatingActionButton(onPressed: (){context.go("/edit");})),
        );
      }
    );
  }
}
