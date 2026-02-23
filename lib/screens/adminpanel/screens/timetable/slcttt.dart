import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/selectsub.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/ttedit.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dentry.dart';
import 'package:ecollege/wids/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slcttt extends StatefulWidget {
  const Slcttt({super.key});

  @override
  State<Slcttt> createState() => _SlctttState();
}

class _SlctttState extends State<Slcttt> {
  @override
  Widget build(BuildContext context) {
         final s=context.read<Basicpro>();
         String sd="";
    final a=context.read<adminpro>();
    return Scaffold(
      appBar: AppBar(title: Text("Edit timetable"),),
body: Column(
  children: [    dentry(context.read<adminpro>().classNames, "Class",
  (d){
    print(d.toString());
   a.ttclass=d.toString();
 }),
    dentry(a.years.map((e){return e.toString();}).toList(), 
    "Batch",(d){a.ttbatch=int.parse(d);
    print(a.ttbatch.toString());
    }),SizedBox(height: 100,),
    Center(child: buttonst(padding: 0, width: 130, 
    clr:Colors.grey.shade400, txtclr:Colors.black, 
    txt: "Next", onPressed: ()
    async{
      
   context.read<adminpro>().addtttolocal();
      late Timetable tt;
     a.addtttolocal();
     a.getttedit("Monday");
Future.delayed(Duration(milliseconds: 1000)).then((a){
Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Ttedit()));
});
    }),)
    ],
    ));
  }
}