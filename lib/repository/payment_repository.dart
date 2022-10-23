import 'package:hive_flutter/hive_flutter.dart';
import 'package:budget_app/models/payment_hive.dart';

class PaymentRepository {
  final Box<PaymentHive> box  = Hive.box<PaymentHive>('PaymentBoxTest');

  void addPayment(PaymentHive payment){
    box.add(payment);
  }

  Map<dynamic, PaymentHive> getBox(){
    //int length = box.length;

    return box.toMap();
  }
}