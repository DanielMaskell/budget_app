import 'package:budget_app/bloc/payment_cubit.dart';
import 'package:budget_app/repository/payment_repository.dart';
import 'package:budget_app/repository/service/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budget_app/repository/user_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/payment_hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  final UserRepository repository = UserRepository();

  var temp = [];
  late Box<PaymentHive> box;

  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().getPayments();
    // MultiBlocProvider(
    //     providers: [
    //       BlocProvider<PaymentCubit>(
    //         create: (context) => PaymentCubit(
    //           paymentRepository: context.read<PaymentRepository>(),
    //         ),
    //       ),
    //     ],
    //     child: BlocBuilder<PaymentCubit, PaymentState>(
    //       builder: (context, state) {
    //         return Center(
    //           // child: Text('Box Length: ' + box.length.toString()),
    //           child: Text(
    //               'Payments: ${state.payments?.length.toString() ?? 'No payments'}'),
    //         );
    //       },
    //     ));

    // context.read<PaymentCubit>().getPayments();
    openBox();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openBox() async {
    box = Hive.box<PaymentHive>('paymentBoxTest');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      drawer: const SafeArea(child: AppDrawer()),
      // body: const Text('Hello')
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return Center(
            // child: Text('Box Length: ' + box.length.toString()),
            child: Text(
                'Payments: ${state.payments?.length.toString() ?? 'No payments'}'),
          );
        },
      ),

      // body: RepositoryProvider(
      //   create: (context) => PaymentRepository(service: PaymentService()),
      //   child: MultiBlocProvider(
      //       providers: [
      //         BlocProvider<PaymentCubit>(
      //           create: (context) => PaymentCubit(
      //             paymentRepository: context.read<PaymentRepository>(),
      //           ),
      //         ),
      //       ],
      //       child: BlocBuilder<PaymentCubit, PaymentState>(
      //         builder: (context, state) {
      //           return Center(
      //             // child: Text('Box Length: ' + box.length.toString()),
      //             child: Text(
      //                 'Payments: ${state.payments?.length.toString() ?? 'No payments'}'),
      //           );
      //         },
      //       )),
      // )
      // body: Center(
      //   child: Text('Box Length: ' + box.length.toString()),
      // ),
    );
  }

  void addUserToDb() {
    User? user = FirebaseAuth.instance.currentUser;
    repository.addUser(user);
  }
}
