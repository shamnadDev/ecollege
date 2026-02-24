import 'package:ecollege/models/attendance.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {


  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Basicpro>().getAttendanceStd();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Attendance"),
      //   centerTitle: true,
      //   backgroundColor: Colors.deepPurple,
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.deepPurple],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Consumer<Basicpro>(
          builder: (context, value, child) =>  ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: value.stdattn.length,
            itemBuilder: (context, index) {
              final attendance = value.stdattn[index];
          
              // Color code based on status
              Color statusColor;
              if (attendance.status.toLowerCase() == "present") {
                statusColor = Colors.green;
              } else if (attendance.status.toLowerCase() == "absent") {
                statusColor = Colors.red;
              } else {
                statusColor = Colors.orange;
              }
          String getint(){
            int index=attendance.index;
if(index==1){
return "${index}st period";
}else if(index==2){
  return "${index}nd period";
}else if(index==3){
  return "${index}rd period";
}else{
  return "${index}th period";
}

          }
              // Animated slide-in effect
              return TweenAnimationBuilder<Offset>(
                tween: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero),
                duration: Duration(milliseconds: 300 + index * 50),
                curve: Curves.easeOut,
                builder: (context, offset, child) => Transform.translate(
                  offset: Offset(offset.dx * 200, 0),
                  child: Opacity(
                    opacity: 1 - offset.dx.abs(),
                    child: child,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple.shade700, Colors.deepPurpleAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              attendance.subjectname,
                              style: const TextStyle(color: Colors.white,
                               fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                             getint().toString(),
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              attendance.status,
                              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('dd MMM yyyy').format(attendance.date),
                              style: const TextStyle(color: Colors.white60, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}