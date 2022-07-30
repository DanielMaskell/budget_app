import 'package:cloud_firestore/cloud_firestore.dart';
import 'payment.dart';

class Month {
  final String name;
  final DateTime date;
  List<Payment> payments;
  bool? ended;
  String? referenceId;

  Month(this.name, {required this.date, this.ended, required this.payments});

  factory Month.fromSnapshot(DocumentSnapshot snapshot) {
    final newMonth = Month.fromJson(snapshot.data() as Map<String, dynamic>);
    newMonth.referenceId = snapshot.reference.id;
    return newMonth;
  }

  factory Month.fromJson(Map<String, dynamic> json) => _monthFromJson(json);

  Map<String, dynamic> toJson() => _monthToJson(this);

  @override
  String toString() => 'Name<$name>';
}

Month _monthFromJson(Map<String, dynamic> json) {
  return Month(json['name'] as String,
      date: (json['date'] as Timestamp).toDate(),
      ended: json['ended'] as bool,
      payments: _convertPayments(json['payments'] as List<dynamic>));
}

Map<String, dynamic> _monthToJson(Month instance) => <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
      'ended': instance.ended
    };

List<Payment> _convertPayments(List<dynamic> paymentMap) {
  final payments = <Payment>[];

  for (final payment in paymentMap) {
    payments.add(Payment.fromJson(payment as Map<String, dynamic>));
  }
  return payments;
}
