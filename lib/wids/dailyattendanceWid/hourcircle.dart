import 'package:flutter/material.dart';

class Hourcircle extends StatefulWidget {
  bool s;
   Hourcircle({super.key,required this.s});

  @override
  State<Hourcircle> createState() => _HourcircleState();
}

class _HourcircleState extends State<Hourcircle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(color: widget.s?Colors.lightGreen:Colors.red.shade500,borderRadius: BorderRadius.circular(90)),
        child: Center(child: Text(widget.s?"P":"A",style: TextStyle(color: Colors.white),),),),
    );
  }
}