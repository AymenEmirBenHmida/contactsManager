import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ModifyUserPage extends StatefulWidget {
  ModifyUserPage({super.key, required this.modifyUser, required this.user});
  final Function(Map<String, String>) modifyUser;
  Map<String, dynamic> user;

  @override
  State<ModifyUserPage> createState() => ModifyUserPageState();
}

class ModifyUserPageState extends State<ModifyUserPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pseudoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.user["email"];
    phoneController.text = widget.user["phone"];
    pseudoController.text = widget.user["pseudo"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify User'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Email"),
              controller: emailController,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Pseudo"),
              controller: pseudoController,
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Phone"),
            ),
            ElevatedButton(
              onPressed: () {
                if (emailController.text.isEmpty ||
                    pseudoController.text.isEmpty ||
                    phoneController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "There is an empty field",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  Map<String, String> updatedUser = {
                    'id': widget.user['id'].toString(),
                    'email': emailController.text,
                    'pseudo': pseudoController.text,
                    'phone': phoneController.text,
                  };
                  widget.modifyUser(updatedUser);
                  Navigator.pop(context);
                }
              },
              child: Text("Modify"),
            ),
          ],
        ),
      ),
    );
  }
}
