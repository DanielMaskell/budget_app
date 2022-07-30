import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatelessWidget {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                const Text('Login'),
              ],
            );
          }
          return Center(
            child: Text('Hello'),
          );
        },
      ),
    );
  }
}
