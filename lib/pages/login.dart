import 'package:flutter/material.dart';
import 'package:gescolar_dev/widgets/Neomorphic/neomorphic.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.grey[850] : Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 650,
              height: 150,
              child: Column(
                children: <Widget>[
                  Text(
                    "Plataforma de gestion escolar",
                    style: TextStyle(
                        fontSize: 20,
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
                  child: Row(
                    children: [
                      /* Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.center,
                            image: AssetImage('images/GoogleLogo.png'),
                          ),
                        ),
                      ), */
                      GestureDetector(
                        onTap: null,
                        child: NeumorphicContainer(
                          darkMode: darkMode,
                          child: Text(
                            'Google Login',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
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
