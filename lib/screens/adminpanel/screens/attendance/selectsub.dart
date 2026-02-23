import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/checkAttendance.dart';

class Selectsub extends StatefulWidget {
  Selectsub({super.key, required this.s});
  final Timetable s;

  @override
  State<Selectsub> createState() => _SelectsubState();
}

class _SelectsubState extends State<Selectsub> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildSubjectTile({
    required String subName,
    required String subId,
    required bool attended,
    required int index,
  }) {
    final b = context.read<Basicpro>();

    return FadeTransition(
      opacity: _fade,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.95, end: 1),
        duration: Duration(milliseconds: 200 + index * 100),
        builder: (context, double value, child) {
          return Transform.scale(scale: value, child: child);
        },
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            b.setindex(index);
            b.setSub(subName, subId);
            b.lattn.clear();

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Checkattendance(id: subId, subname: subName),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  attended ? "Attended" : "Pending",
                  style: TextStyle(
                    color: attended ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final a = context.read<adminpro>();
    final pro = context.watch<Basicpro>();

    final subjects = [
      {"name": widget.s.first.subjectname, "id": widget.s.first.subjectid, "attended": pro.First},
      {"name": widget.s.second.subjectname, "id": widget.s.second.subjectid, "attended": pro.Second},
      {"name": widget.s.third.subjectname, "id": widget.s.third.subjectid, "attended": pro.Third},
      {"name": widget.s.fourth.subjectname, "id": widget.s.fourth.subjectid, "attended": pro.Fourth},
      {"name": widget.s.fifth.subjectname, "id": widget.s.fifth.subjectid, "attended": pro.Fifth},
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF4F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xff0D47A1),
        title: const Text("Select Subject"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {});
            a.subs.clear();
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final sub = subjects[index];
              return buildSubjectTile(
                subName: sub["name"] as String,
                subId: sub["id"] as String,
                attended: sub["attended"] as bool,
                index: index + 1,
              );
            },
          ),
        ),
      ),
    );
  }
}