import 'package:flutter/material.dart';

class Texty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(child: new Text('this works'));
  }
}

class MyStoreWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(assets/images/imgc1.jpg);
    var image = new Image(image: assetsImage, width: 100.0, height: 40.0, );
    return new Container(child: image);
  }
}