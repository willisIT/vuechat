import 'package:flutter/material.dart';
import 'login_page.dart';
import 'mainaccount_page.dart';
import 'auth.dart';

class RootPage extends StatefulWidget {

  final BaseAuth auth;
  //Constructor
  RootPage({this.auth});
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId){
      setState(() {
       _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn; 
      });
    });
  }

  void signedIn(){
    setState(() {
     _authStatus = AuthStatus.signedIn; 
    });
  }
  void signedOut(){
    setState(() {
     _authStatus = AuthStatus.notSignedIn; 
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(_authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: new Auth(),
          onSignedIn: signedIn,);
      case AuthStatus.signedIn:
        return new MainPage(
          auth: new Auth(),
          onSignOut: signedOut,);
    }
  }
}