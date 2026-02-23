import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/checkAttendance.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/edit.dart';
import 'package:ecollege/wids/listtile/listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Selctsub extends StatefulWidget {
   Selctsub({super.key,required this.s});
Timetable s;
  @override
  State<Selctsub> createState() => _SelctsubState();
}

class _SelctsubState extends State<Selctsub> {
  @override
  Widget build(BuildContext context) {
    
    final a=context.read<adminpro>();    
    final b=context.read<Basicpro>();
    
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: (){
          setState(() {
              
            });
            context.read<adminpro>().subs.clear();
            //a.getTTlocal();
            
            
        Navigator.pop(context);
        
        },)
        ,title: Text("Select subject"),),
      body: SafeArea(
      
      child: Column(children: [
     InkWell(onTap: () {b.lattn.clear();
      b.setindex(1);
     
      context.read<Basicpro>().modifyattn(widget.s.first.subjectid);
      
     
     Navigator.of(context).
     push(MaterialPageRoute(builder: (context)=>
     Edit(studentName: context.read<Basicpro>().regid.text.toString(),subid: widget.s.first.subjectid, subname: widget.s.first.subjectname)));
     }, child: ListTile(title: Text(widget.s.first.subjectname),)),
     InkWell(onTap: ()async{
      b.lattn.clear(); 
     b.setindex(2);
    context.read<Basicpro>().modifyattn(widget.s.second.subjectid);
     
               
       Navigator.of(context).
     push(MaterialPageRoute(builder: (context)=>
     Edit(studentName: context.read<Basicpro>().regid.text.toString(),subid: widget.s.second.subjectid, subname: widget.s.second.subjectname)));
     }, child: ListTile(title: Text(widget.s.second.subjectname),)),
     InkWell(onTap: (){ 
       b.lattn.clear();
           b.setindex(3);
           
            context.read<Basicpro>().modifyattn(widget.s.third.subjectid);
Future.delayed(Duration(seconds: 1)).then((a){  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
     Edit(studentName: context.read<Basicpro>().regid.text.toString(),subid: widget.s.third.subjectid,
      subname: widget.s.third.subjectname)));});

         
    }, child: ListTile(title: Text(widget.s.third.subjectname),)),
     InkWell(onTap: (){  b.lattn.clear();
     b.setindex(4); 
      context.read<Basicpro>().modifyattn(widget.s.fourth.subjectid);
      
           
         Navigator.of(context).
     push(MaterialPageRoute(builder: (context)=>
     Edit(studentName: context.read<Basicpro>().regid.text.toString(),subid: widget.s.fourth.subjectid, subname: widget.s.fourth.subjectname)));}, child: ListTile(title: Text(widget.s.fourth.subjectname),)),
     InkWell(onTap: (){ b.lattn.clear();  
      b.setindex(5);
      context.read<Basicpro>().modifyattn(widget.s.fifth.subjectid); 
  
            
          Navigator.of(context).
     push(MaterialPageRoute(builder: (context)=>
     Edit(studentName: context.read<Basicpro>().regid.text.toString(),subid: widget.s.fifth.subjectid, subname: widget.s.fifth.subjectname)));}, child: ListTile(title: Text(widget.s.fifth.subjectname),)),
      


    ],)),);
  }
}