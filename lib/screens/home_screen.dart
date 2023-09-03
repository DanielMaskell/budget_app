import 'package:budget_app/bloc/payment_cubit.dart';
import 'package:budget_app/routes/routes.dart';
import 'package:budget_app/widgets/total_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Column(
                children: [
                  const Text('Spending Stats:', style: TextStyle(fontSize: 30)),
                  InkWell(
                    child: const TotalAmount(),
                    onTap: () => Navigator.pushReplacementNamed(context, Routes.addPayment),
                  )
                ],
              ),
              const Spacer(),
              Center(
                child: Text('Payments: ${state.payments.length.toString()}'),
              ),
            ],
          ),
        );
      },
    );
  }
}
