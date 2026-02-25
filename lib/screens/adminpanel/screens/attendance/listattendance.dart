// import 'package:date_picker_plus/date_picker_plus.dart';
// import 'package:ecollege/models/timetable.dart';
// import 'package:ecollege/providers/adminpro/adminpro.dart';
// import 'package:ecollege/providers/basicpro.dart';
// import 'package:ecollege/screens/adminpanel/screens/attendance/listattnselct.dart';
// import 'package:ecollege/screens/adminpanel/screens/attendance/selctsub.dart';
// import 'package:ecollege/screens/adminpanel/screens/timetable/ttedit.dart';
// import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dentry.dart';
// import 'package:ecollege/wids/button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Listattendance extends StatefulWidget {
//   const Listattendance({super.key});

//   @override
//   State<Listattendance> createState() => _ListattendanceState();
// }

// class _ListattendanceState extends State<Listattendance> {
//   @override
//   Widget build(BuildContext context) {
//       final s=context.watch<Basicpro>();
//       final r=context.read<Basicpro>();
//          String sd="";
//     final a=context.read<adminpro>();
//     void show()async{
//       final date = await showDatePickerDialog(
//   context: context,
//   minDate: DateTime(2021, 1, 1),
//   maxDate: DateTime(2040, 12, 31),
// );
// print(date);
// s.dtnotify(date!);
// }
//     return Scaffold(
//       appBar: AppBar(title: Text("List attendance"),),
//       body: SafeArea(
//         child: Column(
//           children: [    dentry(context.read<adminpro>().classNames, "Class",
//           (d){
//             a.classget(d);
//          }),
//             dentry(a.years.map((e){return e.toString();}).toList(), 
//             "Batch",(d){
//               a.batch=int.parse(d);
//             }),
//             Padding(padding: EdgeInsetsGeometry.all(9),
//             child: Row(
//               children: [
//                 Text("Date :",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
//                 SizedBox(width: 90,),
//                 InkWell(
//                   onTap: (){
//                     show();
//                   },
//                   child: Consumer<Basicpro>(
//                     builder: (n,m,l){
                      
//                       return Container(
//                         width: 100,
//                         decoration:
//                        BoxDecoration(border: Border.all()),child: Padding(
//                          padding: const EdgeInsets.all(5.0),
//                          child: Text(m.shwdt=="99990000"?"salect date":m.shwdt.toString()),
//                        ));
//                     },
//                      ))
//               ],
//             ),
//             ),
          
           
//            SizedBox(height: 120,),

//             Center(child: buttonst(padding: 0, width: 130, 
//             clr: Colors.grey.shade400, txtclr:Colors.black, 
//             txt: "Next", onPressed: ()
//             async{
       
//    context.read<adminpro>().addtttolocal();
//       late Timetable tt;
//       int t=a.getTTedit(context);
//       print(t);
//       if(t==1){
        
//         tt=a.te;
//       }else{
//         // print(a.box.length);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error")));
//       }
 

// print(tt.batch);
//       context.read<Basicpro>().getstd(a.classn,a.batch.toString());
   
//         Future.delayed(Duration(milliseconds: 1000)).then((a){
//         Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Listattnselct(s: tt,)));
//         });
//             }),)  ],),
//       ),
//     );
//   }
// }
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/listattnselct.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/selctsub.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/ttedit.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dentry.dart';
import 'package:ecollege/wids/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Listattendance extends StatefulWidget {
  const Listattendance({super.key});

  @override
  State<Listattendance> createState() => _ListattendanceState();
}

class _ListattendanceState extends State<Listattendance> {
  @override
  Widget build(BuildContext context) {
    final s = context.watch<Basicpro>();
    final r = context.read<Basicpro>();
    final a = context.read<adminpro>();

    void show() async {
      final date = await showDatePickerDialog(
        context: context,
        minDate: DateTime(2021, 1, 1),
        maxDate: DateTime(2040, 12, 31),
      );
      print(date);
      s.dtnotify(date!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("List attendance"),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            double contentWidth = constraints.maxWidth;

            if (constraints.maxWidth > 1200) {
              contentWidth = 600;
            } else if (constraints.maxWidth > 900) {
              contentWidth = 500;
            } else if (constraints.maxWidth > 600) {
              contentWidth = 450;
            } else {
              contentWidth = constraints.maxWidth;
            }

            return Center(
              child: Container(
                width: contentWidth,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [

                    dentry(
                      context.read<adminpro>().classNames,
                      "Class",
                      (d) {
                        a.classget(d);
                      },
                    ),

                    dentry(
                      a.years.map((e) => e.toString()).toList(),
                      "Batch",
                      (d) {
                        a.batch = int.parse(d);
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Row(
                        children: [
                          const Text(
                            "Date :",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              show();
                            },
                            child: Consumer<Basicpro>(
                              builder: (n, m, l) {
                                return Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      m.shwdt == "99990000"
                                          ? "select date"
                                          : m.shwdt.toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 120),

                    Center(
                      child: buttonst(
                        padding: 0,
                        width: 130,
                        clr: Colors.grey.shade400,
                        txtclr: Colors.black,
                        txt: "Next",
                        onPressed: () async {

                          context.read<adminpro>().addtttolocal();

                          late Timetable tt;
                          int t = a.getTTedit(context);
                          print(t);

                          if (t == 1) {
                            tt = a.te;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("error")),
                            );
                            return;
                          }

                          print(tt.batch);

                          context
                              .read<Basicpro>()
                              .getstd(a.classn, a.batch.toString());

                          Future.delayed(
                            const Duration(milliseconds: 1000),
                          ).then((a) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    Listattnselct(s: tt),
                              ),
                            );
                          });
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