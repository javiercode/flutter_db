import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'detalle.dart';
import 'acerca.dart';
import 'home.dart';
import '../model/record.dart';

class MyMainPage extends StatefulWidget {
  @override
  MenuPage createState() {
    return MenuPage();
  }
}

class MenuPage extends State<MyMainPage> {
  int counter = 0;
  var assetsImage = new AssetImage('images/developer.jpeg');
  HomePage homePage = new HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombres de Bebes:'),
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
//             onSelected: (){
//               print('object');
//             },
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
      body: homePage.buildBody(context),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Javier'),
              accountEmail: new Text('xaviercode@mail.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage('assets/images/developer.jpeg'),
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
