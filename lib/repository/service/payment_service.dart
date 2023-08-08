import 'package:budget_app/models/payment_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PaymentService {
  PaymentService();

  final Box<PaymentHive> box = Hive.box<PaymentHive>('PaymentBoxTest');

  Future<int> addPayment(PaymentHive payment) async {
    // payment.id = box.length;
    print('adding paymnet id: ${payment.id}');
    return await box.add(payment);
  }

  void removePayment(PaymentHive payment) async {
    try {
      box.delete(payment.id);
      // box.deleteAt(index)
      // print('removePayment: ${result.toString()}');
    } catch (e) {
      print('Error deleting payment: ${e.toString()}');
    }
  }

  void editPayment(PaymentHive payment, PaymentHive oldPayment) {
    print('Edit payment called: paymentId: ${oldPayment.key}');

    box.put(oldPayment.key.toString(), payment);
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
        print('item value: ${key} ${value.name}');
        PaymentHive tempItem = PaymentHive(
          id: key,
          name: value.name,
          type: value.type,
          date: value.date,
          occurence: value.occurence,
          amount: value.amount,
        );
        print('tempItem id: ${tempItem.id}');
        payments.add(tempItem);
      },
    );
    print('Payments length: ${payments.length}');
    return payments;
  }
}
