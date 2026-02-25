
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:ecollege/providers/adminpro/adminpro.dart';
// import 'package:ecollege/providers/basicpro.dart';
// import 'package:ecollege/screens/adminpanel/screens/attendance/selectsub.dart';
// import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dentry.dart';
// import 'package:ecollege/wids/button.dart';
// import 'package:ecollege/models/timetable.dart';

// class Attendancescrn extends StatefulWidget {
//   const Attendancescrn({super.key});

//   @override
//   State<Attendancescrn> createState() => _AttendancescrnState();
// }

// class _AttendancescrnState extends State<Attendancescrn>
//     with SingleTickerProviderStateMixin {

//   late AnimationController _controller;
//   late Animation<double> _fade;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );

//     _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final adminPro = context.read<adminpro>();
//     final basicPro = context.read<Basicpro>();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor:Colors.white,
//         title: const Text(
//           "Student Attendance",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: FadeTransition(
//         opacity: _fade,
//         child: Padding(
//           padding: const EdgeInsets.all(0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [

//                SizedBox(height: 20),

//               dentry(adminPro.classNames, "Class", (selectedClass) {
//                 adminPro.classget(selectedClass);
//                 setState(() {});
//               }),

//               const SizedBox(height: 20),

//               // Batch Dropdown
//               dentry(adminPro.years.map((e) => e.toString()).toList(), 
//                 "Batch", (selectedBatch) {
//                   adminPro.batch = int.parse(selectedBatch);
//                   setState(() {});
//               }),

//               const SizedBox(height: 50),

//               // Next Button
//               Center(
//                 child: buttonst(
//                   padding: 0,
//                   width: 150,
//                   clr:  Colors.grey,
//                   txtclr: Colors.black,
//                   txt: "Next",
//                   onPressed: () async {
//                     adminPro.addtttolocal();

//                     late Timetable tt;
//                     int t = adminPro.getTimetable();

//                     if (t == 1) {
//                       tt = adminPro.tt;
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text("today is holiday"),
//                           duration: Duration(seconds: 2),
//                         ),
//                       );
//                       return;
//                     }

//                     basicPro.geAttendance(context);
//                     basicPro.getstd(adminPro.classn, adminPro.batch.toString());

//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (ctx) => Selectsub(s: tt),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/selectsub.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dentry.dart';
import 'package:ecollege/wids/button.dart';
import 'package:ecollege/models/timetable.dart';

class Attendancescrn extends StatefulWidget {
  const Attendancescrn({super.key});

  @override
  State<Attendancescrn> createState() => _AttendancescrnState();
}

class _AttendancescrnState extends State<Attendancescrn>
    with SingleTickerProviderStateMixin {

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

  @override
  Widget build(BuildContext context) {
    final adminPro = context.read<adminpro>();
    final basicPro = context.read<Basicpro>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Student Attendance",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: FadeTransition(
        opacity: _fade,
        child: LayoutBuilder(
          builder: (context, constraints) {

            double contentWidth = constraints.maxWidth;

            if (constraints.maxWidth > 1200) {
              contentWidth = 600; // Large desktop
            } else if (constraints.maxWidth > 900) {
              contentWidth = 500; // Desktop
            } else if (constraints.maxWidth > 600) {
              contentWidth = 450; // Tablet
            } else {
              contentWidth = constraints.maxWidth; // Mobile
            }

            return Center(
              child: Container(
                width: contentWidth,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    const SizedBox(height: 20),

                    dentry(adminPro.classNames, "Class", (selectedClass) {
                      adminPro.classget(selectedClass);
                      setState(() {});
                    }),

                    const SizedBox(height: 20),

                    dentry(
                      adminPro.years.map((e) => e.toString()).toList(),
                      "Batch",
                      (selectedBatch) {
                        adminPro.batch = int.parse(selectedBatch);
                        setState(() {});
                      },
                    ),

                    const SizedBox(height: 50),

                    Center(
                      child: buttonst(
                        padding: 0,
                        width: 150,
                        clr: Colors.grey,
                        txtclr: Colors.black,
                        txt: "Next",
                        onPressed: () async {
                          adminPro.addtttolocal();

                          late Timetable tt;
                          int t = adminPro.getTimetable();

                          if (t == 1) {
                            tt = adminPro.tt;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("today is holiday"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            return;
                          }

                          basicPro.geAttendance(context);
                          basicPro.getstd(
                              adminPro.classn, adminPro.batch.toString());

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => Selectsub(s: tt),
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}