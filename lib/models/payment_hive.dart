import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'payment_hive.g.dart';

@HiveType(typeId: 1)
class PaymentHive extends HiveObject implements Comparable<PaymentHive> {
  @HiveField(0)
  dynamic id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String type;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final int? referenceId;

  @HiveField(6)
  final String occurence;

  @HiveField(7)
  final double amount;

  PaymentHive({
    this.id,
    required this.name,
    this.description,
    required this.type,
    required this.date,
    this.referenceId,
    required this.occurence,
    required this.amount,
  });

  @override
  int compareTo(PaymentHive other) {
    if (date.isBefore(other.date)) {
      return -1;
    } else if (date.isAfter(other.date)) {
      return 1;
    } else {
      return 0;
    }
  }

  String? print() {
    String string = '{\n';
    string += ' id: ' + (id.toString() + ',\n');
    string += ' name: ' + (name + ',\n');
    string += ' description: ' + (description ?? 'null');
    string += ',\n';
    string += ' type: ' + (type + ',\n');
    string += ' date: ' + (date.toString() + ',\n');
    string += ' referenceId: ' + (referenceId.toString() + ',\n');
    string += ' occurence: ' + (occurence + ',\n');
    string += ' amount: ' + (amount.toString() + ',\n');
    string += '},\n';
    return string;
  }

  static PaymentHive _paymentFromJson(Map<String, dynamic> json) {
    return PaymentHive(
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      occurence: json['occurence'] as String,
      date: (json['date'] as Timestamp).toDate(),
      amount: json['amount'] as double,
    );
  }

  Map<String, dynamic> _paymentToJson(PaymentHive instance) =>
      <String, dynamic>{
        'name': instance.name,
        'description': instance.description,
        'type': instance.type,
        'date': instance.date,
        'occurence': instance.occurence,
        'amount': instance.amount
      };

  factory PaymentHive.fromJson(Map<String, dynamic> json) =>
      _paymentFromJson(json);
  Map<String, dynamic> toJson() => _paymentToJson(this);
}
