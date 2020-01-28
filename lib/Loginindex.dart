import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gridview_test/Themestyle.dart';
import 'Loginstyle.dart';
import 'package:gridview_test/inputField.dart';
import 'package:gridview_test/textButton.dart';
import 'package:gridview_test/roundedButton.dart';
import 'package:gridview_test/validations.dart';
import 'package:gridview_test/authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {



  const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => new LoginScreenState();
}


class LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseAuth> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    Navigator.pushNamed(context, "/HomePage");

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print("Username: ${user.displayName}");


  }

  void _signOut(){
    googleSignIn.signOut();
    showInSnackBar('Signed Out');

  }
  void _resetPw(){
    _auth.sendPasswordResetEmail(email: "ymsperera@gmail.com");
    showInSnackBar('Password Reset Email Sent');

  }

  BuildContext context;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = new ScrollController();
  UserData user = new UserData();
  UserAuth userAuth = new UserAuth();
  bool autovalidate = false;
  Validations validations = new Validations();

  _onPressed(String s) {
    print("button clicked");
  }

  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _handleSubmitted() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors above.');
    } else {
      form.save();
      showInSnackBar('Hold Tight.. We Are Validating You');
      showInSnackBar('Invalid! Please Check your Credentials');


      userAuth.verifyUser(user).then((onValue) {
        if (onValue == "Login Successfull")
          Navigator.pushNamed(context, "/HomePage");
        else
          showInSnackBar(onValue);

      }).catchError((PlatformException onError) {
        showInSnackBar(onError.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final Size screenSize = MediaQuery.of(context).size;
    //print(context.widget.toString());
    Validations validations = new Validations();
    return new Scaffold(
        key: _scaffoldKey,
        body: new SingleChildScrollView(
            controller: scrollController,
            child: new Container(
              padding: new EdgeInsets.all(16.0),
              decoration: new BoxDecoration(image: backgroundImage),
              child: new Column(
                children: <Widget>[
                  new Container(
                    height: screenSize.height / 3,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Center(
                            child: new Image(
                              image: logo,
                              width: (screenSize.width < 500)
                                  ? 120.0
                                  : (screenSize.width / 4) + 12.0,
                              height: screenSize.height / 4 + 20,
                            ))
                      ],
                    ),
                  ),
                  new Container(
                    height: screenSize.height / 1.5,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Form(
                          key: formKey,
                          autovalidate: autovalidate,
                          child: new Column(
                            children: <Widget>[
                              new InputField(
                                  hintText: "Email",
                                  obscureText: false,
                                  textInputType: TextInputType.text,
                                  textStyle: textStyle,
                                  textFieldColor: textFieldColor,
                                  icon: Icons.mail_outline,
                                  iconColor: Colors.white,
                                  bottomMargin: 20.0,
                                  validateFunction: validations.validateEmail,
                                  onSaved: (String email) {
                                    user.email = email;
                                  }),
                              new InputField(
                                  hintText: "Password",
                                  obscureText: true,
                                  textInputType: TextInputType.text,
                                  textStyle: textStyle,
                                  textFieldColor: textFieldColor,
                                  icon: Icons.lock_open,
                                  iconColor: Colors.white,
                                  bottomMargin: 40.0,
                                  validateFunction:
                                  validations.validatePassword,
                                  onSaved: (String password) {
                                    user.password = password;
                                  }),
                              new RoundedButton(
                                buttonName: "Login",
                                onTap: _handleSubmitted,
                                width: screenSize.width/ 1.2,
                                height: 50.0,
                                bottomMargin: 10.0,
                                borderWidth: 0.0,
                                buttonColor: primaryColor,
                              ),
                              new RoundedButton(
                                buttonName: "Google",
                                onTap: _signIn ,
                                width: screenSize.width/1.2,
                                height: 50.0,
                                bottomMargin: 50.0,
                                borderWidth: 1.0,
                                buttonColor: googleButton,
                                textColor:primaryColor,
                              ),
                            ],
                          ),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new TextButton(
                                buttonName: "Create Account",
                                onPressed: () => onPressed("/SignUp"),
                                buttonTextStyle: buttonTextStyle),
                            new TextButton(
                                buttonName: "Forgot Password?",
                                onPressed: () => onPressed("/pwReset"),
                                buttonTextStyle: buttonTextStyle)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
