import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:ecollege/models/message_model.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/wids/newscontainer.dart/ncontainer.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final provider = context.read<Basicpro>();
     provider.getfromclMessages(); // load messages from provider
    provider.calculatePercentage();
    provider.getStudentDetails();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    });
  }

  void _sendMessage() {
    final provider = context.read<Basicpro>();
    String text = provider.msgcontroller.text.trim();
    if (text.isEmpty) return;

    provider.sendMessage();
    provider.msgcontroller.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Basicpro>();

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Message"),),
      backgroundColor: Colors.white,
          body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: provider.ds.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final msg = provider.ds[index];
                final formattedTime =
                    DateFormat('hh:mm a').format(msg.timestamp);

                // Animate each message with slide & fade
                return TweenAnimationBuilder<Offset>(
                  tween: Tween<Offset>(
                      begin: const Offset(1, 0), end: const Offset(0, 0)),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: InkWell(
                      onLongPress: () => _showMessageOptions(context, msg),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.black, Colors.deepPurple]),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(0, 2),
                                blurRadius: 4)
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg.text,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(height: 15),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                formattedTime,
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
          
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: provider.msgcontroller,
                        decoration: const InputDecoration(
                          
                            hintText: "Type your message...",
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: InkWell(
                      onTap: _sendMessage,
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showMessageOptions(BuildContext context, MessageModel message) {
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
                context.read<Basicpro>().deleteMsg(message);
                Navigator.pop(context);
              },
              child:
                  const Text("Delete", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}