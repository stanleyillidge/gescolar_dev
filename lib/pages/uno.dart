// import 'dart:js';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:getwidget/getwidget.dart';
// import 'dart:math';
// import 'package:gescolar/widgets/expandable/expandable.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Uno extends StatefulWidget {
  @override
  State createState() {
    return UnoState();
  }
}

const firebaseConfig = FirebaseOptions(
  googleAppID: "1:395322918531:web:aaf5e5a050a3743d2e7db6",
  apiKey: "AIzaSyCdCTYPL1-PPQb3rpOi5Ls_oGoMfPjvXG8",
  databaseURL: "https://g-escolar-plus-demo.firebaseio.com",
  projectID: "g-escolar-plus-demo",
  storageBucket: "g-escolar-plus-demo.appspot.com",
);

const firebaseConfig1 = FirebaseOptions(
  googleAppID: "1:535423458946:web:e97e26d6b4455259d5de9b",
  apiKey: "AIzaSyApbwMngB5Xeu4xyADVV6Q2DcDDWM6DvDM",
  databaseURL: "https://inventarios-9bd11.firebaseio.com",
  projectID: "inventarios-9bd11",
  storageBucket: "inventarios-9bd11.appspot.com",
);
FirebaseApp app;
FirebaseApp app1;

_initDataBases() async {
  app = await FirebaseApp.configure(
    name: 'principal',
    options: firebaseConfig,
  );
  app1 = await FirebaseApp.configure(
    name: 'subBase1',
    options: firebaseConfig1,
  );
}

Future<FirebaseApp> _db1() async {
  /* app = await FirebaseApp.configure(
      name: "defaultAppName", options: firebaseConfig);
  return FirebaseDatabase(
          app: app, databaseURL: "https://g-escolar-plus-demo.firebaseio.com")
      .reference()
      .child("/roles")
      .orderByValue()
      .onChildAdded
      .forEach((event) => {print(event.snapshot.value)}); */

  Firestore(app: app).collection('colegios').getDocuments().then((value) => {
        value.documents.forEach((element) {
          print(element.documentID);
        })
      });
}

Future<Firestore> _db2() async {
  Firestore(app: app1)
      .collection('denzilescolar')
      .getDocuments()
      .then((value) => {
            value.documents.forEach((element) {
              print(element.documentID);
            })
          });
}

class Size {
  double h;
  double w;

  Size(this.h, this.w);
}

const List<Condition> blockWidthConstraints = [
  Condition.smallerThan(name: MOBILE, value: BoxConstraints(maxWidth: 451)),
  Condition.largerThan(name: TABLET, value: BoxConstraints(maxWidth: 450)),
  Condition.smallerThan(name: TABLET, value: BoxConstraints(maxWidth: 1001)),
  Condition.largerThan(name: DESKTOP, value: BoxConstraints(maxWidth: 1000)),
  Condition.largerThan(name: "4K", value: BoxConstraints(maxWidth: 1281)),
];

List<dynamic> _size = [Size(200, 300), Size(200, 200), Size(200, 400)];
List<double> _height = [0, 0, 0];

class UnoState extends State<Uno> {
  var crossAxisCount = 4;
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initDataBases());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 80),
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget),
          defaultScale: true,
          minWidth: 250,
          defaultName: MOBILE,
          breakpoints: [
            ResponsiveBreakpoint.autoScale(450, name: MOBILE),
            ResponsiveBreakpoint.resize(451, name: TABLET),
            ResponsiveBreakpoint.autoScale(999, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(1281, name: "4K"),
          ],
        ),
        home: Scaffold(
          /* appBar: AppBar(
            title: Text("Animate Content"),
          ), */
          /* body: Row(
            children: <Widget>[
              Column(
                children: [_acordeonSta(0)],
              ),
              Column(
                children: [_acordeonSta(1)],
              ),
              Column(
                children: [_acordeonSta(2)],
              ),
            ],
          ), */
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: <Widget>[
                        ResponsiveConstraints(
                          constraintsWhen: blockWidthConstraints,
                          child: _acordeonSta(0),
                        ),
                        ResponsiveConstraints(
                          constraintsWhen: blockWidthConstraints,
                          child: _acordeonSta(1),
                        ),
                        ResponsiveConstraints(
                          constraintsWhen: blockWidthConstraints,
                          child: _acordeonSta(2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      _db1();
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 110),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      _db2();
                    },
                    child: Icon(Icons.account_circle),
                  ),
                ),
              ),
            ],
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  _acordeonSta(index) {
    // _size[index].h
    return Card(
      elevation: 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () => setState(() {
              _height[index] != _size[index].h
                  ? _height[index] = _size[index].h
                  : _height[index] = 0.0;
            }),
            child: Container(
              constraints: BoxConstraints(maxWidth: _size[index].w),
              padding: EdgeInsets.only(top: 5),
              child: Text("CLICK ME"),
              color: Colors.blueAccent,
              height: 25.0,
              width: _size[index].w,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.decelerate,
            child: Text("Toggle Me"),
            height: _height[index],
            color: Colors.tealAccent,
            width: _size[index].w,
          )
        ],
      ),
    );
  }
}
