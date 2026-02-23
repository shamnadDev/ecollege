import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecollege/models/message_model.dart';
import 'package:ecollege/models/messageadm.dart';
import 'package:ecollege/models/student.dart';
import 'package:ecollege/models/subject.dart';
import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class adminpro extends ChangeNotifier{
  Set<String> s={"monday"};
  Set<String> get _s=>s;
 
  final box=Hive.box<Timetable>("timetable");

   void setset(Set<String> sd){
s=sd;
notifyListeners();
    
  }
    String classn="";
  String get _classn=>classn;
   void classget(String sd){
classn=sd;
notifyListeners();
    
  }
  late int ttbatch;
  String ttclass="";
 late int batch;
  int get _batch=>batch;
//    void batchget(int sd){
// batch=sd;
// print(batch);
// notifyListeners();
    
//   }

   late Subject first;
  Subject get _first=> first;
   late Subject second;
  Subject get _second=> second;
   late Subject third;
  Subject get _third=> third;
   late Subject fourth;
  Subject get _fourth=> fourth;
   late Subject fifth;
  Subject get _fifth=> fifth;
  late Subject efirst;
  late Subject esec;
  late Subject ethird;
  late Subject efourth;
  late Subject efifth;
   final stdbox=Hive.box<Student>("student");
   void chksub(){
    // subs.
   }
  void submitTt()async{
    Timetable dat=Timetable(batch: batch, classid: classn, day: s.single.toString(), first: first, 
    second: second, third: third, fourth: fourth, fifth: fifth);
    if(batch==null&&first==null&&second==null&&third==null&&fourth==null&&fifth==null&&s==null){
      print("something not given");
    }else{
   final s= await FirebaseFirestore.instance.collection("timetable").
    add(dat.toJson());
   box.put(s.id, dat);
    }
  }
  void addtttolocal()async{
    box.clear();
     final a= await FirebaseFirestore.instance.collection("timetable")
.get();

  for(var dcs in a.docs){

  box.put(dcs.id, Timetable.fromJson(dcs.data()));
}
// print(box.values.length);
  }
     late List<Timetable> subs;
  List<Timetable> get _subs=> subs;
     late List<Timetable> stds;
  List<Timetable> get _stds=> stds;
   Map<String, int> _dayOrder = {
  'Monday': 0,
  'Tuesday': 1,
  'Wednesday': 2,
  'Thursday': 3,
  'Friday': 4
  
};
  void getTTlocal(){
    addtttolocal();
subs= box.values.toList();

notifyListeners();
// print(subs.first.first.subjectname);
  }
 final ValueNotifier<Timetable?> tte = ValueNotifier(null);
 String sa = "";

  void getttedit(String as){
    
print(ttbatch);
  final day = as.isEmpty ? "Monday" : as;
sa=day;
  // print("as");
  if(box.isNotEmpty){ final result= box.values.where((a)=>a.batch==ttbatch&&a.classid==ttclass&&a.day==day);
tte.value = result.first;
// notifyListeners();
}

}
void edittt(BuildContext ctx)async{

 final ab=await FirebaseFirestore.instance.collection("timetable").
 where("batch",isEqualTo: ttbatch).
 where("classid",isEqualTo: ttclass).
 where("day",isEqualTo: sa).limit(1).get();

  if (ab.docs.isEmpty) {
    print("No document found");
    return;
  }

  final docId = await ab.docs.first.id;
  print(docId);
Timetable tt=Timetable(batch: ttbatch, classid: ttclass, day: sa, 
first: efirst, second: esec, third: ethird, fourth: efourth, fifth: efifth);
  await FirebaseFirestore.instance
      .collection("timetable")
      .doc(docId)
      .update(tt.toJson());
      box.put(docId,tt);
      getttedit(sa);

}
  void getTT(BuildContext ctx){
  //  addtttolocal();
getTTlocal();
final scut=ctx.read<Basicpro>();
subs=box.values.where((c)=>c.batch.toString()==scut.std1?.batch&&c.classid==scut.std1?.className).toList();
 print(subs.isEmpty.toString());
subs.sort((a, b) {
  // Get indices
  int s = _dayOrder[a.day.trim()] ?? 99;
  int f = _dayOrder[b.day.trim()] ?? 99;
  
  // *** ADD THIS DEBUG LINE ***
  print('Comparing ${a.day} ($s) vs ${b.day} ($f)');

  return s.compareTo(f);
  
});

// The 'subs' list is now correctly sorted by day (Monday, Tuesday, Wednesday, etc.)
// subs.where((s){
//   return s.day==
// });
//  notifyListeners();
  }
  // Timetable getparticulartt(){
  //   Timetable
  //   subs.
  // }
   late Timetable tt;
  Timetable get _tt=> tt;
  late Timetable te;
  Timetable get _te=> te;

  int getTimetable(){
    getTTlocal();
print(batch);
// print(tt.first.subjectname);
    
    DateTime date = DateTime.now(); 
String dayName = DateFormat('EEEE').format(date);

int chk=0;
print(dayName);
print(batch);
for(var sub in subs ){
  print(sub.first.subjectname);
  if(sub.batch==batch&&sub.classid==classn&&sub.day==dayName){
   
   print("object");
    tt=sub;
chk=1;
  }

}
return chk;
  }
  int getTTedit(BuildContext ctx){
    getTTlocal();
print(batch);
// print(tt.first.subjectname);
    

  // DateTime dt = DateTime.parse(ctx.read<Basicpro>().shwdt);
   DateTime date = DateFormat('dd/MM/yyyy')
   .parse(ctx.read<Basicpro>().shwdt);
// String dayName = DateFormat('EEEE').format(dt);
  const days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String day = days[date.weekday - 1];
int chk=0;
print(day);
print(batch);
for(var sub in subs ){
  print(sub.first.subjectname);
  if(sub.batch==batch&&sub.classid==classn&&sub.day==day){
   
   print("object");
    te=sub;
chk=1;
  }

}
return chk;
  }
final List<int> years = [
  2015,
  2016,
  2017,
  2018,
  2019,
  2020,
  2021,
  2022,
  2023,
  2024,
  2025,
];
final List<String> subjects = [
  
];

final List<String> classNames = [
    'BCA',
    'BBA',
    'BSc Computer Science',
    'BA English',
    'BCom',
    'BTech',
    'MCA',
    'MBA',
    'MSc Mathematics',
    'MA History',
  ];
// String class;
// String batch;
// subject first;
// subject second;
// subject third;
// subject fourth;
// subject fifth;

   List<Messageadm> messages = [];
    List<Messageadm> get _messages=>messages;


   final msgbox=Hive.box<Messageadm>("admmsg");
  final adminmsgctrl = TextEditingController();

void sendMessage()async{
 

  Messageadm a=Messageadm(text:adminmsgctrl.text.toString(),date: DateTime.now() );
 print(a.text);
  final as=await FirebaseFirestore.instance.collection("admmsg").add(a.toJson());
  print(as.id);
msgbox.put(a.date.toString(),a);

}
void getfromcloudMessages()async{
print(messages.length);
   messages.clear();
   final mks=await FirebaseFirestore.instance.collection("admmsg").
   orderBy("date",descending: true).snapshots().listen((a){

   print("listening");
    if(a.docs.isEmpty){
msgbox.clear();
}
a.docs.forEach((b)async{

  final fl= Messageadm.fromJson(b.data());
  messages.add(fl);
  print(fl.date);
        await msgbox.put(fl.date.toString(), Messageadm.fromJson(b.data()));
    

    });

     msgbox.values.forEach((a){
     if(messages.any((n)=>n.date!=a.date)){
      print("truee");
      
     messages.add(a);
     }else{
     
     }
       
messages.removeWhere((item) {
  final firstIndex = messages.indexWhere(
    (e) => e.date == item.date,
  );
  return messages.indexOf(item) != firstIndex;
});
});
 
messages.sort((a, b) => DateTime.parse(a.date.toString()).compareTo(DateTime.parse(b.date.toString())),);
  notifyListeners();
   });
   print(msgbox.length);
  
print(messages.length);
// notifyListeners(); 

messages.sort((a, b) => DateTime.parse(a.date.toString()).compareTo(DateTime.parse(b.date.toString())),);
notifyListeners();
}
List<Messageadm> carousellst=[];
void addtolistadmmmsg(){
  getfromcloudMessages();
int index=messages.length;
if(index!=0){
carousellst.add(messages[index]);
}
if(index>0){

carousellst.add(messages[index-1]);
}
if(index>1){
carousellst.add(messages[index-2]);
}
// print(carousellst.length);
notifyListeners();
}
void deleteMsg(Messageadm mdl)async{

msgbox.values.forEach((a){

  if(a.date.toString()==mdl.date.toString()&&a.text==mdl.text){
    a.delete();
  }
});
final a=await FirebaseFirestore.instance.collection("admmsg").get();
a.docs.forEach((as){
  if(as.data()["text"]==mdl.text){
as.reference.delete();
  }else{
    print("notif");
  }

});
getfromcloudMessages();
}
String formatTime(DateTime ts) {
  return DateFormat('M/d/y hh:mm a').format(ts);
}

}