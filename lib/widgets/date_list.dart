import 'package:budget_app/models/payment_hive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateList extends StatelessWidget {
  final PaymentHive payment;
  final Widget Function(DateTime) buildRow;
  const DateList({Key? key, required this.payment, required this.buildRow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 6.0),
        const Text(
          'Date',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(DateFormat('dd-MM-yyyy').format(payment.date)),
      ],
    );
  }
}
