import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/studentview/timetable.dart';
import 'package:ecollege/screens/login/loginscrn.dart';
import 'package:ecollege/wids/button.dart';
import 'package:ecollege/wids/dailyattendanceWid/hourcircle.dart';
import 'package:ecollege/wids/listtile/listtile.dart';
import 'package:ecollege/wids/msgvw.dart';
import 'package:ecollege/wids/newscontainer.dart/newscontainer.dart';
import 'package:ecollege/wids/profile/profile.dart';
import 'package:ecollege/wids/sqrbtn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Basicpro>().getStudentDetails();
     Future.delayed(Duration(seconds: 1)).then((onValue)=> context.read<Basicpro>().setLoading(false));
    
  }
  @override
  Widget build(BuildContext context) {
    final shcut= context.watch<Basicpro>();
 if (context.watch<Basicpro>().isLoading3) {
  context.read<Basicpro>().getStudentDetails();
  context.read<Basicpro>().calculatePercentage();
  context.read<Basicpro>().setDailyattn(context);
      return const Scaffold(
        body: Center(
          // Display a simple loading indicator
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: RefreshIndicator(
            onRefresh: () async{
              final scut= context.read<Basicpro>();
                    scut.getStdfrmcld();
                    scut.getStudentDetails();
                    scut.getAttendanceStd();
                    scut.calculatePercentage();
                    context.read<Basicpro>().setDailyattn(context);
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                 
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.deepPurple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Consumer<Basicpro>(
                        builder: (a,scut,c)=> Column(
                          children: [ Padding(
                            padding: const EdgeInsets.fromLTRB(7,5,300,3),
                            child: InkWell(
                              onTap: (){
                                showLogoutDialog(context);
                              },
                              child: Icon(Icons.logout,color: Colors.white,size: 30,)),
                          ),
                            Center(
                              child: Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Container(
                                  child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade400,
              child: Text(
                (shcut.std1?.name != null && shcut.std1!.name!.isNotEmpty)
                    ? shcut.std1!.name![0].toUpperCase()
                    : "",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                            ),
                            Text(
                           
                              shcut.std1?.name??"", 
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Reg No : ",style: TextStyle(color: Colors.white),),
                                Text(
                                  shcut.std1?.id.toString()??"",
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                )
                              ],
                            ),
                            Text("Batch : ${shcut.std1?.batch.toString()}"??"",style: TextStyle(color: Colors.white)),
                             Text("Attendance percentage : ${shcut.percentage.toString()}%"??"",style: TextStyle(color: Colors.white)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buttonst(
                                    padding: 2,
                                    width: 120,
                                    clr: Colors.grey.withAlpha(140),
                                    txtclr: Colors.white,
                                    txt: "Time table",
                                    onPressed: () async {
                                      context.read<adminpro>().getTT(context);
                                      Future.delayed(Duration(milliseconds: 200))
                                          .then((a) => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => TTView())));
                                    }),
                                buttonst(
                                    padding: 2,
                                    width: 120,
                                    clr: Colors.grey.withAlpha(160),
                                    txtclr: Colors.white,
                                    txt: "Profile",
                                    onPressed: () {
                                      context.read<Basicpro>().calculatePercentage();
                                       Future.delayed(Duration(milliseconds: 500))
                                          .then((a) => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                   ProfileScreen(name: scut.std1!.name, rollNo:  scut.std1!.rollNo, 
                                                   batch: scut.std1!.batch.toString(), regNo:  scut.std1!.id.toString(),
                                                    attendancePercentage: double.parse(scut.percentage.toStringAsFixed(2)), email:  scut.std1!.email
                                                    , className:  scut.std1!.className.toString(),))));
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // ... Other Widgets ...
                  SizedBox(height: 30,),
                  ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    child:
                  Consumer<Basicpro>(
                  builder: (a,b,c)=> Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    
              Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                Text(DateFormat('EEE').format(DateTime.now()),
                style: TextStyle(fontSize: 13,textBaseline: TextBaseline.ideographic),),
             SizedBox(width: 13,), 
             Text( DateFormat('M/d/y').format(DateTime.now())
             ,style: TextStyle(fontSize: 13,textBaseline: TextBaseline.ideographic)),],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
              child: ClipRRect(
                child: Material(
                  shadowColor: Colors.black,
                  elevation: 123,
                  child: Container(
                  
                    width: 320,
                    height: 65,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.deepPurple],
                            begin: Alignment.topRight,
                            end: Alignment.bottomCenter,
                          ),borderRadius: BorderRadius.circular(13)),
                  child: 
               Consumer<Basicpro>(
                     builder: (a,z,c)=>Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Hourcircle(s: z.first),
                          Hourcircle(s: z.second),
                          Hourcircle(s: z.third),
                          Hourcircle(s: z.fourth),
                          Hourcircle(s: z.fifth),
                 
                        ],
                        ),
                      ),
                    )
                 
                  ),
                ),
              ),
            ),
                    ],
                  ),
                )
                ),
                    SizedBox(height: 30,),
            Consumer<adminpro>(builder: (context, s, child) => CarouselSlider(
                         items: [
                         (s.messages.isNotEmpty)?InkWell(
                          onLongPress: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                            Msgvw(date: "", text: s.messages[s.messages.length].text)));
                          },
                          child: Newscontainer(text: s.messages[s.messages.length-1].text)):Newscontainer(text: "The Pilathara Co-operative Arts & Science College is a unit of Co-operative Institute of Educational, Paramedical and Technology Ltd. Madai No. C 1740, established in 2006, and registered under Kerala Co-operative Society’s act 1969.",),
               (s.messages.length>1)?Newscontainer(text:s.messages[s.messages.length-2].text):Newscontainer(text: "The society is founded with the aim of providing quality education at affordable cost keeping social justice under social control This College is recognized by Kerala Government and affiliated to Kannur University in 2008.",),
                (s.messages.length>2)?Newscontainer(text:s.messages[s.messages.length-3].text):Newscontainer(text: "It is our responsibility to inspire and challenge everyone in an environment that makes learning enjoyable and which meets the hopes, ambitions, skills and aspirations of every student.",),
              
                        
                        ],
                        options: CarouselOptions(
                          enlargeFactor: 0.2,
                            enlargeCenterPage: true, height: 200, autoPlay: true)),
            )
            
            
               
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
   void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
           Navigator.pop(context);
           // close dialog
            },
            child:  Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
             context.read<Basicpro>().signout();
  if (!mounted) return;
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => LoginScreen()),
    (route) => false,
  );
             // close dialog
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

}