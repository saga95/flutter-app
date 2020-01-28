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

class FilterAppMain extends StatelessWidget {
  String text1;

  FilterAppMain({this.text1});

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
            "Event List",
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
              flex: 11,
            ),
            new Flexible(
              child: new EventFilterBar(),
              flex: 6,
            ),
            new Flexible(
              flex: 51,
              child: new FilterApp(text4: text3),
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

class FilterApp extends StatelessWidget {
  String text4;

  FilterApp({this.text4});

  String lowerLimit, upperLimit;

  @override
  Widget build(BuildContext context) {
    switch (text4) {
      case 'WhyFarther.ThisYear':
        {
          String nowYear = new DateTime.now().year.toString();
          lowerLimit = '$nowYear/01/01';
          upperLimit = '$nowYear/12/31';
        }
        break;
      case 'WhyFarther.ThisMonth':
        {
          String nowYear = new DateTime.now().year.toString();
          String nowMonth = new DateTime.now().month.toString();

          switch (nowMonth) {
            case '1':
              {
                lowerLimit = '$nowYear/01/01';
                upperLimit = '$nowYear/01/31';
              }
              break;
            case '2':
              {
                lowerLimit = '$nowYear/02/01';
                upperLimit = '$nowYear/02/28';
              }
              break;
            case '3':
              {
                lowerLimit = '$nowYear/03/01';
                upperLimit = '$nowYear/03/31';
              }
              break;
            case '4':
              {
                lowerLimit = '$nowYear/04/01';
                upperLimit = '$nowYear/04/30';
              }
              break;
            case '5':
              {
                lowerLimit = '$nowYear/05/01';
                upperLimit = '$nowYear/05/31';
              }
              break;
            case '6':
              {
                lowerLimit = '$nowYear/06/01';
                upperLimit = '$nowYear/06/30';
              }
              break;
            case '7':
              {
                lowerLimit = '$nowYear/07/01';
                upperLimit = '$nowYear/07/31';
              }
              break;
            case '8':
              {
                lowerLimit = '$nowYear/08/01';
                upperLimit = '$nowYear/08/31';
              }
              break;
            case '9':
              {
                lowerLimit = '$nowYear/09/01';
                upperLimit = '$nowYear/09/30';
              }
              break;
            case '10':
              {
                lowerLimit = '$nowYear/10/01';
                upperLimit = '$nowYear/10/31';
              }
              break;
            case '11':
              {
                lowerLimit = '$nowYear/11/01';
                upperLimit = '$nowYear/11/30';
              }
              break;
            case '12':
              {
                lowerLimit = '$nowYear/12/01';
                upperLimit = '$nowYear/12/31';
              }
              break;
          }
        }
    }

    // TODO: implement build
    return new Container(
      child: new StreamBuilder(
        stream: Firestore.instance
            .collection('Events')
            .where('Date', isGreaterThanOrEqualTo: '$lowerLimit')
            .where('Date', isLessThanOrEqualTo: '$upperLimit')
            .snapshots(),
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
                List.generate(snapshot.data.documents.length, (index) {
                  return new Container(
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
