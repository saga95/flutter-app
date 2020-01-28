import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gridview_test/EventList.dart';
import 'package:gridview_test/SearchEventList.dart';
import 'package:gridview_test/generated/FloatingButtonRow.dart';
import 'package:gridview_test/testCatBar.dart';
import 'EventDescriptionPage.dart';
import 'EventFilterBar.dart';
import 'CategoriesBar.dart';
import 'SearchBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'SearchBar.dart';

class EventSearchAppMain extends StatelessWidget {
  String text1;

  EventSearchAppMain({this.text1});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Event List',
      home: new Home(
        text2: text1,
      ),
    );
  }
}

class Home extends StatefulWidget {
  String text2;

  Home({this.text2});

  @override
  _HomeState createState() => _HomeState(text3: text2);
}

class _HomeState extends State<Home> {
  String text3;

  _HomeState({this.text3});

  // ******************* ENTIRE GRID VIEW ***********************

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
          title: new Text(
            "Search Results for: '$text3'",
            style: new TextStyle(color: Colors.white),
          )),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new SearchBar(),
              flex: 5,
            ),
            new Flexible(
              child: new CategoriesBar(),
              flex: 10,
            ),
            new Flexible(
              child: new EventFilterBar(),
              flex: 5,
            ),
            new Flexible(
              flex: 51,
              child: EventSearchApp(text4: text3),
            ),
            new Flexible(
              flex: 6,
              child: FloatingButtonRow(),
            ),
          ],
        ),
      ),
    );
  }
}

// ************* END OF GRID VIEW PART ***********************************

class EventSearchApp extends StatelessWidget {
  String text4;

  EventSearchApp({this.text4});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new StreamBuilder(
        stream: Firestore.instance
            .collection('Events')
            .where('Name', isEqualTo: '$text4')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading data... Please wait...');
          } else {
            return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.8 / 1,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                children:
                List.generate(snapshot.data.documents.length, (index) {
                  return Container(
                    child: new Material(
                      child: InkWell(
                        onTap: () => Navigator
                            .of(context)
                            .push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Detail(
                            name: snapshot.data.documents[index]
                            ['Name'],
                            pic: snapshot.data.documents[index]['url'],
                            description: snapshot.data.documents[index]
                            ['ImgName'],
                            latitude: snapshot.data.documents[index]
                            ['Latitude'],
                            longitude: snapshot.data.documents[index]
                            ['Longitude'],
                            hostDesc: snapshot.data.documents[index]
                            ['HostDesc'],
                            venueDesc: snapshot.data.documents[index]
                            ['VenueDesc'],
                          ),
                        )),
                        child: Image.network(
                          snapshot.data.documents[index]['url'],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                }));
          }
        },
      ),
    );
  }
}
