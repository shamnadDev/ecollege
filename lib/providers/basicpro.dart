import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecollege/models/attendance.dart';
import 'package:ecollege/models/message_model.dart';
import 'package:ecollege/models/student.dart';
import 'package:ecollege/models/subject.dart';
import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/screens/Messagelist.dart';
import 'package:ecollege/screens/home/home.dart';
import 'package:ecollege/screens/home/studentattendacelist.dart' hide Attendance;
import 'package:ecollege/screens/messages/messagescrn.dart';
import 'package:ecollege/screens/messages/report.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Basicpro extends ChangeNotifier{


  final TextEditingController msgcontroller = TextEditingController();
  
   List<MessageModel> messages = [];
    List<MessageModel> get _messages=>messages;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController registernum = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController lgnemail = TextEditingController();
  final TextEditingController lgnpass = TextEditingController();  
  final TextEditingController batch = TextEditingController();
    final TextEditingController regid = TextEditingController();
  final TextEditingController classname = TextEditingController();


  List<Widget> screens=[home(),MessageScreen(),Messagelist(),AttendanceScreen( )];
  int currentIndex = 0;
  final subjectNameController = TextEditingController();
  final subjectIdController = TextEditingController();
  int get _currentIndex => currentIndex;
  final box=Hive.box<Subject>("subjects");
  final stdbox=Hive.box<Student>("student");
  final msgbox=Hive.box<MessageModel>("message");
  final recmsgbox=Hive.box<MessageModel>("recmsg");
  late int intex;
  void setindex(int a){
intex=a;
notifyListeners();
  }
  void addSubject()async{
    
    print(box.values.toSet().toString());
    String name=subjectNameController.text.trim().toString();
    String id=subjectIdController.text.trim().toString();
await FirebaseFirestore.instance.collection("subject")
.add(Subject(subjectid: id, 
subjectname:name ).toJson());
box.put(id,Subject(subjectid: id, subjectname: name)) ;
  }
  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }


Stream<List<Subject>> getSubs(){
  return FirebaseFirestore.instance
      .collection('subject')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Subject.fromJson(doc.data());
        }).toList();
      });


}
void addtohive()async{
  
final a= await FirebaseFirestore.instance.collection('subject').get();
      for(var doc in a.docs){
box.put(doc.data()["subjectid"],Subject.fromJson(doc.data()));

  }
} 
void deleteSub(Subject mdl)async{
box.values.forEach((a){
  if(a.subjectid==mdl.subjectid&&a.subjectname.toString()==mdl.subjectname.toString()){
    a.delete();
   s.removeWhere((b) =>
    b.subjectid == mdl.subjectid &&
    b.subjectname.toString() == mdl.subjectname.toString()
);
  }
});
final snapshot = await FirebaseFirestore.instance
    .collection("subject")
    .where("subjectid", isEqualTo: mdl.subjectid)
    .where("subjectname", isEqualTo: mdl.subjectname)
    .get();

if (snapshot.docs.isEmpty) {
  print(mdl.subjectid);
  print("No matching documents found");
} else {
  for (var doc in snapshot.docs) {
    await doc.reference.delete();
  }
}
notifyListeners();

}
 String sna="";
 String sid="";
List<Subject> _s=[];
 List<Subject> get s=>_s;


void getlocalysub()async{
_s=  await box.values.toList().cast<Subject>();
//print(box.values.toList().toString()); 
notifyListeners();
}
void registerStudent()async{
  final scut=Student(
    name: nameController.text.toString(), 
    id: registernum.text.trim().toString(),
    rollNo: rollNoController.text.trim(),
   email: emailController.text.trim()
   ,password:passwordController.text.trim().toString(),
   phone: phoneController.text.toString().trim(),
   batch:  sid.toString(),
   className: sna.toString()
   );
   final s=await SharedPreferences.getInstance();
   s.setString("stdid", scut.id.toString());
await FirebaseFirestore.instance.collection("login").doc("student").
collection("students").add( scut.toMap(),);
stdbox.put(scut.id,scut);

}
 Student? std1;
