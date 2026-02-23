import 'package:flutter/material.dart';

class sqrbtn extends StatelessWidget {double padding;
  double width;
Color clr;
String def;
Color txtclr;
String txt;
IconData ic;
final VoidCallback onPressed;
   sqrbtn({super.key,required this.def,required this.ic,required this.padding,required this.width,required this.clr,required this.txtclr,required this.txt,required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          // enableFeedback: false,
          onTap: onPressed,
          child: ClipRRect(borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 160,
              height: 160,
              decoration: 
              BoxDecoration(border: Border.all(color: clr),color: Colors.white,borderRadius: BorderRadius.circular(20)),
              child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(ic,size: 30,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 72),
                    child: Text(overflow: TextOverflow.visible,txt,style: TextStyle(fontSize: 16,color: txtclr,fontWeight: FontWeight.bold,),),
                  ),
                Padding(
                  padding: const EdgeInsets.only(right: 90,left: 10),
                  child: Center(child: Text(overflow: TextOverflow.visible,def,style: TextStyle(fontSize: 13,color: txtclr,fontWeight: FontWeight.w400),)),
                ),
    
                
                ],
              ),
              
            ),
          ),
        ),
      ),
    );
  }
}