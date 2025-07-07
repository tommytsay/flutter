import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JournalApp extends StatefulWidget {
  const JournalApp({super.key});

  @override
  State<JournalApp> createState() => _JournalAppState();
}

class _JournalAppState extends State<JournalApp> {
  DateTime _selectedDay = DateTime.now();
  TextEditingController _controller = TextEditingController();
  Map<String, String> _entries = {};

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesString = prefs.getString('journal_entries');
    if (entriesString != null) {
      _entries = Map<String, String>.from(
        (entriesString.isNotEmpty)
            ? Map<String, dynamic>.from(
                (entriesString.startsWith('{') && entriesString.endsWith('}'))
                    ? (entriesString.substring(1, entriesString.length - 1).isEmpty
                        ? {}
                        : Map.fromEntries(entriesString.substring(1, entriesString.length - 1).split(', ').map((e) {
                            final split = e.split(': ');
                            return MapEntry(split[0], split.sublist(1).join(': '));
                          })))
                    : {})
            : {},
      );
    }
    setState(() {
      _controller.text = _entries[_selectedDay.toIso8601String().split('T')[0]] ?? '';
    });
  }

  Future<void> _saveEntry() async {
    final prefs = await SharedPreferences.getInstance();
    _entries[_selectedDay.toIso8601String().split('T')[0]] = _controller.text;
    await prefs.setString('journal_entries', _entries.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Journal Calendar')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _controller.text = _entries[_selectedDay.toIso8601String().split('T')[0]] ?? '';
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: 'Your journal entry',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _saveEntry(),
            ),
          ),
        ],
      ),
    );
  }
}