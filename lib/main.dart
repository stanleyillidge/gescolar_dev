import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gescolar_dev/pages/home.dart';
import 'package:gescolar_dev/pages/login.dart';
import 'package:hive/hive.dart';

// import 'package:gescolar_dev/services/firebase_auth_service.dart';
var storage;
var googleAuthStorage;
void main() {
  runApp(MyApp());
}

_initStorage() async {
  storage = await Hive.openBox('myBox');
  googleAuthStorage = await Hive.openBox('googleAuthStorage');
  print('Init storage');
}

Widget home = HomePage();

// stanley.illidge@lreginaldofischione.edu.co
// 116675950093144953544
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // final LocalStorage storage = LocalStorage('gescolar_app');
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool initialized = false;
  /* @override
  Widget build(BuildContext context) {
    if (!initialized) {
      // var items = storage.getItem('database');
      // var items1 = storage.getItem('database1');
      // print(['database', items, 'database1', items1]);
      initialized = true;
    }
    // _checkLogin(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: FirebaseAuthService().currentUser() != null
          ? HomePage()
          : LoginPage(),
    );
  } */
  @override
  Widget build(BuildContext context) {
    _initStorage();
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          // FirebaseUser user = snapshot.data; // this is your user instance
          print(snapshot.data);

          /// is because there is user already logged
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo 2',
            home: HomePage(),
          );
        }

        /// other way there is no user logged.
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: LoginPage(),
        );
      },
    );
  }
}
