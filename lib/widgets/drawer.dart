import 'package:flutter/material.dart';
import 'package:budget_app/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(icon: Icons.contacts, text: 'Home', onTap: () => Navigator.pushReplacementNamed(context, Routes.home)),
          _createDrawerItem(icon: Icons.event, text: 'Payments', onTap: () => Navigator.pushReplacementNamed(context, Routes.addPayment)),
          _createDrawerItem(icon: Icons.event, text: 'Stats', onTap: () => Navigator.pushReplacementNamed(context, Routes.stats)),
          _createDrawerItem(icon: Icons.event, text: 'Graphs', onTap: () => Navigator.pushReplacementNamed(context, Routes.graphScreen)),
          const Divider(),
          _createDrawerItem(icon: Icons.event, text: 'Profile Page', onTap: () => Navigator.pushReplacementNamed(context, Routes.profile)),
          const Divider(),
          _createDrawerItem(icon: Icons.event, text: 'CSV Page', onTap: () => Navigator.pushReplacementNamed(context, Routes.csv)),
          const Divider(),
          _createDrawerItem(icon: Icons.event, text: 'Sign Out', onTap: () => {FirebaseAuth.instance.signOut(), Navigator.pushReplacementNamed(context, Routes.login)}),
          const Divider(),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return const DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Stack(children: <Widget>[
        Positioned(
          bottom: 12.0,
          left: 16.0,
          child: Text(
            "Flutter Step-by-Step",
            style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
        ),
      ]),
    );
  }

  Widget _createDrawerItem({IconData? icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
