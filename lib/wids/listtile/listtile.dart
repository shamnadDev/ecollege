import 'package:flutter/material.dart';

class listtile extends StatelessWidget {
  const listtile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        child: Material(
          elevation: 23,
          child: Container(
          decoration: BoxDecoration( gradient: LinearGradient(
                        colors: [Colors.black, Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),borderRadius:BorderRadius.circular(18) ),
          height: 70,
          width: 350,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
children: [
  Padding(
    padding: const EdgeInsets.all(18.0),
    child: Icon(Icons.person,size: 30,color: Colors.white,),
  ),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: SizedBox(
    width: 178,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4,)
     , Text(overflow: TextOverflow.ellipsis,"Report",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
      Text(overflow: TextOverflow.ellipsis,"this message is safe higher authority cant know who is send the message",style:TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white))
    ],),
  ),
),Spacer(flex:2),
Padding(
  padding: const EdgeInsets.only(left: 8,right: 8,bottom: 20,top: 2),
  child: Text("8:09pm",style:TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w500)),
)
],

          ),
                )),
      ),
    );
  }
}