void getStudentDetails()async{
  getStdfrmcld();

     final s=await SharedPreferences.getInstance();
String id=s.getString("stdid").toString();

print(stdbox.values.length);
std1=stdbox.get(id);
notifyListeners();
print(std1?.name);

}
void getStdfrmcld()async{
final a=  await FirebaseFirestore.instance.collection("login").
doc("student").
collection("students").get();
for(var doc in a.docs){
print(doc.data()["id"]);
stdbox.put(doc.data()["id"], Student.fromJson(doc.data()));
}

}
List<Student> std=[];
 

void getstd(String s,String b)async{
  std.clear();
stdbox.values.forEach((a){
  if(a.batch==b&&a.className==s){
    std.add(a);
    print(a.name);
  }
});
print(std.first.name);
}

int? k;
int? get _k=>k;

void loginstd()async{
  
final a=  await FirebaseFirestore.instance.collection("login").doc("student").
collection("students").get();
final s=await SharedPreferences.getInstance();
 for(var doc in a.docs){
  final as=Student.fromJson(doc.data());
if(lgnemail.text.trim().toString()==as.email.toString()&&lgnpass.text.toString().trim()==as.password){
k=1;
print(doc.data()["email"]);
 
   s.setString("stdid", as.id.toString());
notifyListeners();
} else if(lgnemail.text.trim().toString()=="adminlgn@ecollege.com"&&lgnpass.text.toString().trim()=="adminasdf"){
 s.setString("admin", "adminlogin");
  k=2;
}

  }
//if(emailController.text==a.docs.forEach((e){return e.data()["email"];})){}
notifyListeners();
}
void signout()async{
      final s=await SharedPreferences.getInstance();
s.clear();
box.clear();

 stdbox.clear();
 msgbox.clear();
 recmsgbox.clear();
 setLoading(true);
notifyListeners();
}

 Future<String> getUserType() async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getString('admin') != null) {
    return "admin";
  } else if (prefs.getString('stdid') != null) {
    return "student";
  }else{
    return "notLoggedIn";
  }
}

String status="";
void statusset(String st){
status=st;
notifyListeners();
}
String stdname="";
String get _stdname=>stdname;
String rollno="";
String get _rollno=>rollno;
String subname="";
String get _subname=>subname;
String subid="";
String get _subid=>subid;
Student? stud;
Student? get _stud=>stud;
  bool isLoading3 = true;
List<Attendance> lattn=[];
setLoading(bool bl){
  isLoading3=bl;
  notifyListeners();
}
setSub(String subn,String subidw){
  subid=subidw;
  subname=subn;
  notifyListeners();
}
void getcurrentstd(){
std.forEach((a){if(a.name==stdname&&a.rollNo==rollno){stud=a;}});

}
void addAttendance(BuildContext ctx)async{
  print(intex);
  getcurrentstd();
  final scut=ctx.read<adminpro>();
  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
 final s= Attendance(id: stud!.id.toString(), name: stud!.name, status: status, subjectname: subname,
   subjectid: subid, date: DateTime.now(),
   dateformatted: formattedDate.trim(),index: intex,className: scut.classn,batch: scut.batch);


  lattn.removeWhere((a) => a.id == s.id);
  lattn.add(s);
 
}
void addattntoHF(BuildContext ctx){
   lattn.forEach((a)async{
    print(a.subjectname);
    await FirebaseFirestore.instance.collection("attendance").add(a.toJson());
  });

  Navigator.pop(ctx);
}
bool First=false;
bool Second=false;
bool Third=false;
bool Fourth=false;
bool Fifth=false;

