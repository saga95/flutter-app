import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gridview_test/EventListMainPage.dart';
import 'package:gridview_test/EventList.dart';
import 'package:gridview_test/NewEventAppMainFromMap.dart';
import 'package:gridview_test/NewEventListMain.dart';
import 'package:path/path.dart';
import 'main.dart';
import 'MapCaller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'EventListMainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final String currentUser = auth.currentUser().toString();


class Detail extends StatelessWidget {
  Detail(
      {this.name,
        this.pic,
        this.description,
        this.latitude,
        this.longitude,
        this.hostDesc,
        this.venueDesc});

  final String name;
  final String pic;
  final String description;
  final String hostDesc;
  final String venueDesc;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 400.0,
            child: new SingleChildScrollView(
              child: new Hero(
                tag: name,
                child: new Material(
                  child: new InkWell(
                    child: new Image.network(
                      "$pic",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          new EventName(
            name: name,
          ),
          new Divider(
            height: 0.0,
            indent: 0.0,
            color: Colors.blue,
          ),
          new EventIcon(lat: latitude, long: longitude),
          new Divider(
            height: 0.0,
            indent: 0.0,
            color: Colors.blue,
          ),
          new EventDescription(
            description: description,
            hostDesc: hostDesc,
            venueDesc: venueDesc,
          ),
          new ResponseButton(EventName: name, ImgURL: pic),
        ],
      ),
    );
  }
}

class EventName extends StatelessWidget {
  EventName({this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  name,
                  style: new TextStyle(
                      fontFamily: 'CroissantOne',
                      fontSize: 30.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

          /*new Row(
            children: <Widget>[
              new Icon(
                Icons.star,
                size: 50.0,
                color: Colors.red,
              ),
              new Text(
                "12",
                style: new TextStyle(fontSize: 18.0),
              )
            ],
          )*/
        ],
      ),
    );
  }
}

class EventIcon extends StatelessWidget {
  double lat, long;

  EventIcon({this.lat, this.long});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
      child: new Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, left: 30.0),
                child: new IconButton(
                  icon: Icon(
                    Icons.call,
                    size: 35.0,
                  ),
                  onPressed: _launchURL_call,
                  //teks: "Call",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: new Text(
                  "Call",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CroissantOne'),
                ),
              ),
            ],
          ),
          Container(
            height: 70.0,
            width: 1.0,
            color: Colors.black54,
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            margin: const EdgeInsets.only(top: 5.0, left: 40.0),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, left: 40.0),
                child: new IconButton(
                  icon: Icon(
                    Icons.message,
                    size: 35.0,
                  ),
                  onPressed: _launchURL_msg,
                  //teks: "Message",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: new Text(
                  "Message",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CroissantOne'),
                ),
              ),
            ],
          ),
          Container(
            height: 70.0,
            width: 1.0,
            color: Colors.black54,
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            margin: const EdgeInsets.only(top: 5.0, left: 40.0),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, left: 35.0),
                child: new IconButton(
                  icon: Icon(
                    Icons.map,
                    size: 35.0,
                  ),
                  onPressed: () {
                    mapCall(lat: lat, long: long);
                  },

                  //teks: "Venue",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: new Text(
                  "Venue",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CroissantOne'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Iconteks extends StatelessWidget {
  Iconteks({this.icon, this.teks});
  final IconData icon;
  final String teks;
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Icon(
              icon,
              size: 50.0,
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: new Text(
                teks,
                style: new TextStyle(fontSize: 18.0, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventDescription extends StatelessWidget {
  EventDescription({this.description, this.hostDesc, this.venueDesc});
  final String description;
  final String venueDesc;
  final String hostDesc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: new Text(
            "Event",
            style: new TextStyle(
                fontSize: 30.0,
                fontFamily: 'CroissantOne',
                letterSpacing: 4.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new SizedBox(
            width: 400.0,
            //padding: new EdgeInsets.all(10.0),
            child: new Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                  description,
                  style:
                  new TextStyle(fontSize: 18.0, fontFamily: 'CroissantOne'),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: new Text(
            "Venue",
            style: new TextStyle(
                fontSize: 30.0,
                fontFamily: 'CroissantOne',
                letterSpacing: 4.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new SizedBox(
            width: 400.0,
            //padding: new EdgeInsets.all(10.0),
            child: new Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                  venueDesc,
                  style:
                  new TextStyle(fontSize: 18.0, fontFamily: 'CroissantOne'),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: new Text(
            "Your Host",
            style: new TextStyle(
                fontSize: 30.0,
                fontFamily: 'CroissantOne',
                letterSpacing: 4.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new SizedBox(
            width: 400.0,
            //padding: new EdgeInsets.all(10.0),
            child: new Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                  hostDesc,
                  style:
                  new TextStyle(fontSize: 18.0, fontFamily: 'CroissantOne'),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ResponseButton extends StatelessWidget {
  ResponseButton({this.EventName, this.ImgURL});

  final String EventName, ImgURL;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        new Expanded(
          child: new RaisedButton(
            elevation: 4.0,
            padding: EdgeInsets.all(10.0),
            color: Colors.green,
            splashColor: Colors.greenAccent,
            child: const Text(
              "I'm in",
              style: TextStyle(
                  fontFamily: 'CroissantOne',
                  color: Colors.black87,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () => _addEventToGoing(EventName, ImgURL, context),
          ),
        ),
        new Expanded(
          child: new RaisedButton(
            elevation: 4.0,
            padding: EdgeInsets.all(10.0),
            color: Colors.redAccent,
            splashColor: Colors.blueAccent,
            disabledColor: Colors.redAccent,
            child: Text(
              "Not Interested",
              style: TextStyle(
                  fontFamily: 'CroissantOne',
                  color: Colors.black87,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.of(context).pop(context),
          ),
        ),
      ],
    );
  }
}

_launchURL_call() async {
  const url = 'tel:+1 555 010 999';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL_msg() async {
  const url = 'sms:5550101234';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _addEventToGoing(String Eventname, String ImgUrl, BuildContext context) {
  Map<String, String> data = <String, String>{
    "EventName": "$Eventname",
    "url": "$ImgUrl"
  };

  Firestore.instance
      .document("Users/$currentUser/AttendingEvents/$Eventname")
      .setData(data)
      .whenComplete(() {
    print("Document Added");
  }).catchError((e) => print(e));

  Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new NewEventAppMain()));
}

//-----------------------MAP PART--------------------------------------------------

void mapCallDescPage({double lat, double long}) =>
    runApp(new MapAppDescPage(lat: lat, long: long));

class MapAppDescPage extends StatelessWidget {
  double lat, long;

  MapAppDescPage({this.lat, this.long});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyMapPage(lat: lat, long: long),
    );
  }
}

class MyMapPageDescPage extends StatefulWidget {
  double lat, long;

  MyMapPageDescPage({this.lat, this.long});

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
                        builder: (BuildContext context) =>
                        new NewEventAppMainFromMap(text1: '0')))),
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
