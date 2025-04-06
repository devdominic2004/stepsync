import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stepsync/common/color_extension.dart';
import 'package:stepsync/common_widget/round_button.dart';
import 'package:stepsync/common_widget/round_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();

  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: Container(
        width: media.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: TColor.secondaryG,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: media.width * 0.2),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Create a new password",
                style: TextStyle(color: TColor.gray, fontSize: 18),
              ),
            ),

            SizedBox(height: media.width * 0.15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundTextField(
                hintText: "Email ID",
                icon: "assets/img/email.png",
                keyboardType: TextInputType.emailAddress,
                controller: email,
              ),
            ),

            SizedBox(height: media.width * 0.04),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundButton(
                title: "Send Reset Link",
                onPressed: (() => reset()),
              ),
            ),

            const Spacer(),

            // SafeArea(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 15),
            //     child: RoundButton(
            //       title: "Get Started",
            //       type:
            //           isChangeColor
            //               ? RoundButtonType.textGradient
            //               : RoundButtonType.bgGradient,
            //       onPressed: () {
            //         if (isChangeColor) {
            //           //Go next screen
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => const OnBoardingView(),
            //             ),
            //           );
            //         } else {
            //           //Change color
            //           setState(() {
            //             isChangeColor = true;
            //           });
            //         }
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
