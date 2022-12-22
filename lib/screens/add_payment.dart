import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';
import '../widgets/home_list.dart';

class AddPet extends StatefulWidget {
  AddPet({
    Key? key, 
  }) : super(key: key);

  static const String routeName = '/addpayment';

  @override
  State<StatefulWidget> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {

  @override 
  void initState(){
    super.initState();
  }

  GlobalKey? homeListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      drawer: SafeArea(child: AppDrawer()),
      body: Center(child: HomeList(key: homeListKey, homeListCallback: homeListCallback,))
    );
  }

  void homeListCallback(){
    print('check homelist callback');
    setState(() {
      homeListKey = GlobalKey();
    });
  }
}
