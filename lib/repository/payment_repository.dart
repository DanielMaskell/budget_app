import 'package:hive_flutter/hive_flutter.dart';
import 'package:budget_app/models/payment_hive.dart';
import 'package:budget_app/repository/service/payment_service.dart';

class PaymentRepository {
  PaymentRepository({
    required this.service,
  });
  final PaymentService service;
  final Box<PaymentHive> box = Hive.box<PaymentHive>('PaymentBoxTest');

  Future<int> addPayment(PaymentHive payment) async => service.addPayment(payment);

  Future<void> removePayment(PaymentHive payment, int id) async => service.removePayment(payment, id);

  Future<List<PaymentHive>> getPayments() async => service.getPayments();

  Future<int> addPaymentOld(PaymentHive payment) async {
    int newId = box.length;
    payment.id = newId;

    return await box.add(payment);

    var result = box.get(null, defaultValue: payment);

    if (result == null) {
      return await box.add(payment);
    } else {
      return 0;
    }
  }

  Future<int> clearPayments() async => service.clearPayments();

  // void removePayment(PaymentHive payment, int id) {
  //   try {
  //     box.delete(payment.key);
  //   } catch (e) {
  //     print('Error deleting payment: ${e.toString()}');
  //   }
  // }

  // void editPayment(PaymentHive payment, int id, PaymentHive oldPayment) {
  //   print('Edit payment called: paymentId: ${payment.key}');

  //   box.put(oldPayment.key, payment);
  // }

  // Map<dynamic, PaymentHive> getBox() {
  //   return box.toMap();
  // }
}
