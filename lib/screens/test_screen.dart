import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);
  static const String routeName = '/second';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      drawer: const SafeArea(child: AppDrawer()),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
