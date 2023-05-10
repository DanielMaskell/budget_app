import 'package:hive_flutter/hive_flutter.dart';
import 'package:budget_app/models/payment_hive.dart';

class PaymentRepository {
  final Box<PaymentHive> box = Hive.box<PaymentHive>('PaymentBoxTest');

  Future<int> addPayment(PaymentHive payment) {
    int newId = box.length;
    payment.id = newId;
    return box.add(payment);
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

  Map<dynamic, PaymentHive> getBox() {
    return box.toMap();
  }
}
