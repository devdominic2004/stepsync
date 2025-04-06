import 'package:flutter/material.dart';
import 'package:stepsync/common/color_extension.dart';
import 'package:stepsync/common_widget/round_button.dart';
import 'package:stepsync/common_widget/round_text_field.dart';
import 'package:stepsync/view/login/complete_profile_view.dart';
import 'package:stepsync/view/login/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: media.width * 0.1),

                Text(
                  "Hey there!",
                  style: TextStyle(color: TColor.gray, fontSize: 16),
                ),

                Text(
                  "Create an Account",
                  style: TextStyle(
                    color: TColor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: media.width * 0.05),

                const RoundTextField(
                  hintText: "First Name",
                  icon: "assets/img/user_text.png",
                ),

                SizedBox(height: media.width * 0.04),

                const RoundTextField(
                  hintText: "Second Name",
                  icon: "assets/img/user_text.png",
                ),

                SizedBox(height: media.width * 0.04),

                const RoundTextField(
                  hintText: "Email ID",
                  icon: "assets/img/email.png",
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: media.width * 0.04),

                RoundTextField(
                  hintText: "Password",
                  icon: "assets/img/lock.png",
                  obscureText: true,
                  rightIcon: TextButton(
                    onPressed: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "assets/img/no_password.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        color: TColor.gray,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: media.width * 0.04),

                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                      icon: Icon(
                        isCheck
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank_outlined,
                        color: TColor.gray,
                        size: 20,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Expanded(
                        child: Text(
                          "By continuing you accept our Privacy Policy & \nTerms of Service",
                          style: TextStyle(color: TColor.gray, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: media.width * 0.4),

                RoundButton(
                  title: "Register",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompleteProfileView(),
                      ),
                    );
                  },
                ),

                SizedBox(height: media.width * 0.04),

                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: TColor.gray)),

                    Text(
                      "  OR  ",
                      style: TextStyle(color: TColor.black, fontSize: 10),
                    ),

                    Expanded(child: Container(height: 1, color: TColor.gray)),
                  ],
                ),

                SizedBox(height: media.width * 0.04),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(width: 1, color: TColor.gray),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          "assets/img/google.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: media.width * 0.04),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: TColor.black, fontSize: 14),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
