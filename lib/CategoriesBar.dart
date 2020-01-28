import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gridview_test/CategorySearchMainPage.dart';
import 'package:gridview_test/EventListMainPage.dart';
import 'package:gridview_test/NewEventListMain.dart';

//CollectionReference reference = Firestore.instance.collection('Categories');

class CategoriesBar extends StatelessWidget {
  final stories = Flexible(
    child: StreamBuilder(
      stream: Firestore.instance.collection('Categories').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading data... Please wait...');
        } else {
          return Container(
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length + 1,
              itemBuilder: (context, index) => new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  new Container(
                    width: 100.0,
                    height: 90.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      image: new DecorationImage(
                        image: new AssetImage(
                            "assets/images/Event_$index.jpg"),
                        fit: BoxFit.fill,
                      ),
                      border: new Border.all(
                        color: Colors.blueAccent,
                        width: 0.0,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: new BackdropFilter(
                      filter:
                      new ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                      child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  index != 0
                      ? new Material(
                    child: new InkWell(
                      child: new Container(
                        constraints: new BoxConstraints.expand(
                            width: 100.0, height: 30.0),
                        //padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 6.0),
                        decoration: new BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          //borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: new Text(
                          snapshot.data.documents[index - 1]
                          ['Category'],
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'CroissantOne',
                          ),
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new CategorySearchAppMain(
                                  text1: snapshot.data
                                      .documents[index - 1]
                                  ['Category']))),
                      splashColor: Colors.greenAccent,
                    ),
                  )
                      : index == 0
                      ? Positioned(
                    bottom: 0.0,
                    right: 8.0,
                    child: new SizedBox(
                      height: 80.0,
                      width: 100.0,
                      child: RaisedButton(
                        color: Colors.transparent,
                        //backgroundColor: Colors.blueAccent,
                        //radius: 20.0,
                        child: new Icon(
                          Icons.add,
                          size: 35.0,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator
                            .of(context)
                            .push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new NewEventAppMain(
                              text1: '0',
                            ))),
                      ),
                    ),
                  )
                      : new Container(),
                ],
              ),
            ),
          );
        }
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: const EdgeInsets.only(right: 5.0, bottom: 5.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //topText,
          stories,
        ],
      ),
    );
  }
}
