import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';
import '../home_list.dart';

class AddPet extends StatelessWidget {
  const AddPet({Key? key}) : super(key: key);

  static const String routeName = '/addpayment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      drawer: SafeArea(child: AppDrawer()),
      body: Center(child: HomeList()),
    );
  }
}
