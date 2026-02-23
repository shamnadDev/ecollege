import 'package:ecollege/providers/basicpro.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class des extends StatefulWidget {
  const des({super.key});

  @override
  State<des> createState() => _desState();
}

class _desState extends State<des> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: context.read<Basicpro>().msgbox.listenable(),
      builder: (context, value, child) {
        
        return Expanded(
          child: ListView.builder(
            itemCount: value.length,
            itemBuilder: (a,i){
            final a=value.keyAt(i);
            final s=value.get(a);
          
            return Text(s!.text.toString());
          }),
        );
      },
     
      ),
    );
  }
}