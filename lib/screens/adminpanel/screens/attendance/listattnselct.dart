import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/checkAttendance.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/edit.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/wids/listattn.dart';
import 'package:ecollege/wids/listtile/listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Listattnselct extends StatefulWidget {
   Listattnselct({super.key,required this.s});
Timetable s;
  @override
  State<Listattnselct> createState() => _ListattnselctState();
}

class _ListattnselctState extends State<Listattnselct> {

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
     InkWell(onTap: () {
    b.setindex(1);
      b.listAttn(context,widget.s.first.subjectid);
     
     Future.delayed(Duration(milliseconds: 800)).then((onValue)=> Navigator.of(context).
     push(MaterialPageRoute(builder: (context)=>
  
  Listattn(sub: widget.s.first.subjectname,))));
    
     }, child: ListTile(title: Text(widget.s.first.subjectname),)),
     InkWell(onTap: ()async{
       b.setindex(2);
       b.listAttn(context,widget.s.second.subjectid);
     
     Future.delayed(Duration(milliseconds: 800)).then((onValue)=> Navigator.of(context).
     push(MaterialPageRoute(builder: (context)=>
  
  Listattn(sub: widget.s.second.subjectname,))));
    
     }, child: ListTile(title: Text(widget.s.second.subjectname),)),
     InkWell(onTap: (){    b.setindex(3);
b.listAttn(context,widget.s.third.subjectid);
     
     Future.delayed(Duration(milliseconds: 800)).then((onValue)=> Navigator.of(context).
     push(MaterialPageRoute(builder: (context)=>
  
  Listattn(sub: widget.s.third.subjectname,))));
    
         
    }, child: ListTile(title: Text(widget.s.third.subjectname),)),
     InkWell(onTap: (){      b.setindex(4);
       b.listAttn(context,widget.s.fourth.subjectid);
     
     Future.delayed(Duration(milliseconds: 800)).then((onValue)=> Navigator.of(context).
     push(MaterialPageRoute(builder: (context)=>
  
  Listattn(sub: widget.s.fourth.subjectname,))));
    }, child: ListTile(title: Text(widget.s.fourth.subjectname),)),
     InkWell(onTap: (){    b.setindex(5);
      b.listAttn(context,widget.s.fifth.subjectid);
     
     Future.delayed(Duration(milliseconds: 800)).then((onValue)=> Navigator.of(context).
     push(MaterialPageRoute(builder: (context)=>
  
  Listattn(sub: widget.s.fifth.subjectname,))));
    }, child: ListTile(title: Text(widget.s.fifth.subjectname),)),
      


    ],)),);
  }
}