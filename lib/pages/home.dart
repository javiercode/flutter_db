import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'detalle.dart';
import 'acerca.dart';
import '../model/record.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => new _HomePage();
}


class _HomePage extends State<HomePage>{
  int counter = 0;
  var assetsImage = new AssetImage('images/developer.jpeg');

  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Fire Base'),
      ),
      body: buildBody(context),
      floatingActionButton: new FloatingActionButton(
        onPressed:(){
          showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                title: new Text("Dialog Title"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, we want to show a Snackbar
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
            )
          );
        },
        tooltip: '',
        child: new Icon(Icons.add_box),
      ),
//      body: null,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
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
          title: Text(record.name+"\nSexo:"+record.sexo),
          onTap: () => print(record.sexo),
          // subtitle: Text(record.sexo),
          subtitle: Text("Votos:\n"+record.votes.toString()),
          leading: const Icon(Icons.person),
          trailing: MaterialButton(
            child: new Icon(Icons.plus_one),
            color: Colors.blueAccent,
            //onPressed: ()=> record.reference.updateData({'votes': record.votes + 1}),
            onPressed: ()=> Firestore.instance.runTransaction((transaction) async {
              final freshSnapshot = await transaction.get(record.reference);
              final fresh = Record.fromSnapshot(freshSnapshot);
              await transaction.update(record.reference, {'votes': fresh.votes + 1});
            }) 
          ),
        ),
        width: 20,
      ),
    );
  }

  void increment() {
//    setState(() {
      ++counter;
//    });
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
