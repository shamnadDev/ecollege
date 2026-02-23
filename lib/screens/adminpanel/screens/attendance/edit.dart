import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/wids/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  final String studentName;

  final String subname;

  final String subid;

  const Edit({
    super.key,
    required this.studentName, required this.subname, required this.subid,
  });

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  
  String _selectedAttendance = 'Present';

  final List<String> attendanceOptions = [
    'Present',
    'Absent',
    'Late',
  ];
@override
  void initState() {
    
    // TODO: implement initState
    super.initState();
    // context.read<Basicpro>().setSub(widget.subname.toString(), widget.subid.toString());
   
  }
  @override
  
  Widget build(BuildContext context) {
    // final s=context.read<Basicpro>();
     
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Student Name
            Text(
              widget.studentName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            /// Attendance Dropdown
            DropdownButtonFormField<String>(
              value: _selectedAttendance,
              decoration: const InputDecoration(
                labelText: 'Attendance Status',
                border: OutlineInputBorder(),
              ),
              items: attendanceOptions.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAttendance = value!;
                });
              },
            ),

            const Spacer(),

            /// Save Buttont
            SizedBox(
              width: double.infinity,
              child: buttonst(
                padding: 0,width: 190,clr:  Colors.grey.shade400,txt: "Submit",
  txtclr: Colors.black,              onPressed: () {
                  // RETURN VALUE BACK
          // scut.addAttendance();
          // print(s.lattn.length);
           context.read<Basicpro>().editattn(_selectedAttendance.trim().toString()); 
          Future.delayed(Duration(seconds: 1)).then((a)async{   
                   
         context.read<Basicpro>().calculatePercentage();
          Navigator.pop(context);
          });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
