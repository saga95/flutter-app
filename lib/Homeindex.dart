import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';





class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key key }) : super(key: key);

  @override
  HomeScreenState createState() => new HomeScreenState();


}
class HomeScreenState extends State<HomeScreen>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _signOut() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(body:new Center(
      child: new Column(
          children: <Widget>[
        new RaisedButton(
          child: const Text('Sign Out'),
          color: Theme.of(context).accentColor,
          elevation: 4.0,
          splashColor: Colors.blueGrey,
          onPressed:() => onPress("/Login") ,
        ),

        new RaisedButton(
          child: const Text('Delete User'),
          color: Theme.of(context).accentColor,
          elevation: 4.0,
          splashColor: Colors.blueGrey,
          onPressed: () => onPress("/Login"),

        )

  ])));
  }


  onPress(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

}