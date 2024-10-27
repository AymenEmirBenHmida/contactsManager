import 'package:flutter/material.dart';
import 'package:flutter_application_2/database/db_helper.dart';
import 'package:flutter_application_2/pages/addUser.dart';
import 'package:flutter_application_2/pages/modifyUser.dart';
import 'package:url_launcher/url_launcher.dart';

// Import your database helper

class ListUsersPage extends StatefulWidget {
  const ListUsersPage({super.key, required this.title});
  final String title;

  @override
  State<ListUsersPage> createState() => ListUsersPageState();
}

class ListUsersPageState extends State<ListUsersPage> {
  List<Map<String, dynamic>> listOfUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Fetch users from the database when the page is initialized
  }

  Future<void> _fetchUsers() async {
    List<Map<String, dynamic>> users = await UserDatabaseHelper().getUsers();
    setState(() {
      listOfUsers = users;
    });
  }

  void _callPhone(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    await launchUrl(launchUri);
  }

  void addUser(Map<String, String> newUser) async {
    await UserDatabaseHelper().insertUser(newUser);
    _fetchUsers(); // Refresh the list after adding a user
  }

  void modifyUser(Map<String, String> updatedUser) async {
    await UserDatabaseHelper().updateUser(updatedUser);
    _fetchUsers(); // Refresh the list after modifying a user
  }

  void deleteUser(int id) async {
    await UserDatabaseHelper().deleteUser(id);
    _fetchUsers(); // Refresh the list after deleting a user
  }

  void search(String query) {
    if (query.isEmpty) {
      _fetchUsers(); // Reset the list when the search query is empty
    } else {
      setState(() {
        listOfUsers = listOfUsers.where((user) {
          return user["email"]!.toLowerCase().contains(query.toLowerCase()) ||
              user["phone"]!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddUserPage(addUser: addUser)),
        ),
        child: Icon(Icons.add, color: Colors.green),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) => search(value),
              decoration: InputDecoration(hintText: 'Search users'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listOfUsers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(listOfUsers[index]["email"]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(listOfUsers[index]["phone"]),
                        IconButton(
                          onPressed: () =>
                              _callPhone(listOfUsers[index]["phone"]),
                          icon: Icon(Icons.phone, color: Colors.green),
                        ),
                        IconButton(
                          onPressed: () {
                            // Navigate to ModifyUserPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ModifyUserPage(
                                  modifyUser: modifyUser,
                                  user: listOfUsers[index],
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () => deleteUser(listOfUsers[index]["id"]),
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
