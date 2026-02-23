import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:ecollege/firebase_options.dart';
import 'package:ecollege/models/message_model.dart';
import 'package:ecollege/models/messageadm.dart';
import 'package:ecollege/models/student.dart';
import 'package:ecollege/models/subject.dart';
import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/Messagelist.dart';
import 'package:ecollege/screens/adminpanel/screens/adminmsg.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/attendanceEdit.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/attendancescrn.dart';
import 'package:ecollege/screens/adminpanel/screens/attendance/listattendance.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/slcttt.dart';
import 'package:ecollege/screens/adminpanel/adminhome.dart';
import 'package:ecollege/screens/authcheck.dart';
import 'package:ecollege/screens/bv.dart';
import 'package:ecollege/screens/home/home.dart';
import 'package:ecollege/screens/login/loginscrn.dart';
import 'package:ecollege/screens/messages/report.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() async{
  
    await Hive.initFlutter();
   
     Hive.registerAdapter(SubjectAdapter()); 
     Hive.registerAdapter(TimetableAdapter()); 
     Hive.registerAdapter(StudentAdapter()); 
     Hive.registerAdapter(MessageModelAdapter()); 
     Hive.registerAdapter(MessageadmAdapter()); 
     await Hive.openBox<Subject>("Subjects");
     await Hive.openBox<Timetable>("timetable");
     await Hive.openBox<Messageadm>("admmsg");
      await Hive.openBox<MessageModel>("recmsg");
          await Hive.openBox<Student>("student"); 
          await Hive.openBox<MessageModel>("message");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MultiProvider(providers: [ChangeNotifierProvider(create: (ctx){return Basicpro();}),ChangeNotifierProvider(create: (ctx){return adminpro();})],
    child: MyApp(),)
     );
}
int b=0;

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    

     
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: authcheck()
      
      
    );
  } 
}
class homemain extends StatefulWidget {
  
  const homemain({super.key});

  @override

  State<homemain> createState() => _homemainState();
}

class _homemainState extends State<homemain> {

@override
  void initState() {    
    WidgetsBinding.instance.addPostFrameCallback((_) {
 loadAllData();
    });
    super.initState();
  }
  Future<void> loadAllData() async {
  final basic = context.read<Basicpro>();
  final admin = context.read<adminpro>();

  try {
  
      basic.getStdfrmcld();
      basic.getStudentDetails();
      admin.getfromcloudMessages();
   

    // Run dependent logic after main data is loaded
    basic.calculatePercentage();
    basic.getlocalysub();
    basic.addtohive();
 admin.getTTlocal();
basic.getAttendanceStd();
      context.read<Basicpro>().setDailyattn(context);
     
 
  } catch (e) {
    debugPrint("Error loading data: $e");
  }


}


  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white.withOpacity(0.1),
         bottomNavigationBar: Container(
          clipBehavior: Clip.hardEdge,
           decoration: const BoxDecoration(
            //  borderRadius: BorderRadius.only(topLeft: Radius.circular(22,),topRight:Radius.circular(22) ),
             gradient: LinearGradient(
               colors: [Colors.black, Colors.deepPurple],
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
             ),
           ),
           child: SalomonBottomBar(
             
             backgroundColor: Colors.transparent, // make bar itself transparent
             itemPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
             unselectedItemColor: Colors.white60,
             margin: const EdgeInsets.all(19),
             currentIndex: context.watch<Basicpro>().currentIndex,
             onTap: (index) {
               context.read<Basicpro>().setIndex(index);
             },
             items: [
               SalomonBottomBarItem(
                 icon: const Icon(Icons.home_outlined),
                 title: const Text("Home"),
                 selectedColor: Colors.white,
               ),
               SalomonBottomBarItem(
                 icon: const Icon(Icons.chat_bubble_outline),
                 title: const Text("Chat"),
                 selectedColor: Colors.white,
               ),
               SalomonBottomBarItem(
                 icon: const Icon(Icons.newspaper),
                 title: const Text("Feed"),
                 selectedColor: Colors.white,
               ),
               SalomonBottomBarItem(
                 icon: const Icon(Icons.school_sharp),
                 title: const Text("attendance"),
                 selectedColor: Colors.white,
               ),
             ],
           ),
         ),
       
        body:Consumer<Basicpro>(builder: (a,b,c){
return b.screens[b.currentIndex];
        }) 
        ),
    );
  }
}