import 'package:flutter/material.dart';
import 'package:gescolar_dev/pages/home.dart';
import 'package:gescolar_dev/services/auth.dart';
import 'package:gescolar_dev/services/firebase_auth_service.dart';
import 'package:gescolar_dev/widgets/Google/Drive/drive.dart';
import 'package:gescolar_dev/widgets/Neomorphic/neoButton.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool darkMode = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  /* void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {_checkLogin()});
  } */
  @override
  Widget build(BuildContext context) {
    // _checkLogin(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkMode ? Colors.grey[850] : Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 650,
              child: Column(
                children: <Widget>[
                  Text(
                    "Plataforma de gestion escolar",
                    style: TextStyle(
                        fontFamily:
                            'conte', //OldBookshop // FingerPaintRegular// conte// CoalhandLuke// Cheveuxdange
                        fontSize: 40,
                        // fontWeight: FontWeight.bold,
                        color: darkMode ? Colors.white : Colors.black),
                  ),
                  FadeInImage.assetNetwork(
                    alignment: Alignment.centerLeft, // add this
                    placeholder: 'images/LogoHappykids.png',
                    image: 'images/LogoHappykids.png',
                    // fit: BoxFit.fitWidth,
                    height: 100,
                  ),
                ],
              ),
              /* decoration: BoxDecoration(
                color: darkMode ? Colors.grey[850] : Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: darkMode ? Colors.black54 : Colors.grey[500],
                      offset: Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: darkMode ? Colors.grey[800] : Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                ],
              ), */
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50, right: 3),
                  child: NeumorphicButton(
                    onTap: () {
                      FirebaseAuthService().signInWithGoogle().then((value) => {
                            GoogleDrive(),
                            print(['Login Ok :', value]),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            )
                          });
                    },
                    darkMode: darkMode,
                    imagen: 'images/GoogleLogo.png',
                    padding: 8,
                    bevel: 5,
                    child: Text(
                      'Correo institucional',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'Cheveuxdange',
                          fontWeight: FontWeight.w600,
                          color: darkMode ? Colors.white : Colors.black),
                    ),
                  ),
                  /* child: GestureDetector(
                    onTap: () {
                      FirebaseAuthService().signInWithGoogle().then((value) => {
                            GoogleDrive(),
                            print(['Login Ok :', value]),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            )
                          });
                    },
                    child: NeumorphicButton(
                      darkMode: darkMode,
                      imagen: 'images/GoogleLogo.png',
                      padding: 8,
                      bevel: 5,
                      child: Text(
                        'Correo institucional',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Cheveuxdange',
                            fontWeight: FontWeight.w600,
                            color: darkMode ? Colors.white : Colors.black),
                      ),
                    ),
                  ), */
                ),
                /* Padding(
                  padding: EdgeInsets.only(top: 50, right: 3),
                  child: FlatButton(
                    color: Colors.white,
                    child: Text(
                      'Light',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        darkMode = false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 3),
                  child: FlatButton(
                    color: Colors.black,
                    child: Text(
                      'Dark',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        darkMode = true;
                      });
                    },
                  ),
                ), */
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* _checkLogin(context) {
  FirebaseAuthService().currentUser().then(
        (value) => {
          print(['Login Ok log:', value]),
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          )
        },
      );
} */
