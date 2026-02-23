import 'package:flutter/material.dart';

class buttonst extends StatelessWidget {double padding;
  double width;
Color clr;
Color txtclr;
String txt;
final VoidCallback onPressed;
   buttonst({super.key,required this.padding,required this.width,required this.clr,required this.txtclr,required this.txt,required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: InkWell(
        focusColor: Colors.white,
        onTap:onPressed ,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width,
            height: 35,
            decoration: BoxDecoration(color: clr,borderRadius: BorderRadius.circular(30)),
            child: Padding(padding: EdgeInsets.all(padding),child: Center(child: Text(txt,style: TextStyle(fontSize: 18,color: txtclr,fontWeight: FontWeight.w400),)),),
            
          ),
        ),
      ),
    );
  }
}