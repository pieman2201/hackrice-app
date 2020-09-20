import 'package:calorie_tracker/group.dart';
import 'package:calorie_tracker/member.dart';
import 'package:flutter/material.dart';

class GroupView extends StatefulWidget {
  @override
  _GroupViewState createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  Group _group = Group("Rice Friends", List<Member>());
  static const String routeName = '/group';

  List<Widget> getLeaderboard() {}

  @override
  Widget build(BuildContext context) {
    _group.addMember(Member("Elliot Fang", 200, 105, 3));
    var _me = Member("Ishan Kamat", 150, 150, 1);
    _group.addMember(_me);
    _group.addMember(Member("Andrew Lee", 170, 120, 4));
    _group.addMember(Member("Saketh Katta", 180, 90, 2));
    _group.addMember(Member("Pranay Mittal", 90, 100, 5));
    _group.addMember(Member("Dhilan Lahoti", 10, 30, 6));

    print(_group.getAerobicPlacement(_me));
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
        title: Text(_group.name),
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
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "You're ranked",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.tealAccent,
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 32.0),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${_group.getAerobicPlacement(_me)}",
                              style: TextStyle(color: Colors.tealAccent),
                            ),
                            TextSpan(text: "/6")
                          ]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.fitness_center,
                      color: Colors.tealAccent,
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 32.0),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${_group.getStrengthPlacement(_me)}",
                              style: TextStyle(color: Colors.tealAccent),
                            ),
                            TextSpan(text: "/6")
                          ]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.swap_horizontal_circle,
                      color: Colors.tealAccent,
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 32.0),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${_group.getTotalPlacement(_me)}",
                              style: TextStyle(color: Colors.tealAccent),
                            ),
                            TextSpan(text: "/6")
                          ]),
                    )
                  ],
                )
              ],
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "Just ",
                style: TextStyle(fontSize: 18.0),
                children: <TextSpan>[
                  TextSpan(
                    text: "5",
                    style: TextStyle(color: Colors.tealAccent),
                  ),
                  TextSpan(text: " minutes behind "),
                  TextSpan(
                    text: "Elliot Fang",
                    style: TextStyle(color: Colors.tealAccent),
                  ),
                ]),
          ),
          Padding(
            padding: EdgeInsets.all(16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("minutes"),
              Switch(
                value: false,
                onChanged: (b) {},
              ),
              Text("calories"),
            ],
          ),
          Table(
            columnWidths: {
              1: FractionColumnWidth(.1),
              1: FractionColumnWidth(.5),
              2: FractionColumnWidth(.133),
              3: FractionColumnWidth(.133),
              4: FractionColumnWidth(.133)
            },
            children: <TableRow>[
              TableRow(children: <Widget>[
                Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "#",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.tealAccent),
                    )),
                Text(
                  "NAME",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.tealAccent),
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.tealAccent,
                  size: 12,
                ),
                Icon(
                  Icons.fitness_center,
                  color: Colors.tealAccent,
                  size: 12,
                ),
                Icon(
                  Icons.swap_horizontal_circle,
                  color: Colors.tealAccent,
                  size: 12,
                ),
              ])
            ]..addAll(List<TableRow>.generate(
                _group.members.length,
                (index) => TableRow(children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text((index + 1).toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 16))),
                      Text(_group.members[index].name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: _group.members[index].name == _me.name
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                      Text("${_group.members[index].aerobicMinutes}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16)),
                      Text("${_group.members[index].strengthMinutes}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16)),
                      Text("${_group.members[index].totalMinutes}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16)),
                    ]))),
          )
        ],
      ),
    );
  }
}
