import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gridview_test/EventDescPageFromAttendingList.dart';
import 'package:gridview_test/generated/FloatingButtonRow.dart';
import 'EventDescriptionPage.dart';
import 'EventFilterBar.dart';
import 'CategoriesBar.dart';
import 'SearchBar.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> stream1 =
Firestore.instance.collection('Events').snapshots();

class EventListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new StreamBuilder(
        stream: stream1,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text('Loading data... Please wait...');
          } else {
            return new GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.8 / 1,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                children:
                new List.generate(snapshot.data.documents.length, (index) {
                  return Container(
                    child: new Material(
                      child: new InkWell(
                        onTap: () => Navigator
                            .of(context)
                            .push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Detail(
                            name: snapshot.data.documents[index]
                            ['Name'],
                            pic: snapshot.data.documents[index]['url'],
                            description: snapshot.data.documents[index]
                            ['Description'],
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
                        child: new Image.network(
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
