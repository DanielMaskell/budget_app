import 'package:flutter/material.dart';
import 'package:budget_app/routes/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.contacts,
              text: 'Home',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.home)),
          _createDrawerItem(
              icon: Icons.event,
              text: 'Second',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.second)),
          const Divider(),
          _createDrawerItem(
              icon: Icons.event,
              text: 'Add User',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.adduser)),
          const Divider(),
          _createDrawerItem(
              icon: Icons.event,
              text: 'Add Payment',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.addpet)),
          const Divider(),
          _createDrawerItem(
              icon: Icons.event,
              text: 'Proflie Page',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.profile)),
          const Divider(),
          _createDrawerItem(
              icon: Icons.event,
              text: 'Sign Out',
              onTap: () => {
                    FirebaseAuth.instance.signOut(),
                    Navigator.pushReplacementNamed(context, Routes.login)
                  }),
          const Divider(),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        /*decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                //image: AssetImage('res/images/drawer_header_background.png')
                )),*/
        child: Stack(children: const <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Flutter Step-by-Step",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData? icon, required String text, GestureTapCallback? onTap}) {
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
