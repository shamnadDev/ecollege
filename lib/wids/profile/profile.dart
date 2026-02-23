import 'package:flutter/material.dart';





class ProfileScreen extends StatelessWidget {
  final String name;
  final String rollNo;
  final String batch;
  final String regNo;
  final double attendancePercentage;
  final String email;
  final String className;

  ProfileScreen({
    required this.name,
    required this.rollNo,
    required this.batch,
    required this.regNo,
    required this.attendancePercentage,
    required this.email,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile Card
              Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Name Field
                      buildProfileField('Name', name),
                      buildProfileField('Roll No', rollNo),
                      buildProfileField('Batch', batch),
                      buildProfileField('Reg No', regNo),
                      buildProfileField('Attendance Percentage', '$attendancePercentage%'),
                      buildProfileField('Email', email),
                      buildProfileField('Class', className),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to create profile field rows
  Widget buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
