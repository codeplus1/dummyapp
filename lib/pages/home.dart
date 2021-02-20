import 'dart:convert';

import 'package:dummyapp/api/api.dart';
import 'package:dummyapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future getPersonDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response =
        await Api().getdata('persons', preferences.getString('token'));
    var data = json.decode(response.body);
    return data;
  }

  Future logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response =
        await Api().getdata('logout', preferences.getString('token'));
    var data = json.decode(response.body);

    if (data['code'] == 200) {
      preferences.remove('token');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("logout"),
              onTap: () {
                logout();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: getPersonDetails(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data[index]['name']),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Cannot load at this moment");
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }
}
