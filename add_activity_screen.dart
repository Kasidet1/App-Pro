import 'package:flutter/material.dart';

class AddActivityScreen extends StatefulWidget {
  final Function(String, String, DateTime) onAdd;

  AddActivityScreen({required this.onAdd});

  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _note;
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Activity'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Note'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the note';
                  }
                  return null;
                },
                onSaved: (value) {
                  _note = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date & Time'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (date != null) {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _dateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    }
                  }
                },
                validator: (value) {
                  if (_dateTime == null) {
                    return 'Please select date and time';
                  }
                  return null;
                },
                controller: TextEditingController(
                  text: _dateTime != null
                      ? "${_dateTime!.toLocal()}".split(' ')[0] +
                          " " +
                          _dateTime!.hour.toString().padLeft(2, '0') +
                          ":" +
                          _dateTime!.minute.toString().padLeft(2, '0')
                      : '',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    _formKey.currentState?.save();
                    widget.onAdd(_name!, _note!, _dateTime!);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Activity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
