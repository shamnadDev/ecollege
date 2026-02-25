import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dentry.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dropentry.dart';
import 'package:ecollege/wids/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ttedit extends StatefulWidget {
  const Ttedit({super.key});

  @override
  State<Ttedit> createState() => _TteditState();
}

class _TteditState extends State<Ttedit> {
  final formKey = GlobalKey<FormState>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();

 context.read<Basicpro>().getlocalysub();
 
  }   
  @override
  Widget build(BuildContext context) {
    
     final s=context.read<Basicpro>();
    final a=context.read<adminpro>();

// final sa=a.tte;
    return Scaffold(
      appBar: AppBar(title: Text("Add timetable"),),
      body: SafeArea(child: Form(
key: formKey,
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.all(Radius.circular(12))),
            child: ValueListenableBuilder<Timetable?>(
                valueListenable: context.read<adminpro>().tte,
                builder: (a,value,d)=> ListView(
                  children: [
                   ListTile(
                      title:Text("1. ${value?.first.subjectname??""}") ,
                    ),   ListTile(
                      title:Text("2. ${value?.second.subjectname??""}") ,
                    ),   ListTile(
                      title:Text("3. ${value?.third.subjectname??""}") ,
                    ),   ListTile(
                      title:Text("4. ${value?.fourth.subjectname??""}") ,
                    ),   ListTile(
                      title:Text("5. ${value?.fifth.subjectname??""}") ,
                    ),
                  ],
                ),
              ),
            
          ),
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: SegmentedButton(
           
            onSelectionChanged: (ab) {
        
             a.setset(ab);
             print("changed");
          
                a.getttedit( ab.single);
           
            },
            segments: [
            
            ButtonSegment(value: "Monday",label: Text("Mon")),
            ButtonSegment(value: "Tuesday",label: Text("Tue")),
            ButtonSegment(value: "Wednesday",label: Text("Wed")),
            ButtonSegment(value: "Thursday",label: Text("Thu")),
            ButtonSegment(value: "Friday",label: Text("Fri"))],
             selected:context.watch<adminpro>().s),
        )
           ,  dropentry(context.watch<Basicpro>().s, "1st hour",(d){
            
            a.efirst=d;
            
            },
            )
             , dropentry(context.watch<Basicpro>().s, "2nd hour",(d){
        
           a.esec=d;
        })
             , dropentry(context.watch<Basicpro>().s, "3rd hour",(d){a.ethird=d;})
             , dropentry(context.watch<Basicpro>().s, "4th hour",(d){a.efourth=d;})
             ,
        dropentry(context.watch<Basicpro>().s, "5th hour",(d){a.efifth=d;})
             
             ,SizedBox(height:  23,),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          buttonst(padding: 0, width: 100, clr: Colors.grey.shade400,
           txtclr: Colors.black, txt: 'Submit', onPressed: () async{
              a.edittt(context);
            //  a.addtttolocal();
            Future.delayed(Duration(milliseconds: 400));
           
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));
            },)],)
        
        ],),
      ),
    )),);
  }
}