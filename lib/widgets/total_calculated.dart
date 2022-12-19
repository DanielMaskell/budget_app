import 'package:budget_app/models/payment_hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/payment.dart';

class TotalCalculator extends StatefulWidget {
  final Box<PaymentHive>? paymentBox;
  final Map<dynamic, PaymentHive> payments;

  const TotalCalculator({required Key? key, required this.payments, this.paymentBox});

  @override
  _TotalCalculatorState createState() => _TotalCalculatorState();
}

class _TotalCalculatorState extends State<TotalCalculator> {
  int? totalAmount;
  List<Payment>? paymentList;
  late List<int> keys;
  double total = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    total = 0;
    keys = widget.payments.keys.cast<int>().toList();

    print('payments: ${widget.payments.toString()}');
    for (int i = 0; i < widget.payments.length; i++) {
      total = total + widget.payments[i]!.amount;
    }
    return Text('Total: ${total.toString()}');
  }
}
