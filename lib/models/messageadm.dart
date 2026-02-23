import 'package:hive/hive.dart';

part 'messageadm.g.dart'; // Generated file for Hive TypeAdapter

@HiveType(typeId: 7)
class Messageadm extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  DateTime date;

  Messageadm({required this.text, required this.date});

  /// Convert Message object to Map (for JSON)
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'date': date.toIso8601String(), // DateTime stored as ISO string in JSON
    };
  }

  /// Create Message object from Map (JSON)
  factory Messageadm.fromJson(Map<String, dynamic> json) {
    return Messageadm(
      text: json['text'],
      date: DateTime.parse(json['date']),
    );
  }
}
