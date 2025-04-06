import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stepsync/view/home/home_view.dart';
import 'package:stepsync/view/login/login_view.dart';
// import 'package:stepsync/view/login/welcome_view.dart';
// import 'package:stepsync/view/on_boarding/started_view.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeView();
          } else {
            return LoginView();
          }
        },
      ),
    );
  }
}
