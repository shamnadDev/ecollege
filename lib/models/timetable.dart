
import 'package:ecollege/models/subject.dart';
import 'package:hive/hive.dart';
part 'timetable.g.dart';

@HiveType(typeId: 1)
class Timetable extends HiveObject {
  @HiveField(0)
  String day;

  @HiveField(1)
  String classid;

  @HiveField(2)
  int batch;

  @HiveField(3)
  Subject first;

  @HiveField(4)
  Subject second;

  @HiveField(5)
  Subject third;

  @HiveField(6)
  Subject fourth;

  @HiveField(7)
  Subject fifth;

  Timetable({
    required this.batch,
    required this.classid,
    required this.day,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
  });

  /// From JSON
  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      batch: json['batch'],
      classid: json['classid'],
      day: json['day'],
      first: Subject.fromJson(json['first']),
      second: Subject.fromJson(json['second']),
      third: Subject.fromJson(json['third']),
      fourth: Subject.fromJson(json['fourth']),
      fifth: Subject.fromJson(json['fifth']),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'batch': batch,
      'classid': classid,
      'day': day,
      'first': first.toJson(),
      'second': second.toJson(),
      'third': third.toJson(),
      'fourth': fourth.toJson(),
      'fifth': fifth.toJson(),
    };
  }
}
