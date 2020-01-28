
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadPage extends StatefulWidget {

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  TextEditingController desca = TextEditingController();
  TextEditingController tags = TextEditingController();
  File galleryImage;
  String taga = "";
  void imageupload() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      galleryImage=image;
      Fluttertoast.showToast(
        msg: "Image Selected",
        toastLength: Toast.LENGTH_SHORT,
    
    );
    });
  }
  void uploadimage()async{
    int  id = new DateTime.now().millisecondsSinceEpoch;
    int  sd = new Random().nextInt(1000000000);
    int total = id * sd;
    String t = total.toString();
    final String fileName = "${Random().nextInt(1000000000)}";

    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(galleryImage);
    Uri downloadUrl = (await uploadTask.future).downloadUrl;
    setState(() {
      taga = downloadUrl.toString();
    
    });




      Firestore.instance.collection("images").add({
      'name' : 'event1',
      'Date' : DateTime.now(),
      'tag'   : tags.text,
      'des'  : desca.text,
      'imageURL' : taga, //url hahaha
      }).then((data){
Fluttertoast.showToast(
        msg: "Successfully",
        toastLength: Toast.LENGTH_SHORT,
     
    );
   
setState(() {
   File img;
tags.text="";
desca.text="";
  galleryImage=img;
});
      }).catchError((err){
       Fluttertoast.showToast(
       msg: "you Lose :(",
        toastLength: Toast.LENGTH_SHORT,
    );
      });
  } 
  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: galleryImage != null ?  
        Image.file(galleryImage)
        :Icon(Icons.photo_album,size: 130.0,),
      ),
    );

    final desc  = TextFormField(
  
      autofocus: false,
      controller: desca,
      decoration: InputDecoration(
        hintText: 'Desc',
        contentPadding: EdgeInsets.fromLTRB(20.0,10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        ),

      ),

    );


    final tag  = TextFormField(
        
        autofocus: false,
        controller: tags,
        decoration: InputDecoration(
        hintText: 'Tag',
        contentPadding: EdgeInsets.fromLTRB(20.0,10.0, 20.0, 10.0),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0)
    ),
        ),
    );


    final uploadButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlue.shade100,
        elevation: 5.0,
        child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: imageupload,

          color: Colors.lightBlueAccent,
          child: Text('Upload', style:TextStyle(color: Colors.white)),
            ),
      ),
    );

        final cancelUpload = FlatButton(
          child: Text("Wanna Cancel Upload?", style:TextStyle(color: Colors.black54)),
          onPressed: (){
            Navigator.pop(context);
          },
        );



  
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: uploadimage,
      child: new Icon(Icons.file_upload),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0,right: 24.0),
          children: <Widget>[

            logo,
            SizedBox(height: 48.0),
            desc,
            SizedBox(height: 8.0),
            tag,
            SizedBox(height: 48.0),
            uploadButton,
            cancelUpload,
          ],
        ),
      ),
    );
  }
}
