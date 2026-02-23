import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecollege/models/timetable.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';

class TTView extends StatefulWidget {
  const TTView({super.key});

  @override
  State<TTView> createState() => _TTViewState();
}

class _TTViewState extends State<TTView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            "Time Table",
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.black,
        ),
        body: Consumer<adminpro>(
          builder: (context, value, child) {
            if (value.subs.isEmpty) {
              return const Center(
                child: Text(
                  "No Timetable Available",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return RefreshIndicator(
              color: Colors.deepPurple,
              backgroundColor: Colors.black,
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: value.subs.length,
                itemBuilder: (context, index) {
                  final td = value.subs[index];

                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 500 + (index * 120)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, double animValue, child) {
                      return Opacity(
                        opacity: animValue,
                        child: Transform.translate(
                          offset: Offset(0, 50 * (1 - animValue)),
                          child: child,
                        ),
                      );
                    },
                    child: _premiumCard(td),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _premiumCard(Timetable td) {
    String today =
        ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
            [DateTime.now().weekday - 1];

    bool isToday = td.day.toLowerCase() == today.toLowerCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Colors.black, Colors.deepPurple],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Day Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isToday
                        ? Colors.deepPurple.withOpacity(0.5)
                        : Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      td.day.toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            isToday ? Colors.amberAccent : Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                _periodTile(Icons.looks_one, "1st Period", td.first.subjectname),
                _periodTile(Icons.looks_two, "2nd Period", td.second.subjectname),
                _periodTile(Icons.looks_3, "3rd Period", td.third.subjectname),
                _periodTile(Icons.looks_4, "4th Period", td.fourth.subjectname),
                _periodTile(Icons.looks_5, "5th Period", td.fifth.subjectname),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _periodTile(IconData icon, String title, String subject) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurpleAccent),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subject.trim().toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}