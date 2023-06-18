import 'package:budget_app/models/payment_hive.dart';
import 'package:budget_app/screens/add_payment.dart';
import 'package:budget_app/screens/csv_screen.dart';
import 'package:budget_app/screens/graph_screen.dart';
import 'package:budget_app/screens/login_screen.dart';
import 'package:budget_app/screens/home_screen.dart';
import 'package:budget_app/screens/profile_screen.dart';
import 'package:budget_app/screens/stats_screen.dart';
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

  // Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //   return firebaseApp;
  // }

  await Hive.initFlutter();
  Hive.registerAdapter(DateHiveAdapter());
  Hive.registerAdapter(PaymentHiveAdapter());

  await Hive.openBox<PaymentHive>('paymentBoxTest');
  // box.clear();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: const LoginPage(),
    routes: {
      Routes.home: (context) => const HomeScreen(),
      // Routes.adduser: (context) => AddUser(),
      Routes.addpet: (context) => const AddPayment(),
      Routes.profile: (context) => const ProfilePage(),
      Routes.login: (context) => const LoginPage(),
      Routes.graphScreen: (context) => const GraphScreen(),
      Routes.stats: (context) => const StatsScreen(),
      Routes.csv: (context) => const CsvPage(),
    },
  ));
}
