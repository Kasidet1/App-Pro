import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'new_activity_screen.dart';
import 'activity_detail_screen.dart';

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
      if (index != null) {
        // Update existing activity
        _activities[index] = {
          'name': name,
          'note': note,
          'dateTime': dateTime.toIso8601String(),
        };
      } else {
        // Add new activity
        _activities.add({
          'name': name,
          'note': note,
          'dateTime': dateTime.toIso8601String(),
        });
      }
    });
    _saveActivities();
  }

  void _deleteActivity(int index) {
    setState(() {
      _activities.removeAt(index);
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
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.account_circle, color: Colors.white, size: 40),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: Text('About'),
                  onTap: () {
                    // Navigate to about screen
                  },
                ),
              ],
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
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
                return Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
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
                            onDelete: _deleteActivity,
                          ),
                        ),
                      );
                    },
                  ),
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
