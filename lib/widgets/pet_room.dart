import 'package:flutter/material.dart';
import '../models/payment.dart';
import 'payment_details.dart';

class PaymentRoom extends StatelessWidget {
  final Payment payment;
  const PaymentRoom({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(payment.name),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: PaymentDetail(payment: payment),
      ),
    );
  }
}
