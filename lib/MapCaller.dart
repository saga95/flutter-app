import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gridview_test/NewEventAppMainFromMap.dart';
import 'package:gridview_test/NewEventListMain.dart';
import 'package:latlong/latlong.dart';
import 'EventListMainPage.dart';

void mapCall({double lat, double long}) =>
    runApp(new MapApp(lat: lat, long: long));

class MapApp extends StatelessWidget {
  double lat, long;

  MapApp({this.lat, this.long});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyMapPage(lat: lat, long: long),
    );
  }
}

class MyMapPage extends StatefulWidget {
  double lat, long;

  MyMapPage({this.lat, this.long});

  @override
  _MyMapPageState createState() => new _MyMapPageState(lat: lat, long: long);
}

class _MyMapPageState extends State<MyMapPage> {
  double lat, long;

  _MyMapPageState({this.lat, this.long});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new NewEventAppMainFromMap(text1: '0')))),
            title: new Text('Event Maps')),
        body: new FlutterMap(
          options: new MapOptions(center: new LatLng(lat, long), minZoom: 10.0),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(markers: [
              new Marker(
                  width: 45.0,
                  height: 45.0,
                  point: new LatLng(lat, long),
                  builder: (context) => new Container(
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 45.0,
                      onPressed: () {
                        print('Marker tapped');
                      },
                    ),
                  ))
            ]),
          ],
        ));
  }
}
