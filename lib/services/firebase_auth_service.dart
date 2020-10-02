import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/auth_browser.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class FirebaseAuthService {
  var storage = Hive.box('googleAuthStorage');
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ??
            GoogleSignIn(
              scopes: <String>[
                'email',
                'https://www.googleapis.com/auth/contacts.readonly',
                'https://www.googleapis.com/auth/admin.directory.user',
                'https://www.googleapis.com/auth/admin.directory.group',
                'https://www.googleapis.com/auth/classroom.coursework.students',
                'https://www.googleapis.com/auth/classroom.courses',
                'https://www.googleapis.com/auth/classroom.announcements',
                'https://www.googleapis.com/auth/classroom.rosters',
              ],
            );

  User _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    print({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
    });
    return user;
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var nombres = googleUser.displayName.toString().split(" ");
    var familyName;
    var givenName;
    var email = googleUser.email;
    switch (nombres.length) {
      case 2:
        familyName = nombres[1];
        givenName = nombres[0];
        break;
      case 3:
        familyName = nombres[1] + ' ' + nombres[2];
        givenName = nombres[0];
        break;
      case 4:
        familyName = nombres[2] + ' ' + nombres[3];
        givenName = nombres[0] + ' ' + nombres[2];
        break;
      default:
    }
    var user = {
      'id': googleUser.id,
      'name': {
        'familyName': familyName,
        'givenName': givenName,
        'fullName': googleUser.displayName,
      },
      'password': '123456789',
      'primaryEmail': email,
      'orgUnitPath': '/Ensayo'
    };
    var indexD = email.toString().indexOf('lreginaldofischione.edu.co');
    if (indexD > -1) {
      final HttpsCallable callable = CloudFunctions.instance
          .getHttpsCallable(functionName: 'addGsuiteUser')
            ..timeout = const Duration(seconds: 60);
      try {
        HttpsCallableResult result;
        print(['usuarios', user]);
        result = await callable.call(
          <String, dynamic>{
            'data': user,
          },
        );
        final authResult = await _firebaseAuth.signInWithCredential(credential);
        await storage.put('accessToken', googleAuth.accessToken);
        await storage.put('idToken', googleAuth.idToken);
        // var accessToken = await storage.get('accessToken');
        // var idToken = await storage.get('accessToken');
        // print(['googleAuth.accessToken', googleAuth.accessToken]);
        // print(['googleAuth.idToken', googleAuth.idToken]);
        // print(['googleAuth.accessTokenS', accessToken]);
        // print(['googleAuth.idTokenS', idToken]);
        print(['Resultado', result.data]);
        var simatSheetId = result.data;
        await storage.put('simatSheetId', result.data);
        return _userFromFirebase(authResult.user);
      } on CloudFunctionsException catch (e) {
        print('addGsuiteUser functions exception');
        print(e.code);
        print(e.message);
        print(e.details);
      } catch (e) {
        print('addGsuiteUser generic exception');
        print(e);
      }
    } else {
      AlertDialog(
        title: Text('Error de acceso'),
        content: Text('Debes usar una cuenta del Livio Reginaldo Fischione'),
        actions: [FlatButton(onPressed: null, child: Text('Ok'))],
        elevation: 24,
        backgroundColor: Colors.blue,
      );
      return null;
    }
    // var accessToken = await storage.get('accessToken');
    // var idToken = await storage.get('accessToken');
    // print(['googleAuth.accessToken', googleAuth.accessToken]);
    // print(['googleAuth.idToken', googleAuth.idToken]);
    // print(['googleAuth.accessTokenS', accessToken]);
    // print(['googleAuth.idTokenS', idToken]);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<User> currentUser() async {
    final User user = await _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }
}
