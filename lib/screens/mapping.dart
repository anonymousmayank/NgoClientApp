import 'package:flutter/material.dart';
import 'package:donations/screens/login_register.dart';
import 'profile.dart';
import 'authentication.dart';

class MappingPage extends StatefulWidget {
  final AuthImplementation auth;
  MappingPage({this.auth});
  @override
  _MappingPageState createState() => _MappingPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentUser().then((firebaseUserId) {
      setState(() {
        authStatus = firebaseUserId == null
            ? AuthStatus.notSignedIn
            : AuthStatus.signedIn;
      });
    }).catchError((onError){
        authStatus = AuthStatus.notSignedIn;
      });
  }

  void _signedIn(){
    setState(() {
      authStatus=AuthStatus.signedIn;
    });
  }
  
  void _signedOut(){
    setState(() {
      authStatus=AuthStatus.notSignedIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginRegisterPage(
          auth: widget.auth,
          onSignedIn: _signedIn
          );
      case AuthStatus.signedIn:
        return ProfilePage(
          auth: widget.auth,
          onSignedOut: _signedOut
          );
    }
    return Container();
  }
}
