import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:stepsync/common/color_extension.dart';
import 'package:stepsync/common_widget/round_button.dart';
import 'package:stepsync/common_widget/round_text_field.dart';
import 'package:stepsync/view/login/forgot_password.dart';
import 'package:stepsync/view/login/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void signIn(
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      if (userCredential.user != null) {
        // ✅ Login successful – Navigate to dashboard
        Navigator.pushReplacementNamed(context, 'dashboard');
      } else {
        // 🛑 Login failed – Show error
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login failed')));
      }
    } catch (e) {
      // 🛑 Error while logging in (invalid email, wrong password, etc.)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid Email or Password')));
    }
  }

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
                  controller: email,
                ),

                SizedBox(height: media.width * 0.04),

                RoundTextField(
                  controller: password,
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

                SizedBox(height: media.width * 0.85),

                RoundButton(
                  title: "Login",
                  onPressed: () {
                    if (email.text.isEmpty || password.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter both email and password"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      signIn(
                        email,
                        password,
                      ); // ✅ Firebase check with error handling
                    }
                  },
                ),

                SizedBox(height: media.width * 0.04),

                RoundButton(
                  title: "Forgot Password?",
                  onPressed: (() => Get.to(ForgotPassword())),
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
                  onPressed: (() => Get.to(SignUpView())),

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
