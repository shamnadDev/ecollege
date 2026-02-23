// import 'package:ecollege/models/messageadm.dart';
// import 'package:ecollege/providers/adminpro/adminpro.dart';
// import 'package:ecollege/providers/basicpro.dart';
// import 'package:ecollege/wids/msgvw.dart';
// import 'package:ecollege/wids/newscontainer.dart/ncontainer.dart';
// import 'package:ecollege/wids/newscontainer.dart/newscontainer.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class Adminmsg extends StatefulWidget {
//   const Adminmsg({super.key});

//   @override
//   State<Adminmsg> createState() => _AdminmsgState();
// }

// class _AdminmsgState extends State<Adminmsg> {

// void load()async{
// final scut=context.read<Basicpro>();
// if(scut.isLoading1==true){
// await scut.loadData1();
// }else{
// scut.isLoading1=false;
// }
// }
//   bool _isLoading = true;
//   @override
//   void initState() {
// load();
//     super.initState();
//     // 2. Start the data loading process
//     context.read<adminpro>().getfromcloudMessages();
//     _loadStudentData(); 
       
//   }
  
//   // Custom function to handle async data loading
//   void _loadStudentData() async {
//     // Get the provider instance
//     final basicProvider = context.read<Basicpro>();

//     // Call the async data loading function
   
// setState(() {
//   basicProvider.calculatePercentage();
//     basicProvider.getStudentDetails(); 
// });
//     // Once the data is loaded (or not loaded, e.g., std1 is null),
//     // we call setState to rebuild the widget and turn off the loading indicator.
//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
// final ScrollController _scrollController = ScrollController();
//   void _scrollToBottom() {
//     Future.delayed(const Duration(milliseconds: 200), () {
//       if (!_scrollController.hasClients) return;
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     _scrollToBottom();

// final sc=context.watch<Basicpro>();
// final scut=context.read<adminpro>();
// print(scut.messages.length);
//   void _sendMessage()async {
//     String text = scut.adminmsgctrl.text.trim();
//     if (text.isEmpty) return;

//     // Add sender message
//    context.read<adminpro>().sendMessage();
//   //  setState(() {
//   //     context.read<adminpro>().getfromcloudMessages();
//   //  });
  
//    scut.adminmsgctrl.clear() ;
//     _scrollToBottom();
 
//     // Add receiver message after 1 second
//     Future.delayed(const Duration(seconds: 1), () {
      
//       _scrollToBottom();
//     });
//   }
//      if (_isLoading) {
//       return const Scaffold(
//         body: Center(
//           // Display a simple loading indicator
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Messages"),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           // Messages list
//           Padding(
//             padding: const EdgeInsets.only(bottom: 80),
//             child: 
//             sc.isLoading1?
//             Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               SizedBox(height: 370,),
//                               Center(child: const CircularProgressIndicator()),
//                             ],
//                           ):
//             ListView.builder(
//               hitTestBehavior: HitTestBehavior.translucent,
//               // shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               controller: _scrollController,
//               itemCount: context.watch<adminpro>().messages.length,
//               itemBuilder: (context, index) {
//                  final d=context.watch<adminpro>().messages;
//                 final msg = d[index];
//                 // print(msg.date);
// final time=scut.formatTime(msg.date);
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: 
//                             InkWell(onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Msgvw(date:time, text: msg.text,)));
//                     },
//                               onLongPress: () {
//                                 showMessageOptions(context, msg);
//                               },
//                               child: Ncontainer(text:msg.text.toString(),timeorother:time.toString())),
//                 );
//               },
//             ),
//           ),

//           // Input section
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
//               decoration: BoxDecoration(
//            color: const Color.fromARGB(255, 38, 1, 73),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 8,
//                       offset: Offset(0, -2))
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(24),
//                         border: Border.all(color: Colors.black),
//                       ),
//                       child: TextField(
//                         controller: scut.adminmsgctrl,
//                         decoration: const InputDecoration(
//                           hintText: "Type your message...",
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   CircleAvatar(
                    
//                     radius: 30,
//                     backgroundColor:Colors.white,
//                     child: InkWell( onTap: ()async{_sendMessage();},
//                       child: Icon(
//                         Icons.send_rounded,color: Colors.black,
                       
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void showMessageOptions(BuildContext context, Messageadm message) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text("Message Options"),
//         content: Text("What do you want to delete this message?"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // close dialog
//               print("Edit selected");
//               // TODO: open your edit screen / update function
//             },
//             child: Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               context.read<adminpro>().deleteMsg(message);
//               Navigator.pop(context); // close dialog
//               print("Delete selected");
//               // TODO: delete the message from database or list
//             },
//             child: Text("Delete", style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       );
//     },
//   );
// }
// }
import 'package:ecollege/models/messageadm.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/wids/newscontainer.dart/ncontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Adminmsg extends StatefulWidget {
  const Adminmsg({super.key});

  @override
  State<Adminmsg> createState() => _AdminmsgState();
}

class _AdminmsgState extends State<Adminmsg> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final basic = context.read<Basicpro>();
    final admin = context.read<adminpro>();

    // Load data
    await basic.loadData1();
    admin.getfromcloudMessages();
    basic.calculatePercentage();
    basic.getStudentDetails();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    });
  }

  void _sendMessage() {
    final admin = context.read<adminpro>();
    String text = admin.adminmsgctrl.text.trim();
    if (text.isEmpty) return;

    admin.sendMessage();
    admin.adminmsgctrl.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final basic = context.watch<Basicpro>();
    final admin = context.watch<adminpro>();

    if ( basic.isLoading1) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("admin message"),),
      body: Stack(
        children: [
          // Messages list
          Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: admin.messages.length,
              itemBuilder: (context, index) {
                final msg = admin.messages[index];
                final time = admin.formatTime(msg.date);

                // Slide & fade animation
                return TweenAnimationBuilder<Offset>(
                  tween: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero),
                  duration: Duration(milliseconds: 400 + index * 50),
                  curve: Curves.easeOut,
                  builder: (context, offset, child) => Transform.translate(
                    offset: Offset(offset.dx * 200, 0),
                    child: Opacity(
                      opacity: 1 - offset.dx.abs(),
                      child: child,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: InkWell(
                      onTap: () {
                        // Optionally show full message view
                      },
                      onLongPress: () => _showMessageOptions(context, msg),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.deepPurple, Colors.black],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                time,
                                style: const TextStyle(
                                    color: Colors.white60, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input area
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, offset: Offset(0, -2), blurRadius: 6)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: admin.adminmsgctrl,
                        decoration: const InputDecoration(
                          hintText: "Type your message...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: InkWell(
                      onTap: _sendMessage,
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.deepPurple,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMessageOptions(BuildContext context, Messageadm message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Message Options"),
        content: const Text("Do you want to delete this message?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                context.read<adminpro>().deleteMsg(message);
                Navigator.pop(context);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}