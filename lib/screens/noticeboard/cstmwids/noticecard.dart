import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Noticecard extends StatelessWidget {
  const Noticecard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        child: Material(
          elevation: 23,
          child: Container(
          decoration: BoxDecoration(color:Colors.grey.withAlpha(40) ,borderRadius:BorderRadius.circular(18) ),
          height: 75,
          width: 355,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
children: [
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                           color: Colors.grey.withAlpha(60), 
                            borderRadius: BorderRadius.circular(100)),
      child: Icon(Ionicons.clipboard),),
  ),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: SizedBox(
    width: 178,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 7,)
     , Text(overflow: TextOverflow.ellipsis,"namesd",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
     Text(overflow: TextOverflow.clip,"d hbsdhjfb hdgv ",style: TextStyle(fontSize: 10,),),
     
    ],),
  ),
),
],

          ),
                )),
      ),
    );
  }
}