import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_app/widgets/drawer.dart';

class AddUser extends StatelessWidget {
  static const String routeName = '/adduser';

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      return users
          .add({'full_name': "john", 'company': "Fun", 'age': 567})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
      drawer: const SafeArea(child: AppDrawer()),
      body: Center(
          child: TextButton(
        onPressed: addUser,
        child: const Text(
          "Add User",
        ),
      )),
    );
  }
}
