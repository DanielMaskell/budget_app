import 'package:budget_app/bloc/payment_cubit.dart';
import 'package:budget_app/models/payment_hive.dart';
import 'package:budget_app/widgets/homelist_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalAmount extends StatefulWidget {
  const TotalAmount({
    Key? key,
  }) : super(key: key);

  @override
  _TotalAmountState createState() => _TotalAmountState();
}

class _TotalAmountState extends State<TotalAmount> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state) {
      double totalAmount = 0;
      double spentLastMonth = 0;
      double spentThisMonth = 0;
      for (PaymentHive p in state.payments) {
        if (p.amount < 0) {
          totalAmount = totalAmount + p.amount;
          if (p.date.month == DateTime.now().month - 1) {
            spentLastMonth = spentLastMonth + p.amount;
          } else if (p.date.month == DateTime.now().month) {
            spentThisMonth = spentThisMonth + p.amount;
          }
        }
      }
      double averageSpent = totalAmount / state.payments.length;

      return Flexible(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: HomelistContainer(text: 'Total', amount: totalAmount),
                ),
                Expanded(
                  flex: 1,
                  child: HomelistContainer(text: 'Avg per day', amount: averageSpent),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: HomelistContainer(text: 'Last month', amount: spentLastMonth),
                ),
                Expanded(
                  flex: 1,
                  child: HomelistContainer(text: 'This month', amount: spentThisMonth),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
