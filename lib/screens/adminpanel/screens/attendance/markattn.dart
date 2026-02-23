import 'package:ecollege/screens/adminpanel/screens/attendance/wids/attntile.dart';
import 'package:flutter/material.dart';

class Markattn extends StatefulWidget {
  const Markattn({super.key});

  @override
  State<Markattn> createState() => _MarkattnState();
}

class _MarkattnState extends State<Markattn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Column(children: [AttendanceTile(name: "name", detail: "detail")],),

    );
  }
}