import 'dart:convert';

import 'package:dummyapp/api/api.dart';
import 'package:dummyapp/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future login(String email, String password) async {
    var response = await Api().login('login', email, password);
    var data = json.decode(response.body);
    print(data);
    if (data['code'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("token", data['token']);
      message = "";
      setState(() {});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      print("Invalid user or password");
      message = "Invalid username or password";
      setState(() {});
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (value) => value.isEmpty ? 'required' : null,
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (value) => value.isEmpty ? 'required' : null,
                ),
                message == null
                    ? SizedBox()
                    : Text(
                        "$message",
                        style: TextStyle(color: Colors.red),
                      ),
                RaisedButton(
                  onPressed: () {
                    login(email.text, password.text);
                  },
                  child: Text("Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
