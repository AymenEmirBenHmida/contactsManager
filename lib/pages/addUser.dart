import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import the fluttertoast package

class AddUserPage extends StatefulWidget {
  AddUserPage({super.key, required this.addUser});
  final Function(Map<String, String>) addUser;

  @override
  State<AddUserPage> createState() => AddUserPageState();
}

class AddUserPageState extends State<AddUserPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pseudoController = TextEditingController();
  void addUser(user) {
    widget.addUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: IconButton(
          icon: Icon(Icons.add, color: Colors.green),
          onPressed: () {},
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                  decoration: InputDecoration(hintText: "email"),
                  controller: emailController,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "pseudo"),
                  controller: pseudoController,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "phone"),
                ),
                Row(children: [
                  ElevatedButton(
                      onPressed: () {
                        // Add new user when the floating button is pressed
                        if (emailController.text == "" ||
                            pseudoController.text == "" ||
                            phoneController.text == "") {
                          Fluttertoast.showToast(
                            msg: "there is an empty field",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          Map<String, String> newUser = {
                            'email': emailController.text,
                            'pseudo': pseudoController.text,
                            'phone': phoneController.text,
                          };

                          addUser(newUser);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Add",
                        textDirection: TextDirection.ltr,
                      )),
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
