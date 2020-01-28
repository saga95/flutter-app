import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gridview_test/EventList.dart';
import 'package:gridview_test/generated/FloatingButtonRow.dart';
import 'package:gridview_test/testCatBar.dart';
import 'EventDescriptionPage.dart';
import 'EventFilterBar.dart';
import 'CategoriesBar.dart';
import 'SearchBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'SearchBar.dart';

class EventApp extends StatelessWidget {
  EventApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Event List',
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ******************* ENTIRE GRID VIEW ***********************

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
          title: new Text(
            "Public Events",
            style: new TextStyle(color: Colors.white),
          )),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: SearchBar(),
            flex: 5,
          ),
          new Flexible(
            child: CategoriesBar(),
            flex: 11,
          ),
          new Flexible(
            child: EventFilterBar(),
            flex: 6,
          ),
          new Flexible(
            flex: 51,
            child: EventListApp(),
          ),
          new Flexible(
            flex: 6,
            child: FloatingButtonRow(),
          ),
        ],
      ),
    );
  }
}

// ************* END OF GRID VIEW PART ***********************************
