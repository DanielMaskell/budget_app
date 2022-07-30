import 'package:cloud_firestore/cloud_firestore.dart';
import 'date.dart';

class Payment {
  String name;
  String? description;
  String type;
  List<Date> dates;
  String? referenceId;
  String occurence;
  double amount;

  Payment(this.name,
      {this.description,
      required this.type,
      required this.dates,
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
}

Payment _paymentFromJson(Map<String, dynamic> json) {
  return Payment(json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      occurence: json['occurence'] as String,
      dates: _convertDates(json['dates'] as List<dynamic>),
      amount: json['amount'] as double);
}

List<Date> _convertDates(List<dynamic> dateMap) {
  final dates = <Date>[];

  for (final date in dateMap) {
    dates.add(Date.fromJson(date as Map<String, dynamic>));
  }
  return dates;
}

Map<String, dynamic> _paymentToJson(Payment instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'dates': _dateList(instance.dates),
      'occurence': instance.occurence,
      'amount': instance.amount
    };

List<Map<String, dynamic>>? _dateList(List<Date>? dates) {
  if (dates == null) {
    return null;
  }
  final dateMap = <Map<String, dynamic>>[];
  dates.forEach((date) {
    dateMap.add(date.toJson());
  });
  return dateMap;
}
