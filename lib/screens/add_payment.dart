import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';
import '../widgets/home_list.dart';

class AddPayment extends StatefulWidget {
  const AddPayment({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/addpayment';

  @override
  State<StatefulWidget> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey homeListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payments'),
        ),
        drawer: const SafeArea(child: AppDrawer()),
        body: Center(
          child: HomeList(
            key: homeListKey,
            homeListCallback: homeListCallback,
          ),
        ));
  }

  void homeListCallback() {
    setState(() {
      homeListKey = GlobalKey();
    });
  }
}
