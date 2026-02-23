import 'package:hive/hive.dart';

part 'subject.g.dart';

@HiveType(typeId: 0)
class Subject extends HiveObject {
  @HiveField(0)
  String subjectid;

  @HiveField(1)
  String subjectname;

  Subject({
    required this.subjectid,
    required this.subjectname,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectid: json['subjectid'] as String,
      subjectname: json['subjectname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectid': subjectid,
      'subjectname': subjectname,
    };
  }
}
