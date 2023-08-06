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

  Future<void> removePayment(PaymentHive payment) async => service.removePayment(payment);

  Future<List<PaymentHive>> getPayments() async => service.getPayments();

  Future<int> clearPayments() async => service.clearPayments();
}
