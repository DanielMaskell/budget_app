// import 'package:budget_app/bloc/payment_cubit.dart';
// import 'package:budget_app/repository/payment_repository.dart';
// import 'package:budget_app/repository/service/payment_service.dart';
// import 'package:budget_app/screens/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:budget_app/models/payment_hive.dart';
// import 'package:budget_app/provider_init.dart';
// import 'package:budget_app/repository/payment_repository.dart';
// import 'package:budget_app/screens/add_payment.dart';
// import 'package:budget_app/screens/csv_screen.dart';
// import 'package:budget_app/screens/graph_screen.dart';
// import 'package:budget_app/screens/login_screen.dart';
// import 'package:budget_app/screens/home_screen.dart';
// import 'package:budget_app/screens/profile_screen.dart';
// import 'package:budget_app/screens/stats_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:budget_app/routes/Routes.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'bloc/payment_cubit.dart';

// class ProviderInit extends StatelessWidget {
//   const ProviderInit({Key? key});

//   // @override
//   // void initState() {
//   //   // super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<PaymentCubit>(
//           create: (context) => PaymentCubit(
//             paymentRepository: context.read<PaymentRepository>(),
//           ),
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(primarySwatch: Colors.indigo),
//         home: const LoginPage(),
//         // home: const ProviderInit(),
//         routes: {
//           Routes.home: (context) => const HomeScreen(),
//           // Routes.adduser: (context) => AddUser(),
//           Routes.addpet: (context) => const AddPayment(),
//           Routes.profile: (context) => const ProfilePage(),
//           Routes.login: (context) => const LoginPage(),
//           Routes.graphScreen: (context) => const GraphScreen(),
//           Routes.stats: (context) => const StatsScreen(),
//           Routes.csv: (context) => const CsvPage(),
//         },
//       ),
//     );
//   }
// }
