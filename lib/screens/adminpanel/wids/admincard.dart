import 'package:ecollege/providers/basicpro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class adminoptcard extends StatelessWidget {
   adminoptcard({super.key,required this.ic,required this.name,required this.ontap});
VoidCallback ontap;
   String name;
  IconData ic;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
        height: 60,width: double.maxFinite,
            decoration:BoxDecoration() ,
        child: Row(
          
          children: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(ic,size: 37,),
          )
          ,
          SizedBox(width: 13,),
          Text(name,style: TextStyle(fontSize: 18),)
          ],),),
      ));
  }
}