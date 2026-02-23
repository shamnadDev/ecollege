
class Attendance   {

  final String id;

  final String name;

  String status;

  String subjectname;

  DateTime date;

  String subjectid;

  String dateformatted;

  int index;

  int batch;


  String className;

  Attendance({
    required this.id,
    required this.name,
    required this.status,
    required this.subjectname,
    required this.subjectid,
    required this.date,
    required this.dateformatted,
    required this.index,
    required this.batch,
    required this.className,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      subjectname: json['subjectname'] as String,
      subjectid: json['subjectid'] as String,
      date: DateTime.parse(json['date']),
      dateformatted: json['dateformatted'] as String,
      index: json['index'] as int,
      batch: json['batch'] as int,
      className: json['className'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'subjectname': subjectname,
      'subjectid': subjectid,
      'date': date.toIso8601String(),
      'dateformatted': dateformatted,
      'index': index,
      'batch': batch,
      'className': className,
    };
  }
}