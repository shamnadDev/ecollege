import 'package:ecollege/models/subject.dart';
import 'package:flutter/material.dart';

Widget dentry(List<String> ls,
String txt,ValueChanged<dynamic> d){

return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$txt\t:",style: TextStyle(fontSize: 18),),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu(
              enableSearch: true,
              enableFilter: true,
              onSelected: d,
              width: 260,
              dropdownMenuEntries: 
            ls.map<DropdownMenuEntry>(
              (s){
                return DropdownMenuEntry(
                  value: s, label: s);}).toList()),
          ),
        ),
      
      ],
    );

}