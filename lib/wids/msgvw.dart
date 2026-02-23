import 'package:flutter/material.dart';

class Msgvw extends StatefulWidget {
String date;
   Msgvw({super.key,required this.date,required this.text});
 String text;
  @override
  State<Msgvw> createState() => _MsgvwState();
}

class _MsgvwState extends State<Msgvw> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Message"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 370,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.text,overflow: TextOverflow.clip,
                        style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),decoration: BoxDecoration( 
              borderRadius: BorderRadius.all(Radius.circular(17)),
                 gradient: LinearGradient(
                            colors: [Colors.black, Colors.deepPurple],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),),),
        ),
      ),
    ),);
  }
}