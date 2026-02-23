import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/ttedit.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dentry.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dropentry.dart';
import 'package:ecollege/wids/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Timetablescrn extends StatefulWidget {
  const Timetablescrn({super.key});

  @override
  State<Timetablescrn> createState() => _TimetablescrnState();
}

class _TimetablescrnState extends State<Timetablescrn> {
  final formKey = GlobalKey<FormState>();
   
  @override
  Widget build(BuildContext context) {
    
     final s=context.read<Basicpro>();
    final a=context.read<adminpro>();
    return Scaffold(
      appBar: AppBar(title: Text("Add timetable"),),
      body: SafeArea(child: Form(
key: formKey,
      child: Column(children: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: SegmentedButton(
          onSelectionChanged: (ab) {
           a.setset(ab);
          },
          segments: [
          
          ButtonSegment(value: "Monday",label: Text("Mon")),
          ButtonSegment(value: "Tuesday",label: Text("Tue")),
          ButtonSegment(value: "Wednesday",label: Text("Wed")),
          ButtonSegment(value: "Thursday",label: Text("Thu")),
          ButtonSegment(value: "Friday",label: Text("Fri"))],
           selected:context.watch<adminpro>().s),
      ),
     dentry(context.read<adminpro>().classNames, "Class",(d){
      a.classget(d);}),
    dentry(a.years.map((e){return e.toString();}).toList(), "Batch",(d){a.batch=int.parse(d);
    print(a.batch.toString());
    })
   ,  dropentry(context.watch<Basicpro>().s, "1st hour",(d){a.first=d;})
     , dropentry(context.watch<Basicpro>().s, "2nd hour",(d){a.second=d;})
     , dropentry(context.watch<Basicpro>().s, "3rd hour",(d){a.third=d;})
     , dropentry(context.watch<Basicpro>().s, "4th hour",(d){a.fourth=d;})
     ,
      dropentry(context.watch<Basicpro>().s, "5th hour",(d){a.fifth=d;})
     
     ,SizedBox(height:  23,),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        buttonst(padding: 0, width: 100, clr:
         Colors.grey.shade400,
         txtclr: Colors.black, txt: 'Submit', onPressed: () async{ a.submitTt();
         a.addtttolocal();
          },)],)
      
      ],),
    )),);
  }
}