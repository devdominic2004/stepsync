import 'package:flutter/material.dart';
import 'package:stepsync/common/color_extension.dart';
import 'package:stepsync/common_widget/on_boarding_page.dart';
import 'package:stepsync/view/login/signup_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      selectPage = controller.page?.round() ?? 0;

      setState(() {
        selectPage = selectPage;
      });
    });
  }

  List pageArr = [
    {
      "title": "Track your goals.",
      "subtitle":
          "Track your goals and progress with our app. Set reminders and get notifications to stay on track.",
      "image": "assets/img/on_1.png",
    },
    {
      "title": "Burn those calories.",
      "subtitle":
          "Each and every single calorie counts. Keep it in check with daily goals.",
      "image": "assets/img/on_2.png",
    },
    {
      "title": "Stay hydrated.",
      "subtitle":
          "Be aware of your daily water consumption. Being hydrated comes first.",
      "image": "assets/img/on_3.png",
    },
    {
      "title": "Improve sleep quality.",
      "subtitle":
          "Measure your sleep quality and improve it with our app. Get reminders to sleep on time.",
      "image": "assets/img/on_4.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pageArr.length,
            itemBuilder: (context, index) {
              var pObj = pageArr[index] as Map? ?? {};
              return OnBoardingPage(pObj: pObj);
            },
          ),

          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    color: TColor.primaryColor1,
                    value: (selectPage + 1) / 4,
                    strokeWidth: 2,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: TColor.primaryColor1,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.navigate_next, color: TColor.white),
                    onPressed: () {
                      if (selectPage < 3) {
                        selectPage = selectPage + 1;

                        controller.animateToPage(
                          selectPage,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                        );

                        // controller.jumpToPage(selectPage);

                        setState(() {});
                      } else {
                        // print("Open Welcome Screen");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpView(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
