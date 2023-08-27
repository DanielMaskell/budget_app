import 'package:budget_app/routes/routes.dart';
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

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, Routes.addPayment);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, Routes.graphScreen);
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      // appBar: AppBar(
      //   title: const Text('Home Screen'),
      // ),
      drawer: const SafeArea(
        child: AppDrawer(),
      ),
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Payments', backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Graphs', backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Graphs', backgroundColor: Colors.lightBlue),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
