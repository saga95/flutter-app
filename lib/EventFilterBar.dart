import 'package:flutter/material.dart';
import 'package:gridview_test/FilterMainPage.dart';
import 'package:gridview_test/SortMainPage.dart';
import 'MapCaller.dart';

enum WhyFarther {
  NameAsc,
  NameDesc,
  DateAsc,
  DateDesc,
  ThisYear,
  ThisMonth,
}

class EventFilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: new Container(
        height: 100.0,
        color: Colors.black,
        child: new Row(
          //padding: EdgeInsets.only(bottom: 10.0),

          children: <Widget>[
            new Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 35.0),
                child: Row(
                  children: <Widget>[
                    new PopupMenuButton<WhyFarther>(
                      icon: Icon(
                        Icons.import_export,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      elevation: 10.0,
                      onSelected: (WhyFarther result) {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new SortAppMain(
                              text1: result.toString(),
                            )));
                      },
                      itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<WhyFarther>>[
                        const PopupMenuItem<WhyFarther>(
                          value: WhyFarther.NameAsc,
                          child: const Text('Name Ascending'),
                        ),
                        const PopupMenuItem<WhyFarther>(
                          value: WhyFarther.NameDesc,
                          child: const Text('Name Descending'),
                        ),
                        const PopupMenuItem<WhyFarther>(
                          value: WhyFarther.DateAsc,
                          child: const Text('Date Ascending'),
                        ),
                        const PopupMenuItem<WhyFarther>(
                          value: WhyFarther.DateDesc,
                          child: const Text('Date Descending'),
                        ),
                      ],
                    ),
                    new Text(
                      "Sort",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 30.0,
              width: 1.0,
              color: Colors.white,
              padding: const EdgeInsets.only(
                left: 0.0,
              ),
              margin: const EdgeInsets.only(top: 0.0, left: 0.0, right: 15.0),
            ),

            new Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 10.0,
                ),
                child: Container(
                  height: 100.0,
                  child: Row(
                    children: <Widget>[
                      new PopupMenuButton<WhyFarther>(
                        icon: Icon(
                          Icons.filter_list,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        elevation: 10.0,
                        onSelected: (WhyFarther result) {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new FilterAppMain(
                                text1: result.toString(),
                              )));
                        },
                        itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<WhyFarther>>[
                          const PopupMenuItem<WhyFarther>(
                            value: WhyFarther.ThisYear,
                            child: const Text('This Year'),
                          ),
                          const PopupMenuItem<WhyFarther>(
                            value: WhyFarther.ThisMonth,
                            child: const Text('This Month'),
                          ),
                        ],
                      ),
                      new Text(
                        "Filter",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              height: 30.0,
              width: 1.0,
              color: Colors.white,
              padding: const EdgeInsets.only(
                left: 0.0,
              ),
              margin: const EdgeInsets.only(top: 0.0, left: 0.0, right: 25.0),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 18.0),
              child: Row(
                children: <Widget>[
                  new IconButton(
                    icon: Icon(
                      Icons.map,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(right: 10.0),
                    onPressed: () {
                      null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Text(
                      "Map",
                      style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
