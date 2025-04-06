import 'package:flutter/material.dart';
import 'package:stepsync/common/color_extension.dart';
import 'package:stepsync/common_widget/round_button.dart';
import 'package:stepsync/common_widget/round_text_field.dart';
import 'package:stepsync/view/login/complete_profile_view.dart';
import 'package:stepsync/view/login/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isCheck = false;
  bool isObscure = true;
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
                  "Welcome Back!",
                  style: TextStyle(
                    color: TColor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: media.width * 0.04),

                RoundTextField(
                  hintText: "Email ID",
                  icon: "assets/img/email.png",
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: media.width * 0.04),

                RoundTextField(
                  hintText: "Password",
                  icon: "assets/img/lock.png",
                  obscureText: isObscure,
                  keyboardType: TextInputType.visiblePassword,
                  rightIcon: TextButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
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

                SizedBox(height: media.width * 0.9),

                RoundButton(
                  title: "Login",
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
                        builder: (context) => const SignUpView(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: TColor.black, fontSize: 14),
                      ),
                      Text(
                        "Register",
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
