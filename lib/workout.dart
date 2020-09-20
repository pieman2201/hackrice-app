import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateFormat dateFormatter = DateFormat("MMM d, y");
final DateFormat timeFormatter = DateFormat("h:mm a");

enum WorkoutType { aerobic, strength }

class Workout {
  WorkoutType workoutType;
  DateTime time;
  num minutes;
  num calories;

  var _workoutIconMap = {
    WorkoutType.aerobic: Icons.favorite,
    WorkoutType.strength: Icons.fitness_center
  };

  IconData get icon {
    return _workoutIconMap[workoutType];
  }

  String get dateString {
    if (time == null) {
      return "";
    }
    return dateFormatter.format(time);
  }

  String get timeString {
    if (time == null) {
      return "";
    }
    return timeFormatter.format(time);

  }

  String get dateTimeString {
    return timeString + " on " + dateString;
  }

  Workout([this.workoutType, this.time, this.minutes, this.calories]);
}

class WorkoutListItem extends StatefulWidget {
  WorkoutListItem({Key key, this.workout}) : super(key: key);

  final Workout workout;

  @override
  _WorkoutListItemState createState() => _WorkoutListItemState();
}

class _WorkoutListItemState extends State<WorkoutListItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        leading: Container(
            height: double.infinity,
            child: Icon(
              widget.workout.icon,
              color: Colors.tealAccent,
              size: 24.0,
            )),
        title: Text(
            "${widget.workout.calories} cal over ${widget.workout.minutes} min"),
        subtitle: Text(widget.workout.dateTimeString));
  }
}
