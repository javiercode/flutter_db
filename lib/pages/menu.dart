import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'detalle.dart';
import 'acerca.dart';
import 'grid_list.dart';
import 'home.dart';
import 'qr_page.dart';
import 'servicio_rest.dart';
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
  //HomePage homePage = new HomePage();
  DetalleRoute detallePage = new DetalleRoute();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manejo de Flutter:'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QrPage()),
              );
            },
          ),
          PopupMenuButton<Choice>(
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
      body: detallePage.build(context),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Javier'),
              accountEmail: new Text('javier.elvis.code@gmail.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage('assets/images/developer.jpeg'),
              ),
            ),
            new ListTile(
                title: new Text('Listado'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new GridListPage()));
                }
            ),
            new ListTile(
                title: new Text('Rest'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new ServicioRestPage()));
                }
            ),
            new ListTile(
                title: new Text('QR'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new QrPage()));
                }
            ),
            new ListTile(
                title: new Text('Ejemplo Firebase'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new HomePage()));
                }
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
            ),
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
