import 'package:flutter/material.dart';
import 'package:stepsync/common/color_extension.dart';
import 'package:stepsync/common_widget/tab_button.dart';
import 'package:stepsync/view/home/home_view.dart';
import 'package:stepsync/view/home/sleep_view.dart';
import 'package:stepsync/view/home/step_view.dart';
import 'package:stepsync/view/home/water_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();

  Widget currentTab = const HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: PageStorage(bucket: pageBucket, child: currentTab),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: SizedBox(
      //   width: 70,
      //   height: 70,
      //   child: InkWell(
      //     onTap: () {},
      //     child: Container(
      //       width: 65,
      //       height: 65,
      //       decoration: BoxDecoration(
      //         gradient: LinearGradient(colors: TColor.primaryG),
      //         borderRadius: BorderRadius.circular(35),
      //         boxShadow: const [
      //           BoxShadow(
      //             color: Colors.black26,
      //             blurRadius: 5,
      //             offset: Offset(0, 0),
      //           ),
      //         ],
      //       ),
      //       child: Icon(Icons.search, color: TColor.white),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomAppBar(
        color: TColor.black,
        child: Container(
          decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // TabButton(
              //   icon: "assets/img/home_tab.png",
              //   selectIcon: "assets/img/home_tab_select.png",
              //   isActive: selectTab == 0,
              //   onTap: () {
              //     selectTab = 0;
              //     currentTab = const HomeView();
              //     if (mounted) {
              //       setState(() {});
              //     }
              //   },
              // ),
              TabButton(
                icon: "assets/img/activity_tab.png",
                selectIcon: "assets/img/activity_tab_select.png",
                isActive: selectTab == 0,
                onTap: () {
                  selectTab = 0;
                  currentTab = const StepView();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),

              TabButton(
                icon: "assets/img/water_tab.png",
                selectIcon: "assets/img/water_tab_select.png",
                isActive: selectTab == 1,
                onTap: () {
                  selectTab = 1;
                  currentTab = const WaterView();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),

              TabButton(
                icon: "assets/img/sleep_tab.png",
                selectIcon: "assets/img/sleep_tab_select.png",
                isActive: selectTab == 2,
                onTap: () {
                  selectTab = 2;
                  currentTab = const SleepView();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
