import 'package:calorie_tracker/backend.dart';
import 'package:calorie_tracker/workout.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class WorkoutAdder extends StatefulWidget {
  @override
  _WorkoutAdderState createState() => _WorkoutAdderState();
}

class _WorkoutAdderState extends State<WorkoutAdder> {
  Workout _workout = Workout(WorkoutType.aerobic, DateTime.now(), 0, 0);

  void _showMinutePicker() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return NumberPickerDialog.integer(
          minValue: 0, maxValue: 720, initialIntegerValue: _workout.minutes, step: 5,);
      }
    ).then((value) {
      if (value != null) {
        setState(() {
          _workout.minutes = value;
        });
      }
    });
  }

  void _showCaloriePicker() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 0, maxValue: 2000, initialIntegerValue: _workout.calories, step: 25,);
        }
    ).then((value) {
      if (value != null) {
        setState(() {
          _workout.calories = value;
        });
      }
    });
  }

  Widget _fabThing = Icon(Icons.check);

  Future<void> _uploadWorkout() async {
    if (_workout.calories <= 0 || _workout.minutes <= 0) {
      return;
    }
    setState(() {
      _fabThing = CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black),);
    });
    await Backend().submitWorkout(_workout);
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Add a workout"),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "I worked out on",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            FlatButton(
              child: Text(
                _workout.dateString,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36.0, color: Colors.tealAccent),
              ),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now())
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _workout.time = DateTime(
                          value.year,
                          value.month,
                          value.day,
                          _workout.time.hour,
                          _workout.time.minute,
                          _workout.time.second);
                    });
                  }
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "at",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            FlatButton(
              child: Text(
                _workout.timeString,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36.0, color: Colors.tealAccent),
              ),
              onPressed: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _workout.time = DateTime(
                          _workout.time.year,
                          _workout.time.month,
                          _workout.time.day,
                          value.hour,
                          value.minute);
                    });
                  }
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "for",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            FlatButton(
              child: Text(
                _workout.minutes.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36.0, color: Colors.tealAccent),
              ),
              onPressed: _showMinutePicker,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "minutes, burning",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            FlatButton(
              child: Text(
                _workout.calories.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36.0, color: Colors.tealAccent),
              ),
              onPressed: _showCaloriePicker,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "calories by",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            IconButton(
              icon: Icon(
                _workout.icon,
                color: Colors.tealAccent,
                size: 36.0,
              ),
              onPressed: () {
                setState(() {
                  _workout.workoutType = WorkoutType.values[
                  (_workout.workoutType.index + 1) %
                      WorkoutType.values.length];
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "exercise",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: _fabThing,
        onPressed: () {
          _uploadWorkout();
        },
      ),
    );
  }
}
