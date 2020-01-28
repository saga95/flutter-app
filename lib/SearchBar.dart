import 'package:flutter/material.dart';
import 'package:gridview_test/EventSearchListMainPage.dart';
import 'package:gridview_test/SearchEventList.dart';
import 'EventListMainPage.dart';

class SearchBar extends StatelessWidget {
  String text0;

  @override
  Widget build(BuildContext context) {
    final myController = new TextEditingController();

    return Row(
      children: <Widget>[
        new Flexible(
          child: new IconButton(
              iconSize: 25.0,
              icon: Icon(Icons.search),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new EventSearchAppMain(text1: myController.text)))),
        ),
        new Flexible(
          //padding: const EdgeInsets.only(left: 0.0),

          //new IconButton(icon: Icon(Icons.search), onPressed: null),
          child: new TextField(
            controller: myController,
            autocorrect: true,
            decoration: InputDecoration(
              //filled: true,
              //fillColor: Colors.grey[300],
              /*icon: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Icon(Icons.search),
                                ),*/
              border: InputBorder.none,
              hintText: 'Search Event',
              //contentPadding: EdgeInsets.only(left: 5.0),
            ),
          ),
        ),
      ],
    );
  }
}
