import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

class WallScreen extends StatefulWidget {
  @override
  _WallScreenState createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 /*
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

  */


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text('Image Gallery'),
        centerTitle: true,      ),
         body:
         StreamBuilder(
          stream: Firestore.instance.collection('images').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return new StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 10.0),
           
      itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                 String imgPath = ds['imageURL'];
                 return new Padding(
                 padding: EdgeInsets.all(3.0),
                  child:  Material(
                  type: MaterialType.card,
                  
                  shadowColor: Colors.indigo[50],
                  elevation: 8.0,
                  borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
                  child: new InkWell(
                   onTap: (){
                     showDialog(
                       context: context,
                       builder: (BuildContext context)=> new AlertDialog(
                         title: new Text(ds['name']),
                         content: new Text("Delete image ?"),
                      actions: <Widget>[
                           FlatButton(
                             color: Colors.greenAccent,
                             child: new Text("No"),
                             onPressed: (){
                               Navigator.pop(context);
                             },
                           ),
                            FlatButton(
                             child: new Text("Yes"),
                             onPressed: (){
                    Firestore.instance.collection("images").document(ds.documentID).delete().then((data){
                   Navigator.pop(context);//WOOWW BRAVOOOO hahahahahah
                      });

                             },
                           )
                         ],
                       )
                     );
                   },
                    child: new Hero(
                       tag: imgPath,
                      child: new FadeInImage(
                         image: new NetworkImage(imgPath),
                         fit: BoxFit.cover,
                        placeholder: new AssetImage("assets/wallpaper1.jpg") ,
                      ),
                    ),
                  ),
                ),
                );
              },
  staggeredTileBuilder: (int index) =>
      new StaggeredTile.count(2, index.isEven ? 2 : 3.3), //3?yes ok???? finish yes nice
  mainAxisSpacing: 4.0,
  crossAxisSpacing: 4.0,
);
          }),
    );
  }
}


//
/* man wait what r u doin wait 1 min i will fix ur issue 
return new Scaffold(
      appBar:  new AppBar(title: new Text("AppBar"),
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
                    child: new Hero(
                      tag: imgPath,
                      child: new FadeInImage(
                         image: new NetworkImage(imgPath),
                         fit: BoxFit.cover,
                        placeholder: new AssetImage("assets/wallpaper1.jpg") ,
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

 */