void geAttendance(BuildContext ctx)async{
  final scut=ctx.read<adminpro>();
  final attn= await FirebaseFirestore.instance.collection("attendance").
  where("dateformatted",isEqualTo: DateFormat('dd/MM/yyyy').format(DateTime.now())).where("batch",isEqualTo: scut.batch)
  .where("className",isEqualTo: scut.classn).get();
attn.docs.forEach((val){
  print("object");
  int ind=val.data()["index"];
if(ind==1){
  print("trueee");
                 First=true;
                 notifyListeners();
                 } 
                 if(ind==2){
                 
                     Second=true;
                 notifyListeners();
                 } 
                 if(ind==3){
                 
                     Third=true;
                 notifyListeners();
                
                 } 
                 if(ind==4){
                         Fourth=true;
                 notifyListeners();
               
                 } 
                 if(ind==5){
                 
                    Fifth=true;
                 notifyListeners();
                 
                 }
});

}
late String docid;
void modifyattn(String subidd)async{
  // prin();
  print( intex);
  final fff=await FirebaseFirestore.instance.collection("attendance").
  
  where("dateformatted",isEqualTo: shwdt.trim().toString()).
  where("id",isEqualTo: regid.text.trim().toString())
  
 .
  where("subjectid",isEqualTo: subidd)
  .
  where("index",isEqualTo:intex)
  .get();
    print (fff.docs.first.data()["subjectid"].toString()??"");

  docid=fff.docs.single.id;
 print(docid);
notifyListeners();
  

}
void editattn(String stat)async{
 await FirebaseFirestore.instance.collection("attendance").doc(docid).update({"status":stat});
}
List<Attendance> listatten=[];
void listAttn(BuildContext ctx,String subid)async{
  listatten.clear();
  final scut=ctx.read<adminpro>();
final attnlist=await FirebaseFirestore.instance.collection("attendance").
where("batch",isEqualTo: scut.batch).
where("className",isEqualTo: scut.classn).
where("dateformatted",isEqualTo: shwdt).
where("subjectid",isEqualTo: subid).where("index",isEqualTo: intex).get();
attnlist.docs.forEach((a){
  listatten.add(Attendance.fromJson(a.data()));
notifyListeners();
});

print(listatten.length);
}
late String shwdt="";
void dtnotify(DateTime date){
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
  shwdt=formattedDate;
  print(shwdt);
notifyListeners();
}

Future<void> totaldateinjection(BuildContext ctx) async {
  final scut=ctx.read<adminpro>();
  DateTime d = DateTime.now();
  print(scut.batch);
  String dateOnly = d.toString().split(' ')[0]; 
  // if (std.isEmpty || std.first.className == null || std.first.batch == null) {
  //   print("Error: std data is incomplete or empty.");
  //   return;
  // }
  

  try {
    final querySnapshot = await FirebaseFirestore.instance.collection("attendancerecord")
        .where("class", isEqualTo: scut.classn)
        .where("batch", isEqualTo: scut.batch.toString())
        .where("date", isEqualTo: dateOnly).limit(1)
       
        .get();
        print(querySnapshot.docs.length);
    if (querySnapshot.docs.isEmpty) {
      print("No existing record found for ${scut.classn}, $batch, $dateOnly. Injecting new entry.");
      
      await FirebaseFirestore.instance.collection("attendancerecord").add({
        "class": scut.classn,
        "batch": scut.batch.toString(),
        "date": dateOnly,
      });
      
      print("New attendance date record successfully added.");
    } else {
      print("Record already exists for ${scut.classn}, $batch, $dateOnly. Skipping injection.");
    }
  } catch (e) {
    print("An error occurred during totaldateinjection: $e");
  }
}
double percentage=0;
void calculatePercentage()async{
final a=await FirebaseFirestore.instance.collection("attendancerecord").get();

final s=await FirebaseFirestore.instance.collection("attendance")
.where("id",isEqualTo:std1?.id).where("status",isEqualTo: "present").get();


double attnded=s.docs.length/5;
print(s.docs.length);

  if (a.docs.isEmpty) {
    percentage = 0;
    notifyListeners(); 
  } else
   {
    percentage = (attnded / a.docs.length) * 100;
    percentage.toStringAsFixed(2);
    notifyListeners();
  }


}

//messages
void sendMessage()async{
 
  getStudentDetails();

  // print(std1?.id);
  final b=std1?.id;
  MessageModel a=MessageModel(id: b.toString(), text: msgcontroller.text.toString()
  , timestamp: DateTime.now());
//  print(a.text);
  final as=await FirebaseFirestore.instance.collection("report").add(a.toJson());
  // print(as.id);
msgbox.put(a.timestamp.toString(),a);

}

