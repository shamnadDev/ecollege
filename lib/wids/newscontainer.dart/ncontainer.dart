import 'package:flutter/material.dart';

class Ncontainer extends StatelessWidget {
  String text;
  String timeorother;
   Ncontainer({super.key,required this.text,required this.timeorother});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Container(
            
            width: 320,
            decoration: BoxDecoration(
             
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.deepPurple],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
               borderRadius: BorderRadius.circular(20),
              ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween
                  ,
                  children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: [
               Container(
                width: 250,
                 child: Text(
          
           text,
           maxLines: 6,
           overflow: TextOverflow.clip, // or TextOverflow.clip
           softWrap: true,
           style: const TextStyle(color: Colors.white),
                 ),
               )
              ],
            ),
          )
                ,
                
                ],),
              ),
            ),),
        Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Padding(
                      padding: const EdgeInsets.fromLTRB(0,3,35,3),
                      child: Text(timeorother,overflow: TextOverflow.visible,style: TextStyle(fontSize: 12,color: Colors.black),),
                    )],),
                ) 
        ],
      ),
    );
  }
}