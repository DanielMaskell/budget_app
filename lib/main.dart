import 'package:budget_app/models/payment_hive.dart';
import 'package:budget_app/repository/payment_repository.dart';
import 'package:budget_app/repository/service/payment_service.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/payment_cubit.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

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

  runApp(App());
}

class App extends StatelessWidget {
  final PaymentRepository pr = PaymentRepository(service: PaymentService());
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PaymentRepository(service: PaymentService()),
      child: MultiProvider(
        providers: [
          BlocProvider<PaymentCubit>(
            create: (context) => PaymentCubit(
              paymentRepository: pr,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: const LoginPage(),
          // home: const ProviderInit(),
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
        ),
      ),
    );
  }
}
