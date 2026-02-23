import 'package:ecollege/wids/msgvw.dart';
import 'package:flutter/material.dart';

class Newscontainer extends StatelessWidget {
  String text;
   Newscontainer({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onLongPress: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Msgvw(date: "", text: text)));
        },
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 3,
          child: Container(
            
            height: 160,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25,),
               Row(
                 children: [
                  SizedBox(width: 40,),
                   Container(
                    // height: 130,
                    width: 205,
                     child: Text(
                           
                            text,
                            maxLines: 6,
                            overflow: TextOverflow.clip, // or TextOverflow.clip
                            softWrap: true,
                            style: const TextStyle(color: Colors.white),
                     ),
                   ),
                 ],
               )
              ],
            ),
          )
               
                
                ],),
              ),
            ),),
        ),
      ),
    );
  }
}