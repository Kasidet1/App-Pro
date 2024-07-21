import 'package:flutter/material.dart';

class ActivityDetailScreen extends StatefulWidget {
  final Map<String, dynamic> activity;
  final int index;
  final Function(String, String, DateTime, int) onSave;

  ActivityDetailScreen({required this.activity, required this.index, required this.onSave});

  @override
  _ActivityDetailScreenState createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _noteController;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.activity['name']);
    _noteController = TextEditingController(text: widget.activity['note']);
    _dateTime = DateTime.parse(widget.activity['dateTime']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Note'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave(
                  _nameController.text,
                  _noteController.text,
                  _dateTime,
                  widget.index,
                );
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
