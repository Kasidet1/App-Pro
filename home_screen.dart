import 'dart:convert'; // เพิ่มการนำเข้า
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_activity_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  void _loadActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _activities = (prefs.getStringList('activities') ?? [])
          .map((activity) => jsonDecode(activity) as Map<String, dynamic>)
          .toList();
    });
  }

  void _saveActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'activities',
      _activities.map((activity) => jsonEncode(activity)).toList(),
    );
  }

  void _addActivity(String name, String note, DateTime dateTime) {
    setState(() {
      _activities.add({'name': name, 'note': note, 'dateTime': dateTime.toIso8601String()});
    });
    _saveActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: FutureBuilder<String?>(
                future: _getAccountName(),
                builder: (context, snapshot) {
                  return Text(
                    'Account: ${snapshot.data ?? ''}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          final activity = _activities[index];
          return ListTile(
            title: Text(activity['name']),
            subtitle: Text(activity['note']),
            trailing: Text(
              DateTime.parse(activity['dateTime']).toLocal().toString().split(' ')[0] +
                  " " +
                  DateTime.parse(activity['dateTime']).hour.toString().padLeft(2, '0') +
                  ":" +
                  DateTime.parse(activity['dateTime']).minute.toString().padLeft(2, '0'),
            ),
            onTap: () {
              // Add code here to view or edit the activity
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddActivityScreen(onAdd: _addActivity),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<String?> _getAccountName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accountName');
  }
}
