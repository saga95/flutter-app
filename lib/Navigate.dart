import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'WallScreen.dart' as private;
import 'activity_upload_image.dart' as upload;
import 'WallScreen2.dart' as public;
import 'full_screen_image.dart';


void main() {
  runApp(new MaterialApp(
    home: new Tabs()
  ));
}

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}
 
class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
    void initState() {
      super.initState();
      controller = new TabController(vsync: this, length: 3);
    }

    @override
      void dispose() {
        controller.dispose();
        super.dispose();
      }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Pages"), 
      backgroundColor: Colors.green,
      bottom: new TabBar(
        controller: controller,
        tabs: <Tab>[
          new Tab(icon: new Icon(Icons.file_upload) ),
          new Tab(icon: new Icon(Icons.image) ),
          new Tab(icon: new Icon(Icons.photo_library) ),
       ]
      )
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget> [
            new upload.UploadPage(),
            new private.WallScreen(),
            new public.PWallScreen(),
        ]
      ),
    );
  }
}