List<MessageModel>ds=[];
void getfromclMessages()async{
   ds.clear();
   final mks=await FirebaseFirestore.instance.collection("report").orderBy("timestamp",descending: true).snapshots().listen((a){
    if(a.docs.isEmpty){
msgbox.clear();
}
a.docs.forEach((b)async{
  
  print(b.id);
   final fl= MessageModel.fromJson(b.data());
      ds.add(fl);  
      await  msgbox.put(fl.timestamp.toString(), MessageModel.fromJson(b.data()));
    });
    print(msgbox.values.length);
   msgbox.values.forEach((b){  
 if(ds.any((n)=>n.timestamp!=b.timestamp))
 {
      print("truee");
      
     ds.add(b);
     }
     else
     {
     
     }
  
ds.removeWhere((item) {
  final firstIndex = ds.indexWhere(
    (e) => e.timestamp == item.timestamp,
  );
  return ds.indexOf(item) != firstIndex;
});
 });
ds.sort((a, b) => DateTime.parse(a.timestamp.toString()).compareTo(DateTime.parse(b.timestamp.toString())),);
notifyListeners();
   });
  


ds.sort((a, b) => DateTime.parse(a.timestamp.toString()).compareTo(DateTime.parse(b.timestamp.toString())),);
notifyListeners();
}
bool isLoading1 = true;
Future<void> loadData1() async {
    
    // isLoading1 = true;
  

  await Future.delayed(const Duration(seconds: 2));


    isLoading1 = false;
  notifyListeners();
}
bool isLoading = true;
Future<void> loadData() async {
    
    // isLoading = true;
  

  await Future.delayed(const Duration(seconds: 2));


    isLoading = false;
  notifyListeners();
}
void getfromcloudMessages()async{
  
   messages.clear();
   final mks=await FirebaseFirestore.instance.collection("report").
   orderBy("timestamp",descending: true).snapshots().listen((a){

   });
   

messages.sort((a, b) => DateTime.parse(a.timestamp.toString()).compareTo(DateTime.parse(b.timestamp.toString())),);
notifyListeners();
}
void deleteMsg(MessageModel mdl)async{
 
msgbox.values.forEach((a){
  if(a.id==mdl.id&&a.timestamp.toString()==mdl.timestamp.toString()&&a.text==mdl.text){
    a.delete();
  }
});
final a=await FirebaseFirestore.instance.collection("report").get();
a.docs.forEach((as)async{
  if(as.data()["id"]==mdl.id&&as.data()["text"]==mdl.text){
await as.reference.delete();
  }else{
    print("notif");
  }

});
ds.removeWhere((a)=>a.id==mdl.id&&a.timestamp.toString()==mdl.timestamp.toString()&&a.text==mdl.text);
// getfromclMessages();
notifyListeners();
}
String formatTime(DateTime ts) {
  return DateFormat('M/d/y hh:mm a').format(ts);
}
bool first=false;
bool second=false;
bool third=false;
bool fourth=false;
bool fifth=false;

  StreamSubscription? attendanceSub;

                 void disposeDailyAttendanceListener() {
    attendanceSub?.cancel();
    attendanceSub = null;
  }

void setDailyattn(BuildContext context) {
  attendanceSub?.cancel();
print(std1?.id);

   FirebaseFirestore.instance
      .collection("attendance")
      .where("dateformatted",
          isEqualTo: DateFormat('dd/MM/yyyy').format(DateTime.now()))
      .where("id", isEqualTo:std1?.id?.trim().toString())
      .where("status", isEqualTo: "present")
      .snapshots()
      .listen((snapshot) {
    // Reset flags on every update
    first = second = third = fourth = fifth = false;

    for (var doc in snapshot.docs) {
      int ind = doc.data()["index"];

      if (ind == 1) first = true;
      if (ind == 2) second = true;
      if (ind == 3) third = true;
      if (ind == 4) fourth = true;
      if (ind == 5) fifth = true;
    }

    notifyListeners();
  });
}
List<Attendance> stdattn=[];
void getAttendanceStd()async{
stdattn.clear();
FirebaseFirestore.instance
    .collection("attendance")
    .orderBy("date", descending: true)
    .snapshots()
    .listen((snapshot) {
  stdattn.clear();
  for (var doc in snapshot.docs) {
    stdattn.add(Attendance.fromJson(doc.data()));
  }
  stdattn.removeWhere((a)=>a.id!=std1?.id);
  notifyListeners();
});

}
// Stream<QuerySnapshot<Map<String, dynamic>>> gettodayAtten(BuildContext ctx){
  
//   final s= FirebaseFirestore.instance.collection("attendance")
// .where("id",isEqualTo:std1?.id).
// where("status",isEqualTo: "present")
// .snapshots();
// return s;

// }
}