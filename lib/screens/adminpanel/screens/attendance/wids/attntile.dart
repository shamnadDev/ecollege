
import 'package:ecollege/providers/basicpro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceTile extends StatefulWidget {
  final String name;
  final String detail;

  const AttendanceTile({
    Key? key,
    required this.name,
    required this.detail,
  }) : super(key: key);

  @override
  _AttendanceTileState createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {


  @override
  Widget build(BuildContext context) {
    final scut= context.read<Basicpro>();
       void setStatus(String status) {
    scut.stdname=widget.name;
    scut.rollno=widget.detail;
  
      setState(() {
            context.read<Basicpro>().status = status;
      });
 print("tappedd");
 scut.addAttendance(context);
  }
     Widget _buildCheckbox(String label, String value) {
    return Row(
      children: [
        Checkbox(
          value: context.read<Basicpro>().status == value,
          onChanged: (_) => setStatus(value),
        ),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

   
    return ListTile(
      title: Text(widget.name),
      subtitle: Text(widget.detail),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCheckbox("Present", "present"),
          _buildCheckbox("Late", "late"),
          _buildCheckbox("Absent", "absent"),
        ],
      ),
    );
  }

}