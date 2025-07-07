import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'journal_app.dart';

void main() {
  tz.initializeTimeZones();
  
 String name = 'Tommy';
 var message = 'My name is $name';
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
