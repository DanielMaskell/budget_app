import 'package:flutter/material.dart';

import 'models/payment.dart';
import 'models/date.dart';

class DateList extends StatelessWidget {
  final Payment payment;
  final Widget Function(Date) buildRow;
  const DateList({Key? key, required this.payment, required this.buildRow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 6.0),
        const Text(
          'Dates',
          style: TextStyle(fontSize: 16.0),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            itemCount: payment.dates.length,
            itemBuilder: (BuildContext context, int index) {
              return buildRow(payment.dates[index]);
            },
          ),
        ),
      ],
    );
  }
}
