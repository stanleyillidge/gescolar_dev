/* import 'package:firebase_auth/firebase_auth.dart';
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
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
          FirebaseUser user = snapshot.data; // this is your user instance
          print(['Usuario autenticado', user]);

          /// is because there is user already logged
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo 1',
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
 */
/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gescolar_dev/pages/home.dart';
import 'package:gescolar_dev/pages/login.dart';
import 'package:hive/hive.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(App());
}

var storage;
var googleAuthStorage;
_initStorage() async {
  storage = await Hive.openBox('myBox');
  googleAuthStorage = await Hive.openBox('googleAuthStorage');
  print('Init storage');
}

// stanley.illidge@lreginaldofischione.edu.co
// 116675950093144953544
class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    _initStorage();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return SomethingWentWrong();
          print('Error inicializando firebase!');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseAuth.instance.authStateChanges().listen((User user) {
            if (user == null) {
              print('User is currently signed out!');
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                home: LoginPage(),
              );
            } else {
              print('User is signed in!');
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                home: HomePage(),
              );
            }
          });
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
} */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gescolar_dev/pages/home.dart';
import 'package:gescolar_dev/pages/landingPage.dart';
import 'package:gescolar_dev/pages/login.dart';
import 'package:hive/hive.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Main(firebaseApp: Firebase.initializeApp()),
  );
}

var storage;
var googleAuthStorage;
_initStorage() async {
  storage = await Hive.openBox('myBox');
  googleAuthStorage = await Hive.openBox('googleAuthStorage');
  print('Init storage');
}

// stanley.illidge@lreginaldofischione.edu.co
// 116675950093144953544
class Main extends StatelessWidget {
  final Future<FirebaseApp> firebaseApp;
  const Main({this.firebaseApp});

  @override
  Widget build(BuildContext context) {
    _initStorage();
    return FutureBuilder(
      future: firebaseApp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseFirestore.instanceFor(
            app: snapshot.data,
          );
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: LandingPage(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
