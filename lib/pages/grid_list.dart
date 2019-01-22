import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridListPage extends StatefulWidget {
  @override
  _GridListState createState() => new _GridListState();
}

class _GridListState extends State<GridListPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('About Page'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 250.0,
              color: Colors.red,
            ),
            Container(
              width: 250.0,
              color: Colors.blue,
            ),
            Container(
              width: 250.0,
              color: Colors.green,
            ),
            Container(
              width: 250.0,
              color: Colors.yellow,
            ),
            Container(
              width: 250.0,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}


//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final title = 'Grid List';
//
//    return MaterialApp(
//      title: title,
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text(title),
//        ),
//        body: GridView.count(
//          // Create a grid with 2 columns. If you change the scrollDirection to
//          // horizontal, this would produce 2 rows.
//          crossAxisCount: 2,
//          // Generate 100 Widgets that display their index in the List
//          children: List.generate(100, (index) {
//            return Center(
//              child: Text(
//                'Item $index',
//                style: Theme.of(context).textTheme.headline,
//              ),
//            );
//          }),
//        ),
//      ),
//    );
//  }
//}