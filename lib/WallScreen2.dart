import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async';
import 'full_screen_image.dart';



class PWallScreen extends StatefulWidget {
  @override
  _PWallScreenState createState() => _PWallScreenState();
}

class _PWallScreenState extends State<PWallScreen> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference =
  Firestore.instance.collection("images");



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar:  new AppBar(title: new Text("Image Feed"), backgroundColor: Colors.transparent,
      ),
      body: wallpapersList != null?
          new StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: 4,
              itemCount: wallpapersList.length,
              itemBuilder: (context,i){
                String imgPath = wallpapersList[i].data['imageURL'];
                return new Material(
                  elevation: 8.0,
                  borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
                   child: new InkWell(
                     onTap: () => Navigator.push(context, new MaterialPageRoute(
                       builder: (context) => new FullScreenImagePage(imgPath)

                     )),
                    child: new Hero(
                      tag: imgPath,
                      child: new FadeInImage(
                         image: new NetworkImage(imgPath),
                         fit: BoxFit.cover,
                        placeholder: new AssetImage("assets/loading.png") ,
                      ),
                    ),
                  ),
                );
              },

            staggeredTileBuilder: (i) => new StaggeredTile.count(2, i.isEven? 2:3),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,

          ): new Center(
        child: new CircularProgressIndicator(),
      )
    );
  }
}







