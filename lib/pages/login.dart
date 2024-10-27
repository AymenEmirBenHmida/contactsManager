import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/pages/listUsers.dart';

import 'package:fluttertoast/fluttertoast.dart'; // Import the fluttertoast package
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool login = false;
  //ction to load saved value from SharedPreferences
  _loadSavedValueSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool("login");
  }

  _saveValueSharedPref(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", value);
  }

  testing() async {
    bool loginStatus = await _loadSavedValueSharedPref() ?? false;
    if (loginStatus) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ListUsersPage(
                    title: "list of users page",
                  )));
    }
  }

  _testLoginStatus() {
    testing();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _testLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
            width: 500,
            height: 200,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: "name"),
                  controller: emailController,
                ),
                TextFormField(
                    decoration: InputDecoration(hintText: "password"),
                    controller: passwordController),
                Row(
                  children: [
                    Checkbox(
                      tristate: true, // Example with tristate
                      value: login,
                      onChanged: (bool? newValue) {
                        setState(() {
                          login = newValue!;
                        });
                      },
                    ),
                    const Text('Stay Logged In'), // Label for the checkbox
                  ],
                ),
                Row(children: [
                  ElevatedButton(
                      onPressed: () async => {
                            if (emailController.text == "aymen" &&
                                passwordController.text == "00")
                              {
                                if (login)
                                  {
                                    _saveValueSharedPref(true),
                                  }
                                else
                                  _saveValueSharedPref(false),
                                print("login successful"),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListUsersPage(
                                              title: "list of users page",
                                            )))
                              }
                            else
                              {
                                Fluttertoast.showToast(
                                  msg: "login credentials wrong",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                )
                              }
                          },
                      child: Text(
                        "Login",
                        textDirection: TextDirection.ltr,
                      )),
                  ElevatedButton(
                      onPressed: () => {exit(0)}, child: Text("Exit"))
                ])
              ],
            )),
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
