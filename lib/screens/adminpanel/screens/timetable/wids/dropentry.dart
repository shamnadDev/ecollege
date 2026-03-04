import 'package:ecollege/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget dropentry(List<Subject> ls,
String txt,ValueChanged<dynamic> d){

return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Text("$txt\t:",style: TextStyle(fontSize: 18),),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu(
              enableSearch: true,
              enableFilter: true,
              onSelected:d,
              width: 240,
              dropdownMenuEntries: 
            ls.map<DropdownMenuEntry>(
              (s){
                
                return DropdownMenuEntry(
                  value: s, label:s.subjectname);
                  
                  }).toList()),
          ),
        ),
      
      ],
    );

}