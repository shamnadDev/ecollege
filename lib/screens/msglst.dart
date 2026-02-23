import 'package:ecollege/models/message_model.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/wids/msgvw.dart';
import 'package:ecollege/wids/newscontainer.dart/ncontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MsgListScreen extends StatefulWidget {
  const MsgListScreen({super.key});

  @override
  State<MsgListScreen> createState() => _MsgListScreenState();
}

class _MsgListScreenState extends State<MsgListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final basic = context.read<Basicpro>();
    if (basic.isLoading) {
      basic.loadData();
    }
    basic.getfromclMessages();
  }

  @override
  Widget build(BuildContext context) {
    final basic = context.watch<Basicpro>();
    final ds = basic.ds;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("College News"),
          centerTitle: true,
       backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin:AlignmentGeometry.topCenter ,
        end: AlignmentGeometry.bottomCenter,
        colors: [Colors.deepPurple,Colors.white])
          ),
          child: basic.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: ds.length,
                  itemBuilder: (context, index) {
                    final msg = ds[index];
                    final time = context.read<Basicpro>().formatTime(msg.timestamp);

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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => Msgvw(
                                  date: msg.timestamp.toString(),
                                  text: msg.text,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(0, 2),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  msg.text,
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    time,
                                    style: const TextStyle(color: Colors.black, fontSize: 12),
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
      ),
    );
  }
}