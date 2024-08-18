import 'package:flutter/material.dart';
import 'new_activity_screen.dart';

class ActivitiesScreen extends StatelessWidget {
  // Callback function to handle adding a new activity
  void _addActivity(String title, String description, DateTime date) {
    // Handle the new activity here (e.g., update a list of activities)
    print('Activity added: $title, $description, $date');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Working'),
            subtitle: Text(
                'Doing things, doing homework, building applications. Deadline: 8:00 a.m. 2019/7/20'),
          ),
          // Add more ListTile widgets for more activities
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewActivityScreen(
                onAdd: _addActivity,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
