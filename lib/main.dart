import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'journal_app.dart';

void main() {
  tz.initializeTimeZones();
  
   int age = 22;
 String name = 'Tommy';
 var message = '我的名字是$name，今年$age歲';
 print(message);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal Calendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const JournalApp(),
    );
  }
}
