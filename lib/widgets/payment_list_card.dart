import 'package:budget_app/models/payment_hive.dart';
import 'package:flutter/material.dart';

class PaymentListCard extends StatelessWidget {
  final PaymentHive? payment;
  final void Function({PaymentHive? payment, int? id}) editPaymentCallback;
  final void Function(PaymentHive payment, int id) removePaymentCallback;
  final int id;

  const PaymentListCard({
    Key? key,
    required this.payment,
    required this.removePaymentCallback,
    required this.id,
    required this.editPaymentCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey,
      child: payment != null
          ? Row(
              children: [
                Column(
                  children: [
                    Text(payment?.name ?? ''),
                    Text(
                      payment!.amount.toString(),
                    ),
                  ],
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  initialValue: 'Remove',
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      child: const Text('Remove'),
                      onTap: () {
                        removePaymentCallback(payment!, id);
                      },
                    ),
                    PopupMenuItem<String>(
                      child: const Text('Edit'),
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          editPaymentCallback(payment: payment, id: id);
                        });
                      },
                    ),
                  ],
                ),
              ],
            )
          : Container(),
    );
  }
}
