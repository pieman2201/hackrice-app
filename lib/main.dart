import 'package:calorie_tracker/backend.dart';
import 'package:calorie_tracker/group_view.dart';
import 'package:calorie_tracker/routes.dart';
import 'package:calorie_tracker/search_page.dart';
import 'package:calorie_tracker/workout.dart';
import 'package:calorie_tracker/workout_adder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitBoard',
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.teal),
      home: MyHomePage(title: 'FitBoard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const String routeName = '/home';

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  /*List<Workout> _workouts = [
    Workout(WorkoutType.strength, DateTime.parse("2012-02-27 13:27:00"),
        19, 127),
    Workout(WorkoutType.aerobic, DateTime.parse("2012-03-12 23:40:00"),
        21, 50),
  ];*/
  List<Workout> _workouts = List<Workout>();

  void _addWorkout() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorkoutAdder()));
    await _getWorkouts();
  }

  Future<void> _getWorkouts() async {
    _refreshIndicatorKey.currentState?.show();
    _workouts = await Backend().getWorkouts();
    await Future.delayed(Duration(seconds: 3));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: Text(
                "FitBoard",
                style: TextStyle(color: Colors.tealAccent),
              )),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
            ListTile(
              leading: Icon(Icons.search),
                title: Text("Search"),
                onTap: () =>
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SearchPage()))
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: List<WorkoutListItem>.generate(
              _workouts.length,
              (index) => WorkoutListItem(
                    workout: _workouts[index],
                  )),
        ),
        onRefresh: _getWorkouts,
        key: _refreshIndicatorKey,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addWorkout,
        tooltip: 'Add workout',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
