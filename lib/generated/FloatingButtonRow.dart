import 'package:flutter/material.dart';

class FloatingButtonRow extends StatelessWidget {

  String tag1 = 'hTag1';
  String tag2 = 'hTag2';
  String tag3 = 'hTag3';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Container(
        color: Colors.teal,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new FloatingActionButton(
                child: new Icon(
                  Icons.collections, color: Colors.black, size: 30.0,
                ),
                heroTag: tag1,
                backgroundColor: Colors.transparent,
                elevation: 5.0,
                onPressed: null),
            new FloatingActionButton(
                child: new Icon(Icons.home, color: Colors.black, size: 30.0),
                heroTag: tag2,
                backgroundColor: Colors.transparent,
                elevation: 5.0,
                onPressed: null),
            new FloatingActionButton(
                child: new Icon(Icons.archive, color: Colors.black, size: 30.0),
                heroTag: tag3,
                backgroundColor: Colors.transparent,
                elevation: 5.0,
                onPressed: null),
          ],
        ),
      ),
    );
  }
}
