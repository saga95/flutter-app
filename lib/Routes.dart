import 'package:flutter/material.dart';
import 'package:gridview_test/Loginindex.dart';
import 'package:gridview_test/Signupindex.dart';
import 'package:gridview_test/Homeindex.dart';
import 'package:gridview_test/Themestyle.dart';
import 'package:gridview_test/passwordReset.dart';


class Routes {

  var routes = <String, WidgetBuilder>{
    "/SignUp": (BuildContext context) => new SignUpScreen(),
    "/HomePage": (BuildContext context) => new HomeScreen(),
    "/pwReset": (BuildContext context) => new PasswordReset(),
    "/Login": (BuildContext context) => new LoginScreen(),


  };

  Routes() {
    runApp(new MaterialApp(
      title: "Flutter ITP App",
      home: new LoginScreen(),
      theme: appTheme,
      routes: routes,
    ));
  }
}
