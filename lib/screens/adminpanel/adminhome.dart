
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:provider/provider.dart';
// import 'package:ecollege/providers/basicpro.dart';
// import 'package:ecollege/providers/adminpro/adminpro.dart';
// import 'package:ecollege/screens/login/loginscrn.dart';
// import 'package:ecollege/screens/adminpanel/screens/attendance/attendancescrn.dart';
// import 'package:ecollege/screens/adminpanel/screens/attendance/listattendance.dart';
// import 'package:ecollege/screens/adminpanel/screens/attendance/attendanceEdit.dart';
// import 'package:ecollege/screens/adminpanel/screens/addsub.dart';
// import 'package:ecollege/screens/adminpanel/screens/adminmsg.dart';
// import 'package:ecollege/screens/adminpanel/screens/timetable/slcttt.dart';
// import 'package:ecollege/screens/adminpanel/screens/timetable/timetablescrn.dart';
// import 'package:ecollege/screens/msglst.dart';

// class adminhome extends StatefulWidget {
//   const adminhome({super.key});

//   @override
//   State<adminhome> createState() => _AdminHomeState();
// }

// class _AdminHomeState extends State<adminhome>
//     with SingleTickerProviderStateMixin {

//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();

//     final scut = context.read<Basicpro>();
//     final sc = context.read<adminpro>();

//     scut.getStdfrmcld();
//     sc.addtttolocal();
//     scut.addtohive();
//     scut.getlocalysub();
//     scut.getStudentDetails();

//     _controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 600));

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Widget buildCard(
//       {required IconData icon,
//       required String title,
//       required VoidCallback onTap,
//       required int index}) {

//     return FadeTransition(
//       opacity: CurvedAnimation(
//           parent: _controller,
//           curve: Interval(index * 0.1, 1.0, curve: Curves.easeIn)),
//       child: TweenAnimationBuilder(
//         duration: const Duration(milliseconds: 300),
//         tween: Tween<double>(begin: 0.95, end: 1),
//         builder: (context, double value, child) {
//           return Transform.scale(scale: value, child: child);
//         },
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12),
//           onTap: onTap,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.shade300,
//                   blurRadius: 6,
//                   offset: const Offset(0, 4),
//                 )
//               ],
//             ),
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, size: 36, color: const Color(0xff0D47A1)),
//                 const SizedBox(height: 10),
//                 Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF4F6F9),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: const Color(0xff0D47A1),
//         title: const Text(
//           "Admin Dashboard",
//           style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
//         ),
//         actions: [
//        IconButton(
//   icon: const Icon(Icons.logout, color: Colors.white),
//   onPressed: () {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           title: Row(
//             children: const [
//               Icon(Icons.logout, color: Color(0xff0D47A1)),
//               SizedBox(width: 8),
//               Text("Confirm Logout"),
//             ],
//           ),
//           content: const Text(
//             "Are you sure you want to logout from the admin panel?",
//             style: TextStyle(fontSize: 14),
//           ),
//           actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); 
//               },
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff0D47A1),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.pop(context); 
//                 context.read<Basicpro>().signout();
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (_) => LoginScreen()),
//                 );
//               },
//               child: const Text("Logout",style: TextStyle(color: Colors.white),),
//             ),
//           ],
//         );
//       },
//     );
//   },
// )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 18,
//           mainAxisSpacing: 18,
//           children: [

//             buildCard(
//                 icon: Ionicons.checkbox_outline,
//                 title: "Student Attendance",
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => Attendancescrn())),
//                 index: 0),

//             buildCard(
//                 icon: Ionicons.receipt_outline,
//                 title: "Attendance Record",
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => Listattendance())),
//                 index: 1),

//             buildCard(
//                 icon: Icons.library_books_outlined,
//                 title: "Add Subject",
//                 onTap: () =>
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => AddSub())),
//                 index: 2),

//             buildCard(
//                 icon: Ionicons.calendar_outline,
//                 title: "Add Timetable",
//                 onTap: () =>
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => Timetablescrn())),
//                 index: 3),

