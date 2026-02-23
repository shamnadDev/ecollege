import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/wids/attntile.dart';
import 'package:ecollege/wids/button.dart';
import 'package:ecollege/wids/listtile/listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkattendance extends StatefulWidget {
   Checkattendance({super.key,required this.id,required this.subname});
String id;
String subname;
  @override
  State<Checkattendance> createState() => _CheckattendanceState();
}

class _CheckattendanceState extends State<Checkattendance> {
  @override
  Widget build(BuildContext context) {
   final scut=context.read<Basicpro>();
 
    return Scaffold(
      appBar: AppBar(title: Text(widget.id),),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: context.watch<Basicpro>().std.map((a){

           return AttendanceTile(name: a.name, detail: a.rollNo);}).toList(),),
          ),
       Stack(children: [Material(elevation: 50,child: 
       Container(height: 50,width: double.maxFinite,
       child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
        buttonst(padding: 1, width: 100,
         clr: Colors.deepPurple, txtclr: Colors.white, 
         txt: "Submit", onPressed: (){
   
          // sendsub();
          // scut.addAttendance();
          print(scut.lattn.length);
         scut.totaldateinjection(context);
          Future.delayed(Duration(seconds: 1)).then((a)async{
            scut.addattntoHF(context);
            scut.geAttendance(context);
          });
          scut.calculatePercentage();
          scut.status="";
         })],),
       decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(31)),
        color: Colors.grey.shade400),))],)
       
        ],
      ),
    );
  }
}