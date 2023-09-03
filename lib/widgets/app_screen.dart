import 'package:budget_app/screens/add_payment.dart';
import 'package:budget_app/screens/graph_screen.dart';
import 'package:budget_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';

class AppScreen extends StatefulWidget {
  final Widget child;

  const AppScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.of(context, rootNavigator: true).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child;
            },
          ),
        );
        break;
      case 1:
        Navigator.of(context, rootNavigator: true).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const AddPayment(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child;
            },
          ),
        );
        break;
      case 2:
        Navigator.of(context, rootNavigator: true).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const GraphScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child;
            },
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SafeArea(
        child: AppDrawer(),
      ),
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.green,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: _selectedIndex == 0 ? Colors.lightBlue : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Payments',
            backgroundColor: _selectedIndex == 1 ? Colors.lightBlue : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: 'Graphs',
            backgroundColor: _selectedIndex == 2 ? Colors.lightBlue : Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
