import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';

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
      title: 'World Clock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const WorldClockPage(),
    );
  }
}

class WorldClockPage extends StatefulWidget {
  const WorldClockPage({super.key});

  @override
  State<WorldClockPage> createState() => _WorldClockPageState();
}

class _WorldClockPageState extends State<WorldClockPage> {
  late Timer _timer;
  late DateTime _nyTime;
  late DateTime _taipeiTime;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final ny = tz.getLocation('America/New_York');
    final taipei = tz.getLocation('Asia/Taipei');
    setState(() {
      _nyTime = tz.TZDateTime.now(ny);
      _taipeiTime = tz.TZDateTime.now(taipei);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('World Clock')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/clock.png', width: 100, height: 100),
            const SizedBox(height: 24),
            Text('New York Time:', style: Theme.of(context).textTheme.headlineSmall),
            Text(_formatTime(_nyTime), style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 40),
            Text('Taipei Time:', style: Theme.of(context).textTheme.headlineSmall),
            Text(_formatTime(_taipeiTime), style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}
