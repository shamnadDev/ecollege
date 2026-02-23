import 'package:ecollege/main.dart';
import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/adminhome.dart';
import 'package:ecollege/screens/login/loginscrn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class authcheck extends StatefulWidget {
  const authcheck({super.key});

  @override
  State<authcheck> createState() => _authcheckState();
}
class _authcheckState extends State<authcheck> {
 @override
  void initState() {
    // TODO: implement initState
  //  context.read<Basicpro>().getStdfrmcld();
  //   context.read<Basicpro>().getlocalysub();
  //   context.read<Basicpro>().addtohive();
  //   context.read<Basicpro>().getStudentDetails();
    

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: context.read<Basicpro>().getUserType(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

     if(snapshot.data=="admin"){
        
      return adminhome();
     }else if(snapshot.data=="student"){
         
    // Future.delayed(Duration(seconds: 1)).then((a)=>homemain());
      return homemain();
     }else{
      return LoginScreen();
     }
      },
    );
  }
}