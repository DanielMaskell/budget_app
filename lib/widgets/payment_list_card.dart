import 'package:budget_app/models/payment_hive.dart';
import 'package:budget_app/repository/payment_repository.dart';
import 'package:budget_app/repository/service/payment_service.dart';
import 'package:flutter/material.dart';

class PaymentListCard extends StatelessWidget {
  final PaymentHive? payment;
  final void Function({PaymentHive? payment, int? id}) editPaymentCallback;
  final void Function(PaymentHive payment) removePaymentCallback;
  // final int id;
  final PaymentRepository paymentRepository = PaymentRepository(service: PaymentService());

  PaymentListCard({
    Key? key,
    required this.payment,
    required this.removePaymentCallback,
    // required this.id,
    required this.editPaymentCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        removePaymentCallback(payment!);
                      },
                    ),
                    PopupMenuItem<String>(
                      child: const Text('Edit'),
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          editPaymentCallback(payment: payment);
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
