import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budget_app/repository/user_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  final UserRepository repository = UserRepository();

  var temp = [];
  var box;

  @override
  void initState() {
    super.initState();
    openBox();
    //addUserToDb();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openBox() async {
    box = await Hive.openBox('paymentBox');
    //temp = box.get('test2');
    temp.getRange(0, 5);
    print('temp:' + temp.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      drawer: SafeArea(child: AppDrawer()),
      body: Center(
        child: Text('Box Length: ' + temp.toString()),
        /*child: ElevatedButton(
          onPressed: () {
            // Navigate to the second screen when tapped.
          },
          child: const Text('Launch screen'),
        ),*/
      ),
    );
  }

  void addUserToDb() {
    User? user = FirebaseAuth.instance.currentUser;
    repository.addUser(user);
  }
}
