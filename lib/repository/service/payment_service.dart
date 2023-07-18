import 'package:budget_app/models/payment_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PaymentService {
  PaymentService();

  final Box<PaymentHive> box = Hive.box<PaymentHive>('PaymentBoxTest');

  Future<int> addPayment(PaymentHive payment) async {
    return await box.add(payment);
  }

  void removePayment(PaymentHive payment, int id) {
    try {
      box.delete(payment.key);
    } catch (e) {
      print('Error deleting payment: ${e.toString()}');
    }
  }

  void editPayment(PaymentHive payment, int id, PaymentHive oldPayment) {
    print('Edit payment called: paymentId: ${payment.key}');

    box.put(oldPayment.key, payment);
  }

  Future<int> clearPayments() async {
    var result = await box.clear();
    print('Clearing box: $result');

    return result;
  }

  Future<List<PaymentHive>> getPayments() async {
    print('Getting payments');
    List<PaymentHive> payments = [];
    print('box length: ${box.length}');

    box.toMap().forEach(
      (key, value) {
        PaymentHive tempItem = PaymentHive(
          name: value.name,
          type: value.type,
          date: value.date,
          occurence: value.occurence,
          amount: value.amount,
        );
        payments.add(tempItem);
      },
    );
    print('Payments length: ${payments.length}');
    return payments;
  }
}
