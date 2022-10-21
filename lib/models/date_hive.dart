import 'package:hive/hive.dart';

part 'date_hive.g.dart';

@HiveType(typeId: 0)
class DateHive {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final bool? done;

  DateHive({required this.name, required this.date, required this.done});
}
