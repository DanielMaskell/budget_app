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
import 'models/payment.dart';

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
  var box = await Hive.openBox<PaymentHive>('paymentBoxTest');
  //box.clear();
  //var box = Hive.box('paymentBox');
  //box.deleteFromDisk();
  //box.add(PaymentHive(name: 'Test1', type: 'Power', date: DateTime.now(), occurence: 'single', amount: 24.00));
  //box.put('test1', [7, 8, 9]);
 // PaymentHive? tempPayment = box.getAt(0);
 // print('test1: ' + tempPayment!.name);

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
