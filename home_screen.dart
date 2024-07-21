import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'new_activity_screen.dart';
import 'activity_detail_screen.dart'; // อย่าลืมเพิ่มการนำเข้าหน้าจอ ActivityDetailScreen

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
          .map((activity) => json.decode(activity) as Map<String, dynamic>)
          .toList();
    });
  }

  void _saveActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('activities',
        _activities.map((activity) => json.encode(activity)).toList());
  }

  void _addActivity(String name, String note, DateTime dateTime, [int? index]) {
    setState(() {
      if (index == null) {
        _activities.add({
          'name': name,
          'note': note,
          'dateTime': dateTime.toIso8601String(),
        });
      } else {
        _activities[index] = {
          'name': name,
          'note': note,
          'dateTime': dateTime.toIso8601String(),
        };
      }
    });
    _saveActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
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
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Navigate to about screen
              },
            ),
          ],
        ),
      ),
      body: _activities.isEmpty
          ? Center(child: Text('No activities yet. Add some!'))
          : ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                final activity = _activities[index];
                final dateTime = DateTime.parse(activity['dateTime']);
                return ListTile(
                  title: Text(activity['name']),
                  subtitle: Text(activity['note']),
                  trailing: Text(
                    "${dateTime.toLocal()}".split(' ')[0] +
                        " " +
                        dateTime.hour.toString().padLeft(2, '0') +
                        ":" +
                        dateTime.minute.toString().padLeft(2, '0'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActivityDetailScreen(
                          activity: activity,
                          index: index,
                          onSave: _addActivity,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewActivityScreen(onAdd: _addActivity),
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
