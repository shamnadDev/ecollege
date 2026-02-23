import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/selctsub.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/ttedit.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dentry.dart';
import 'package:ecollege/wids/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Attendanceedit extends StatefulWidget {
  const Attendanceedit({super.key});

  @override
  State<Attendanceedit> createState() => _AttendanceeditState();
}

class _AttendanceeditState extends State<Attendanceedit> {
  @override
  Widget build(BuildContext context) {
      final s=context.watch<Basicpro>();
      final r=context.read<Basicpro>();
         String sd="";
    final a=context.read<adminpro>();
    void show()async{
      final date = await showDatePickerDialog(
  context: context,
  minDate: DateTime(2021, 1, 1),
  maxDate: DateTime(2040, 12, 31),
);
print(date);
s.dtnotify(date!);
}
    return Scaffold(
      appBar: AppBar(title: Text("edit attendance"),),
      body: SafeArea(
        child: Column(
          children: [    dentry(context.read<adminpro>().classNames, "Class",
          (d){
            a.classget(d);
         }),
            dentry(a.years.map((e){return e.toString();}).toList(), 
            "Batch",(d){
              a.batch=int.parse(d);
            }),
            Padding(padding: EdgeInsetsGeometry.all(9),
            child: Row(
              children: [
                Text("Date :",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                SizedBox(width: 90,),
                InkWell(
                  onTap: (){
                    show();
                  },
                  child: Consumer<Basicpro>(
                    builder: (n,m,l){
                      
                      return Container(
                        width: 100,
                        decoration:
                       BoxDecoration(border: Border.all()),child: Padding(
                         padding: const EdgeInsets.all(5.0),
                         child: Text(m.shwdt=="99990000"?"salect date":m.shwdt.toString()),
                       ));
                    },
                     ))
              ],
            ),
            ),
            Padding(padding: EdgeInsets.all(10),child:   TextFormField(controller:r.regid ,decoration:
             InputDecoration(label: Text("Register Number"),border: OutlineInputBorder())
            ,)
           ,),
           SizedBox(height: 120,),

            Center(child: buttonst(padding: 0, width: 130, 
            clr: Colors.grey.shade400, txtclr:Colors.black, 
            txt: "Next", onPressed: ()
            async{
       
   context.read<adminpro>().addtttolocal();
      late Timetable tt;
      int t=a.getTTedit(context);
      print(t);
      if(t==1){
        
        tt=a.te;
      }else{
        // print(a.box.length);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error")));
      }
 

print(tt.batch);
      context.read<Basicpro>().getstd(a.classn,a.batch.toString());
   
        Future.delayed(Duration(milliseconds: 1000)).then((a){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Selctsub(s: tt,)));
        });
            }),)  ],),
      ),
    );
  }
}