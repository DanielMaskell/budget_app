import 'package:budget_app/bloc/payment_cubit.dart';
import 'package:budget_app/screens/add_payment.dart';
import 'package:budget_app/screens/graph_screen.dart';
import 'package:budget_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budget_app/repository/user_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/payment_hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State {
  final UserRepository repository = UserRepository();

  var temp = [];
  late Box<PaymentHive> box;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    const AddPayment(),
    const GraphScreen(),
  ];

  final List<String> _titles = ['Home', 'Payments', 'Graph'];

  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().getPayments();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: const SafeArea(child: AppDrawer()),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: _selectedIndex == 0 ? Colors.lightBlue : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.payments),
            label: 'Payments',
            backgroundColor: _selectedIndex == 1 ? Colors.lightBlue : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.show_chart),
            label: 'Graphs',
            backgroundColor: _selectedIndex == 2 ? Colors.lightBlue : Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  void addUserToDb() {
    User? user = FirebaseAuth.instance.currentUser;
    repository.addUser(user);
  }
}
