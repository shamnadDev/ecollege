import 'package:ecollege/models/attendance.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/wids/listtile/listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Listattn extends StatefulWidget {
   Listattn( {super.key,required this.sub});
String sub;
  @override
  
  State<Listattn> createState() => _ListattnState();
}

class _ListattnState extends State<Listattn> {


  @override
  
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(title: Text(widget.sub),),
      body: SafeArea(child: 
      context.read<Basicpro>().listatten.isEmpty? Center(child: Text("No records found. Please take attendance to continue.")):
      Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: context.read<Basicpro>().listatten.length,
            itemBuilder: (context,i){
            
          return attendanceTile(context.read<Basicpro>().listatten[i]);
          
          }),
        )
      ],)
      ),
    );
  }

  Widget attendanceTile(Attendance attendance) {
  Color statusColor;

  switch (attendance.status.toLowerCase()) {
    case 'present':
      statusColor = Colors.green;
      break;
    case 'absent':
      statusColor = Colors.red;
      break;
    case 'late':
      statusColor = Colors.orange;
      break;
    default:
      statusColor = Colors.grey;
  }

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: Text(
          attendance.name[0].toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      title: Text(
        attendance.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        "ID: ${attendance.id}",
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          attendance.status.toUpperCase(),
          style: TextStyle(
            color: statusColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
}