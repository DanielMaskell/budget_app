import 'package:hive_flutter/hive_flutter.dart';
import 'package:budget_app/models/payment_hive.dart';

class PaymentRepository {
  final Box<PaymentHive> box = Hive.box<PaymentHive>('PaymentBoxTest');

  Future<int> addPayment(PaymentHive payment) async {
    // int newId = box.length;
    // payment.id = newId;

    return await box.add(payment);

    // var result = box.get(null, defaultValue: payment);

    // if (result == null) {
    //   return await box.add(payment);
    // } else {
    //   return 0;
    // }
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
