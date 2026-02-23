import 'package:ecollege/screens/messages/report.dart';
import 'package:ecollege/wids/listtile/listtile.dart';
import 'package:flutter/material.dart';

class Messagescrn extends StatefulWidget {
  const Messagescrn({super.key});

  @override
  State<Messagescrn> createState() => _MessagescrnState();
}

class _MessagescrnState extends State<Messagescrn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Messages"),),
    body: Column(children: [
    Center(child: InkWell(onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessageScreen()));
    },child: listtile()))
    //Center(child: listtile()),
       // ListView(children: [listtile()],)
    ],),
    );
  }
}