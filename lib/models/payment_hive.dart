import 'package:hive/hive.dart';

part 'payment_hive.g.dart';

@HiveType(typeId: 1)
class PaymentHive {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String? referenceId;

  @HiveField(5)
  final String occurence;

  @HiveField(6)
  final double amount;

  PaymentHive(
      {required this.name,
      this.description,
      required this.type,
      required this.date,
      required this.referenceId,
      required this.occurence,
      required this.amount});
}
