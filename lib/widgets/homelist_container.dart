import 'package:flutter/material.dart';

class HomelistContainer extends StatelessWidget {
  final String text;
  final double amount;

  const HomelistContainer({
    Key? key,
    required this.text,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 20, 20, 5),
      child: Column(
        children: [
          Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, decoration: TextDecoration.underline)),
          Text(amount.toStringAsFixed(2), style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
