import 'package:flutter/material.dart';

class ResrvationPage extends StatefulWidget {
  @override
  _ResrvationPageState createState() => _ResrvationPageState();
}

class _ResrvationPageState extends State<ResrvationPage> {
TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

void _selectTime() async
{
  final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );

  if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
}
late String purpose;
late int studentId;
late int studentCount;
late int studyroomId;
late DateTime fromTime;
late DateTime toTime;
late DateTime date;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Add Recervation'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: 
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(),
                  ElevatedButton(
              onPressed: _selectTime,
              child: Text('SELECT TIME'),
            ),
                   Text(
              'Selected time: ${_time.format(context)}',
            ),
                ],
              )
              ),
        ),
    );
  }
}