//             buildCard(
//                 icon: Icons.message_outlined,
//                 title: "Message To College",
//                 onTap: () =>
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => Adminmsg())),
//                 index: 4),

//             buildCard(
//                 icon: Icons.report_gmailerrorred_outlined,
//                 title: "Student Reports",
//                 onTap: () =>
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => MsgListScreen())),
//                 index: 5),

//             buildCard(
//                 icon: Icons.edit_calendar_outlined,
//                 title: "Edit Timetable",
//                 onTap: () =>
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => Slcttt())),
//                 index: 6),

//             buildCard(
//                 icon: Icons.edit_outlined,
//                 title: "Edit Attendance",
//                 onTap: () =>
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => Attendanceedit())),
//                 index: 7),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/screens/login/loginscrn.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/attendancescrn.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/listattendance.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/attendanceEdit.dart';
import 'package:ecollege/screens/adminpanel/screens/addsub.dart';
import 'package:ecollege/screens/adminpanel/screens/adminmsg.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/slcttt.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/timetablescrn.dart';
import 'package:ecollege/screens/msglst.dart';

class adminhome extends StatefulWidget {
  const adminhome({super.key});

  @override
  State<adminhome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<adminhome>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    final scut = context.read<Basicpro>();
    final sc = context.read<adminpro>();

    scut.getStdfrmcld();
    sc.addtttolocal();
    scut.addtohive();
    scut.getlocalysub();
    scut.getStudentDetails();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildCard(
      {required IconData icon,
      required String title,
      required VoidCallback onTap,
      required int index}) {

    return FadeTransition(
      opacity: CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.1, 1.0, curve: Curves.easeIn)),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(begin: 0.95, end: 1),
        builder: (context, double value, child) {
          return Transform.scale(scale: value, child: child);
        },
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 36, color: const Color(0xff0D47A1)),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff0D47A1),
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Row(
                      children: const [
                        Icon(Icons.logout, color: Color(0xff0D47A1)),
                        SizedBox(width: 8),
                        Text("Confirm Logout"),
                      ],
                    ),
                    content: const Text(
                      "Are you sure you want to logout from the admin panel?",
                      style: TextStyle(fontSize: 14),
                    ),
                    actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0D47A1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<Basicpro>().signout();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: LayoutBuilder(
              builder: (context, constraints) {

                int crossAxisCount = 2;

                if (constraints.maxWidth > 1200) {
                  crossAxisCount = 5; // Large desktop
                } else if (constraints.maxWidth > 900) {
                  crossAxisCount = 4; // Desktop
                } else if (constraints.maxWidth > 600) {
                  crossAxisCount = 3; // Tablet
                } else {
                  crossAxisCount = 2; // Mobile
                }

                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 1.1,
                  children: [

                    buildCard(
                        icon: Ionicons.checkbox_outline,
                        title: "Student Attendance",
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Attendancescrn())),
                        index: 0),

                    buildCard(
                        icon: Ionicons.receipt_outline,
                        title: "Attendance Record",
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Listattendance())),
                        index: 1),

                    buildCard(
                        icon: Icons.library_books_outlined,
                        title: "Add Subject",
                        onTap: () =>
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => AddSub())),
                        index: 2),

                    buildCard(
                        icon: Ionicons.calendar_outline,
                        title: "Add Timetable",
                        onTap: () =>
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Timetablescrn())),
                        index: 3),

                    buildCard(
                        icon: Icons.message_outlined,
                        title: "Message To College",
                        onTap: () =>
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Adminmsg())),
                        index: 4),

                    buildCard(
                        icon: Icons.report_gmailerrorred_outlined,
                        title: "Student Reports",
                        onTap: () =>
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => MsgListScreen())),
                        index: 5),

                    buildCard(
                        icon: Icons.edit_calendar_outlined,
                        title: "Edit Timetable",
                        onTap: () =>
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Slcttt())),
                        index: 6),

                    buildCard(
                        icon: Icons.edit_outlined,
                        title: "Edit Attendance",
                        onTap: () =>
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Attendanceedit())),
                        index: 7),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}