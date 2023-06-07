import 'package:budget_app/models/payment_hive.dart';
import 'package:flutter/material.dart';

class TotalCalculator extends StatefulWidget {
  final List<PaymentHive> payments;
  final double height = 75;

  const TotalCalculator({
    Key? key,
    required this.payments,
  }) : super(key: key);

  @override
  _TotalCalculatorState createState() => _TotalCalculatorState();
}

class _TotalCalculatorState extends State<TotalCalculator> {
  int? totalAmount;
  List<PaymentHive>? paymentList;
  late List<int> keys;
  double total = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    total = 0;
    for (int i = 0; i < widget.payments.length; i++) {
      total = total + widget.payments[i].amount;
    }
    return SizedBox(
        height: widget.height,
        child: Row(
          children: [
            const Text(
              'Total: ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
            ),
          ],
        ));
  }
}
