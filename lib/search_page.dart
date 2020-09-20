import 'package:calorie_tracker/backend.dart';
import 'package:calorie_tracker/group_view.dart';
import 'package:calorie_tracker/routes.dart';
import 'package:calorie_tracker/workout.dart';
import 'package:calorie_tracker/workout_adder.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _showResult = 0;
  static bool _joined = false;

  void _joinGroup() {
    setState(() {
      _joined = true;
    });
  }



  void _runSearch() async {
    setState(() {
      _showResult = 1;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _showResult = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> results = [
      Container(),
      Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.tealAccent),
        ),
      ),
      Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Rice Friends",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(4),
              ),
              Text(
                  "A community of friends at Rice who are interested in hackathons and exercise!"),
              FlatButton(
                child: Text(
                  _joined ? "JOINED" : "JOIN",
                  style:
                  TextStyle(color: _joined ? Colors.grey : Colors.tealAccent),
                ),
                onPressed: _joinGroup,
              )
            ],
          ),
        ),
      )
    ];
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
        title: Text("Search for groups"),
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
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GroupView()))),
            ListTile(
                leading: Icon(Icons.group),
                title: Text("Rice Friends"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GroupView())))
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Group name'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.tealAccent),
                onPressed: () {
                  _runSearch();
                },
              )
            ],
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: results[_showResult])
        ],
      ),
    );
  }
}
