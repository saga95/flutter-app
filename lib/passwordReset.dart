import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final textController = new TextEditingController();
void _resetPw(String remail){

  _auth.sendPasswordResetEmail(email: remail);
  
  print(remail);


}

class PasswordReset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Password Reset',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Password Reset'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();

  String rEmail;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        labelText: 'Email:'
                    ),
                    validator: (input) =>
                    !input.contains('@')
                        ? 'Not a valid Email'
                        : null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(

                          onPressed: () {
                            rEmail = textController.text;
                            print(rEmail);
                            _resetPw(rEmail);
                            },
                          child: Text('Reset'),


                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}