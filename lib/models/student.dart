import 'package:hive/hive.dart';

part 'student.g.dart'; // Required for Hive code generation

@HiveType(typeId: 2)
class Student extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String rollNo;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String? password;

  @HiveField(5)
  final String? phone;

  @HiveField(6)
  final String? batch; // ✅ Added batch

  @HiveField(7)
  final String? className; // ✅ Added className (use this name instead of “class”)

  Student({
    this.id,
    required this.name,
    required this.rollNo,
    required this.email,
    this.password,
    this.phone,
    this.batch,
    this.className,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rollNo': rollNo,
      'email': email,
      'password': password,
      'phone': phone,
      'batch': batch,
      'className': className,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      rollNo: json['rollNo'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      batch: json['batch'],
      className: json['className'],
    );
  }
}
