// // ignore: avoid_web_libraries_in_flutter
// import 'dart:html';
// import 'package:dummyapp/pages/home.dart';
// import 'package:dummyapp/pages/login.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Splash extends StatefulWidget {
//   @override
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   Future login() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     if (preferences.getString('token') != null) {
//       print('has token');
//       Future.delayed(Duration(seconds: 3), () {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => Homepage()));
//       });
//     } else {
//       Future.delayed(Duration(seconds: 3), () {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => Login()));
//       });
//     }
//   }

//   @override
//   // ignore: override_on_non_overriding_member
//   void initstate() {
//     super.initState();
//     login();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("Dummy App"),
//       ),
//     );
//   }
// }
