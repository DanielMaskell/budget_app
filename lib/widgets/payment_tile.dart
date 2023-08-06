import 'package:budget_app/models/payment_hive.dart';
import 'package:flutter/material.dart';

class PaymentTile extends StatefulWidget {
  // PaymentHive? payment;

  // PaymentTile({Key? key, PaymentHive? payment}) : super(key: key);

  PaymentHive payment;

  PaymentTile({Key? key, required this.payment}) : super(key: key);

  @override
  _PaymentTileState createState() => _PaymentTileState();
}

class _PaymentTileState extends State<PaymentTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('payment: ${widget.payment.toString()}');
    // return ListTile(title: Text(widget.payment ?? 'Error: No name'));
    return Container(
        color: Colors.blueGrey.shade100,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.payment.name),
                Text('\$${widget.payment.amount.toString()}'),
              ],
            )
          ],
        ));
  }
}
