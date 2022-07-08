import 'package:cloud_firestore/cloud_firestore.dart';

class Date {
  final String name;
  final DateTime date;
  bool? done;

  Date(this.name, {required this.date, this.done});

  factory Date.fromJson(Map<String, dynamic> json) => _dateFromJson(json);

  Map<String, dynamic> toJson() => _dateToJson(this);

  @override
  String toString() => 'Name<$name>';
}

Date _dateFromJson(Map<String, dynamic> json) {
  return Date(
    json['name'] as String,
    date: (json['date'] as Timestamp).toDate(),
    done: json['done'] as bool,
  );
}

Map<String, dynamic> _dateToJson(Date instance) => <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
      'done': instance.done
    };
