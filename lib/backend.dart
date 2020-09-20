import 'dart:convert';

import 'package:calorie_tracker/workout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Backend {
  num userID = 1;

  var url = 'http://10.0.2.2:8080/';

  Future<List<Workout>> getWorkouts() async {
    var workouts = List<Workout>();

    await http.get(url + "get_workouts/$userID").then((value) {
      Iterable decoded = json.decode(value.body);
      decoded.forEach((element) {
        print(element);
        print(element['workout_type'].runtimeType);
        workouts.add(Workout(
          WorkoutType.values[int.parse(element['workout_type'])],
          DateTime.parse(element['date_time']),
          element['duration'],
          element['calories']
        ));
      });

    });
    
    workouts.sort((b, a) => a.time.compareTo(b.time));
    return workouts;
  }

  Future<Null> submitWorkout(Workout workout) async {
    http.post(url + "submit_workout",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'date_time': workout.time.toIso8601String(),
          'duration': workout.minutes.toString(),
          'calories': workout.calories.toString(),
          'workout_type': workout.workoutType.index.toString(),
          'user_id': userID.toString()
        }));
  }
}
