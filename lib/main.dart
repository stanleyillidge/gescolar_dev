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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gescolar_dev/pages/landingPage.dart';
import 'package:gescolar_dev/widgets/forms/institucionForm.dart';
import 'package:hive/hive.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'models/models.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Main(firebaseApp: Firebase.initializeApp()),
  );
}

var storage;
var googleAuthStorage;
var instStorage;
_initStorage() async {
  storage = await Hive.openBox('myBox');
  instStorage = await Hive.openBox('instStorage');
  googleAuthStorage = await Hive.openBox('googleAuthStorage');
  print('Main/Init storage');
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
          /* return MaterialApp(
            builder: (context, widget) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, widget),
                maxWidth: 1200,
                minWidth: 450,
                defaultScale: true,
                breakpoints: [
                  ResponsiveBreakpoint.resize(450, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
                background: Container(color: Color(0xFFF5F5F5))),
            initialRoute: Routes.sedes,
            onGenerateRoute: (RouteSettings settings) {
              return Routes.fadeThrough(settings, (context) {
                switch (settings.name) {
                  case Routes.sedes:
                    return LandingPage();
                    break;
                }
              });
            },
          ); */
        }
        return CircularProgressIndicator();
      },
    );
  }
}
