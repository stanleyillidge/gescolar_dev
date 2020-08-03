// import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gescolar_dev/models/user.dart';
// import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final dominio = 'lreginaldofischione.edu.co';
  // auth change user strem
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            photoUrl: user.photoUrl,
            displayName: user.displayName,
          )
        : null;
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
        final FirebaseUser user =
            (await _auth.signInWithCredential(credential)).user;
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
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
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
      FirebaseUser firebaseUser = await getLoggedFirebaseUser();
      if (firebaseUser != null) {
          IdTokenResult tokenResult = await firebaseUser.getIdToken(refresh: true);
          return tokenResult.token != null;
      } else {
          return false;
      }
  }

  Future<FirebaseUser> getLoggedFirebaseUser() {
      return firebaseAuthInstance().currentUser();
  } */
}
