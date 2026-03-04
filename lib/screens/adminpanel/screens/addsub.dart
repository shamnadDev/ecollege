import 'package:ecollege/models/subject.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/wids/listtile/listtile.dart';
import 'package:flutter/material.dart';
import 'package:ecollege/wids/button.dart';
import 'package:provider/provider.dart';

class AddSub extends StatefulWidget {
  const AddSub({super.key});

  @override
  State<AddSub> createState() => _AddSubState();
}

class _AddSubState extends State<AddSub> {
  
  final _formKey = GlobalKey<FormState>();


  void _submitForm() async{
    
    if (_formKey.currentState!.validate()) {

      final subjectName = context.read<Basicpro>().subjectNameController.text;
      final subjectId = context.read<Basicpro>().subjectIdController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Subject Added: $subjectName ($subjectId)')),
      ); 
context.read<Basicpro>().addSubject();


 }
  }

  @override
  Widget build(BuildContext context) {final s=context.read<Basicpro>();
s.getlocalysub();
    return Scaffold(
      appBar: AppBar(title: Text("Add subject"),),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 23,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: s.subjectNameController,
                    decoration: InputDecoration(
                      label: Text("Subject Name"),
                      hintText: "Subject Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Subject Name is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: s.subjectIdController,
                    decoration: InputDecoration(
                      label: Text("Subject ID"),
                      hintText: "Subject ID",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Subject ID is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 50),
                buttonst(
                  padding: 0,
                  width: 190,
                  clr: Colors.grey,
                  txtclr: Colors.black,
                  txt: "Submit",
                  onPressed: (){
                      
                    _submitForm();
                    context.read<Basicpro>().getlocalysub();
                         context.read<Basicpro>().subjectNameController.clear();
    context.read<Basicpro>().subjectIdController.clear();
                    },
                ),
                const SizedBox(height: 50),
            Container(
              height: 350,
              width: 380,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)
            ,color: Colors.grey.shade400,),
              child: ListView(
                children: context.watch<Basicpro>().s.map((data) {
                  Subject sub=data;
                  return ListTile(trailing: InkWell(onTap: (){context.read<Basicpro>().deleteSub(sub);},child: Icon(Icons.delete)),title: Text(data.subjectname));
                }).toList(),
              ),
            ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
 }
// import 'package:ecollege/models/subject.dart';
// import 'package:ecollege/providers/basicpro.dart';
// import 'package:ecollege/wids/listtile/listtile.dart';
// import 'package:flutter/material.dart';
// import 'package:ecollege/wids/button.dart';
// import 'package:provider/provider.dart';

// class AddSub extends StatefulWidget {
//   const AddSub({super.key});

//   @override
//   State<AddSub> createState() => _AddSubState();
// }

// class _AddSubState extends State<AddSub> {
  
//   final _formKey = GlobalKey<FormState>();

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {

//       final subjectName =
//           context.read<Basicpro>().subjectNameController.text;
//       final subjectId =
//           context.read<Basicpro>().subjectIdController.text;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text('Subject Added: $subjectName ($subjectId)')),
//       );

//       context.read<Basicpro>().addSubject();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {

//     final s = context.read<Basicpro>();
//     s.getlocalysub();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add subject"),
//       ),
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {

//             double contentWidth = constraints.maxWidth;

//             if (constraints.maxWidth > 1200) {
//               contentWidth = 700;
//             } else if (constraints.maxWidth > 900) {
//               contentWidth = 600;
//             } else if (constraints.maxWidth > 600) {
//               contentWidth = 500;
//             } else {
//               contentWidth = constraints.maxWidth;
//             }

//             return Center(
//               child: Container(
//                 width: contentWidth,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Form(
//                   key: _formKey,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [

//                         const SizedBox(height: 23),

//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             controller: s.subjectNameController,
//                             decoration: const InputDecoration(
//                               label: Text("Subject Name"),
//                               hintText: "Subject Name",
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               if (value == null ||
//                                   value.trim().isEmpty) {
//                                 return 'Subject Name is required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),

//                         const SizedBox(height: 30),

//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             controller: s.subjectIdController,
//                             decoration: const InputDecoration(
//                               label: Text("Subject ID"),
//                               hintText: "Subject ID",
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               if (value == null ||
//                                   value.trim().isEmpty) {
//                                 return 'Subject ID is required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),

//                         const SizedBox(height: 50),

//                         buttonst(
//                           padding: 0,
//                           width: 190,
//                           clr: Colors.grey,
//                           txtclr: Colors.black,
//                           txt: "Submit",
//                           onPressed: () {
//                             _submitForm();
//                             context.read<Basicpro>().getlocalysub();
//                             context
//                                 .read<Basicpro>()
//                                 .subjectNameController
//                                 .clear();
//                             context
//                                 .read<Basicpro>()
//                                 .subjectIdController
//                                 .clear();
//                           },
//                         ),

//                         const SizedBox(height: 50),

//                         Container(
//                           height: 350,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius:
//                                 BorderRadius.circular(12),
//                             color: Colors.grey.shade400,
//                           ),
//                           child: ListView(
//                             children: context
//                                 .watch<Basicpro>()
//                                 .s
//                                 .map((data) {
                              
//                               return ListTile(
//                                 trailing: InkWell(
//                                   onTap: () {
//                                     context.read<Basicpro>().deleteSub(data);
//                                   },
//                                   child:
//                                       const Icon(Icons.delete),
//                                 ),
//                                 title:
//                                     Text(data.subjectname),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }