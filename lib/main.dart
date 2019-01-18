import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'pages/detalle.dart';
import 'pages/acerca.dart';
import 'dart:io';


void main() => runApp(MyApp());

final dummySnapshot = [
  {"name": "Filip", "votes": 15},
  {"name": "Abraham", "votes": 14},
  {"name": "Richard", "votes": 11},
  {"name": "Ike", "votes": 10},
  {"name": "Justin", "votes": 1},
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nombres de bebes',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombres de bebes -> votados '),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetalleRoute()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_active),
            onPressed: (){
              print('Icons.phone');
            },
          ),
          PopupMenuButton<Choice>(
              // onSelected: (){
              //   print('object')
              // },
              itemBuilder: (BuildContext context) {
                return choices.skip(2).map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            )
        ],
        ),
      body: _buildBody(context),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Javier'),
              accountEmail: new Text('xaviercode@mail.com'),
              currentAccountPicture: new CircleAvatar(
//                backgroundImage: new AssetImage("assets/images/developer.jepg"),
              ),
            ),
            new ListTile(
              title: new Text('Acerca de'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              }
            )
          ],
        ),
      ),
    );
  }

//  Widget _buildBody(BuildContext context) {
//    // TODO: get actual snapshot from Cloud Firestore
//    return _buildList(context, dummySnapshot);
//  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          onTap: () => print(record.name),
          // subtitle: Text(record.sexo),
          subtitle: Text("Votos:\n"+record.votes.toString()),
          leading: const Icon(Icons.person),
          trailing: MaterialButton(
            child: Text(record.sexo),
            color: Colors.blueAccent,
            onPressed: increment,),
        ),
        width: 20,
      ),
    );
  }

  void increment() {
    setState(() {
      ++counter;
    });
    print(counter);
  }
}
class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const Choice(title: 'Boat', icon: Icons.directions_boat),
  const Choice(title: 'Bus', icon: Icons.directions_bus),
  const Choice(title: 'Train', icon: Icons.directions_railway),
  const Choice(title: 'Walk', icon: Icons.directions_walk),
];

class Record {
  final String name;
  final String sexo;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        assert(map['sexo'] != null),
        name = map['name'],
        votes = map['votes'],
        sexo = map['sexo'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}