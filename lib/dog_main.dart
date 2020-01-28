import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gridview_test/dog_list.dart';
import 'package:gridview_test/dog_model.dart';
import 'package:gridview_test/new_dog_form.dart';

void main() {
  runApp(new DogApp());
}

class DogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Add Your Card',
      theme: new ThemeData(brightness: Brightness.dark),
      home: new MyHomePage(title: 'Add Your Card'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var initialDoggos = <Dog>[]
    ..add(new Dog('Sampath Bank', '4521365987523654', '04/21',))
    ..add(new Dog('Commercial Bank', '5245125865482369','05/22'));

  Future<Null> _showNewDogForm() async {
    Dog newDog = await Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new AddDogFormPage();
        },
      ),
    );
    if (newDog != null) {
      initialDoggos.add(newDog);
    }
  }

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        backgroundColor: Colors.black87,
        title: new Text(widget.title),
        actions: [
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: () => _showNewDogForm(),
          ),
        ],
      ),
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo[800],
              Colors.indigo[700],
              Colors.indigo[600],
              Colors.indigo[400],
            ],
          ),
        ),
        child: new Center(
          child: new DogList(initialDoggos),
        ),
      ),
    );
  }
}
