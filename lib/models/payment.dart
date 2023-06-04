import 'package:cloud_firestore/cloud_firestore.dart';

class Payment extends Comparable {
  String name;
  String? description;
  String type;
  DateTime date;
  String? referenceId;
  String occurence;
  double amount;

  Payment(
      {required this.name,
      this.description,
      required this.type,
      required this.date,
      required this.occurence,
      required this.amount});

  factory Payment.fromSnapshot(DocumentSnapshot snapshot) {
    final newPayment =
        Payment.fromJson(snapshot.data() as Map<String, dynamic>);
    newPayment.referenceId = snapshot.reference.id;
    return newPayment;
  }

  factory Payment.fromJson(Map<String, dynamic> json) => _paymentFromJson(json);

  Map<String, dynamic> toJson() => _paymentToJson(this);

  @override
  String toString() => 'Payment<$name>';

  @override
  int compareTo(other) {
    return date.compareTo(other.date);
  }
}

Payment _paymentFromJson(Map<String, dynamic> json) {
  return Payment(
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      occurence: json['occurence'] as String,
      date: (json['date'] as Timestamp).toDate(),
      amount: json['amount'] as double);
}

Map<String, dynamic> _paymentToJson(Payment instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'date': instance.date,
      'occurence': instance.occurence,
      'amount': instance.amount
    };
