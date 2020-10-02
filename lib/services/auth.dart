// import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gescolar_dev/models/user.dart';
import 'package:gescolar_dev/widgets/Google/secureStorage.dart';
// import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final storage = SecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final dominio = 'lreginaldofischione.edu.co';
  // auth change user strem
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromUser);
  }

  // create user obj based on User
  User _userFromUser(User user) {
    return user != null ? user : null;
  }

  // sign in with google
  Future googleloginUSer() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var email = googleUser.email; //"tony@starkindustries.com";
      var domain = email.split("@");
      print('domain: ' + domain[1]);
      if (domain[1] == dominio) {
        final User user = (await _auth.signInWithCredential(credential)).user;
        print("signed in " + user.displayName);
        return user;
      } else {
        _googleSignIn.signOut();
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /* _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
            builder: (context,sett){
              void _showSearchReturn(String query) async{
              }
              return AlertDialog(
                title: Text('Usuario invalido'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('El email del usuario debe pertenecer al dominio '+ dominio),
                      // Text('Would you like to approve of this message?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Approve'),
                    onPressed: () {
                      return null;
                    },
                  ),
                ],
              );
            },
          );
        }
    );
  } */
  // sign in anon
  Future signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & pass
  // register in with email & pass
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  /* Future<bool> isUserLogged() async {
      User User = await getLoggedUser();
      if (User != null) {
          IdTokenResult tokenResult = await User.getIdToken(refresh: true);
          return tokenResult.token != null;
      } else {
          return false;
      }
  }

  Future<User> getLoggedUser() {
      return firebaseAuthInstance().currentUser();
  } */
}
