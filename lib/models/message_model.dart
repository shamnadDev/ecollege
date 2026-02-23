import 'package:hive/hive.dart';

part 'message_model.g.dart';

@HiveType(typeId: 5)
class MessageModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String text;

  @HiveField(2)
  DateTime timestamp;

  MessageModel({
    required this.id,
    required this.text,
    required this.timestamp,
  });

  // Convert Object → JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "text": text,
      "timestamp": timestamp.toIso8601String(),
    };
  }

  // Convert JSON → Object
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json["id"],
      text: json["text"],
      timestamp: DateTime.parse(json["timestamp"]),
    );
  }
}
