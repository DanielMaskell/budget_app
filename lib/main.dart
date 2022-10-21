import 'package:budget_app/models/payment_hive.dart';
import 'package:budget_app/screens/add_payment.dart';
import 'package:budget_app/screens/adduser_screen.dart';
import 'package:budget_app/screens/login_screen.dart';
import 'package:budget_app/screens/home_screen.dart';
import 'package:budget_app/screens/test_screen.dart';
import 'package:budget_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/routes/Routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/date_hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  await Hive.initFlutter();
  Hive.registerAdapter(DateHiveAdapter());
  Hive.registerAdapter(PaymentHiveAdapter());
  await Hive.openBox('paymentBox');
  var box = Hive.box('paymentBox');
  box.put('test', [4, 5, 6]);
  print('test: ' + box.get('test').toString());

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(primarySwatch: Colors.indigo),

    home: LoginPage(),
    //home: const HomeScreen(),
    routes: {
      Routes.home: (context) => const HomeScreen(),
      Routes.second: (context) => const SecondScreen(),
      Routes.adduser: (context) => AddUser(),
      Routes.addpet: (context) => const AddPet(),
      Routes.profile: (context) => const ProfilePage(),
      Routes.login: (context) => LoginPage()
    },
  ));
}
