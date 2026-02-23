import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/wids/msgvw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Messagelist extends StatefulWidget {
  const Messagelist({super.key});

  @override
  State<Messagelist> createState() => _MessagelistState();
}

class _MessagelistState extends State<Messagelist> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<adminpro>().getfromcloudMessages();
      context.read<Basicpro>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final basic = context.watch<Basicpro>();
    final admin = context.watch<adminpro>();

    if (basic.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.deepPurple),
      );
    }

    if (admin.messages.isEmpty) {
      return const Center(
        child: Text(
          "No notices available",
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100, top: 15),
        itemCount: admin.messages.length,
        itemBuilder: (context, index) {
          final message = admin.messages[index];
          final time = admin.formatTime(message.date);

          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 400 + (index * 100)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: _feedCard(
              context,
              message.text,
              time.toString(),
              message.date.toString(),
            ),
          );
        },
      ),
    );
  }

  Widget _feedCard(
      BuildContext context, String text, String time, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Msgvw(
                date: date,
                text: text,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.12),
                Colors.white.withOpacity(0.05)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Admin Title
              const Text(
                "College Administration",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 10),

              /// Message Text
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 14),

              /// Time
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}