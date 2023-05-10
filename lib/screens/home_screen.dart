import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budget_app/repository/user_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/payment_hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  final UserRepository repository = UserRepository();

  var temp = [];
  late Box<PaymentHive> box;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openBox() async {
    box = Hive.box<PaymentHive>('paymentBoxTest');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      drawer: const SafeArea(child: AppDrawer()),
      body: Center(
        child: Text('Box Length: ' + box.length.toString()),
      ),
    );
  }

  void addUserToDb() {
    User? user = FirebaseAuth.instance.currentUser;
    repository.addUser(user);
  }
}
