import 'dart:convert';
import 'dart:html';
// import 'dart:io' as io;
import 'dart:typed_data';
// import 'package:http/http.dart';
// import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:gescolar_dev/widgets/circular_progres/circular_progres.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:grizzly_io/io_loader.dart';

bool darkMode = false;
var firebaseUsers = 0;
var gSuiteUsers = 0;
var simatUsers = 0;

class Sedes extends StatefulWidget {
  Sedes({Key key}) : super(key: key);

  @override
  _SedesState createState() => _SedesState();
}

class _SedesState extends State<Sedes> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          getFirebaseUsers().then((a) => {
                setState(() {
                  firebaseUsers = a;
                })
              }),
          /* getGsuiteUsers(null).then((b) => {
                setState(() {
                  gSuiteUsers = gSuiteUsers;
                })
              }) */
        });
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    double radius = 100.0;
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 80,
          child: Container(
            width: 380,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: darkMode ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: darkMode ? Colors.black54 : Colors.grey[300],
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: darkMode ? Colors.grey[800] : Colors.white,
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 3.0,
                    spreadRadius: 1.0),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Matriculados',
                      // textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Spartan',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: darkMode ? Colors.white : Color(0xFF3326AE),
                      ),
                    ),
                    Text(
                      '5 ago 2020',
                      // textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Spartan',
                        fontWeight: FontWeight.w700,
                        color: darkMode ? Colors.white : Color(0xFF3326AE),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 27.0, bottom: 8.0),
                                child: Text(
                                  'Total',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'ArmataRegular',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Text(
                                  '4636',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Spartan',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Text(
                                  'SIMAT',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    // fontFamily: 'Cheveuxdange',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color:
                                        darkMode ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 27.0, bottom: 8.0),
                                child: Text(
                                  gSuiteUsers.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Spartan',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Container(
                                  width: radius,
                                  height: radius,
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200],
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 7.0,
                                          spreadRadius: 1.0),
                                      BoxShadow(
                                          color: Colors.grey[50],
                                          offset: Offset(-2.0, -2.0),
                                          blurRadius: 7.0,
                                          spreadRadius: 1.0),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      // _startFilePicker();
                                      _pickFiles();
                                    },
                                    child: CircularPercentIndicator(
                                      radius: radius - 10.0,
                                      lineWidth: 10.0,
                                      percent: 0.13,
                                      // header: Text("Icon header"),
                                      center: Text(
                                        '100%',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'ArmataRegular',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: darkMode
                                              ? Colors.white
                                              : Colors.grey[600],
                                        ),
                                      ),
                                      backgroundColor: Colors.white,
                                      progressColor: Color(0xFF3326AE),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 5.0),
                                child: Text(
                                  'G',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    // fontFamily: 'Cheveuxdange',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:
                                        darkMode ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 30.0),
                                child: Text(
                                  'Suite',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    // fontFamily: 'Cheveuxdange',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color:
                                        darkMode ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  firebaseUsers.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Spartan',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                              Container(
                                width: radius,
                                height: radius,
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 7.0,
                                        spreadRadius: 1.0),
                                    BoxShadow(
                                        color: Colors.grey[50],
                                        offset: Offset(-2.0, -2.0),
                                        blurRadius: 7.0,
                                        spreadRadius: 1.0),
                                  ],
                                ),
                                child: CircularPercentIndicator(
                                  radius: radius - 10.0,
                                  lineWidth: 10.0,
                                  percent: 0.13,
                                  // header: Text("Icon header"),
                                  center: Text(
                                    '100%',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'ArmataRegular',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: darkMode
                                          ? Colors.white
                                          : Colors.grey[600],
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                  progressColor: Color(0xFF3326AE),
                                  circularStrokeCap: CircularStrokeCap.round,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Firebase',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    // fontFamily: 'Cheveuxdange',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color:
                                        darkMode ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      /* Container(
                        width: radius,
                        height: radius,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                offset: Offset(2.0, 2.0),
                                blurRadius: 7.0,
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.grey[50],
                                offset: Offset(-2.0, -2.0),
                                blurRadius: 7.0,
                                spreadRadius: 1.0),
                          ],
                        ),
                        child: CircularPercentIndicator(
                          radius: radius - 10.0,
                          lineWidth: 10.0,
                          percent: 0.13,
                          // header: Text("Icon header"),
                          center: Container(
                            width: radius - 28,
                            height: radius - 28,
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(50),
                              /* boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey[400],
                                                          offset: Offset(2.0, 2.0),
                                                          blurRadius: 7.0,
                                                          spreadRadius: 1.0),
                                                      BoxShadow(
                                                          color: Colors.white,
                                                          offset: Offset(-2.0, -2.0),
                                                          blurRadius: 7.0,
                                                          spreadRadius: 1.0),
                                                    ], */
                            ),
                            child: Icon(
                              Icons.group_add,
                              size: 40.0,
                              color: Colors.grey,
                            ),
                          ),
                          backgroundColor: Colors.white,
                          progressColor: Color(0xFF3326AE),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ), */
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 500,
          child: Card(
            color: Colors.blueAccent,
            child: Container(
              // height: 100,
              width: 350,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Container(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                      ),
                      Text(
                        'Day 1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(right: 20, left: 20, bottom: 20),
                        child: Text('data'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                getGsuiteUsers(null).then((b) => {
                      print(['Resultado final', b]),
                      setState(() {
                        gSuiteUsers = gSuiteUsers;
                      })
                    });
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}

/* class Sedes extends StatelessWidget {
  const Sedes({Key key}) : super(key: key);
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => {getFirebaseUsers()});
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    double radius = 100.0;
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 80,
          /* child: Card(
            elevation: 2,
            // margin: EdgeInsets.only(top: 30, left: 80),
            child: Container(
              width: 405,
              padding: EdgeInsets.all(10),
              /* decoration: BoxDecoration(
                color: darkMode ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: darkMode ? Colors.black54 : Colors.grey[300],
                      offset: Offset(2.0, 2.0),
                      blurRadius: 7.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: darkMode ? Colors.grey[800] : Colors.white,
                      offset: Offset(-2.0, -2.0),
                      blurRadius: 7.0,
                      spreadRadius: 1.0),
                ],
              ), */
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Matriculas hasta el ',
                        // textAlign: TextAlign.start,
                        style: TextStyle(
                          // fontFamily: 'ArmataRegular',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: darkMode ? Colors.white : Colors.grey,
                        ),
                      ),
                      Text(
                        '5 ago 2020',
                        // textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Spartan',
                          fontWeight: FontWeight.w600,
                          color: darkMode ? Colors.white : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 5, right: 5, bottom: 5),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 27.0, bottom: 8.0),
                                      child: Text(
                                        'Total',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'ArmataRegular',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: darkMode
                                              ? Colors.white
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: Text(
                                        '4636',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'Spartan',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 30,
                                          color: darkMode
                                              ? Colors.white
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    /* Padding(
                                                    padding:
                                                        const EdgeInsets.only(right: 5.0),
                                                    child: Text(
                                                      'G',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        // fontFamily: 'Cheveuxdange',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 20,
                                                        color: darkMode
                                                            ? Colors.white
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ), */
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: Text(
                                        'SIMAT',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          // fontFamily: 'Cheveuxdange',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: darkMode
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 27.0, bottom: 8.0),
                                      child: Text(
                                        '4636',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'Spartan',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: darkMode
                                              ? Colors.white
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: Container(
                                        width: radius,
                                        height: radius,
                                        margin: EdgeInsets.all(0),
                                        padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[200],
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 7.0,
                                                spreadRadius: 1.0),
                                            BoxShadow(
                                                color: Colors.grey[50],
                                                offset: Offset(-2.0, -2.0),
                                                blurRadius: 7.0,
                                                spreadRadius: 1.0),
                                          ],
                                        ),
                                        child: CircularPercentIndicator(
                                          radius: radius - 10.0,
                                          lineWidth: 10.0,
                                          percent: 0.13,
                                          // header: Text("Icon header"),
                                          center: Text(
                                            '100%',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: 'ArmataRegular',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: darkMode
                                                  ? Colors.white
                                                  : Colors.grey[600],
                                            ),
                                          ),
                                          /* Container(
                                                          width: radius - 28,
                                                          height: radius - 28,
                                                          padding: EdgeInsets.all(7),
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[50],
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    50),
                                                          ),
                                                          child: Icon(
                                                            Icons.group_add,
                                                            size: 40.0,
                                                            color: Colors.grey,
                                                          ),
                                                        ), */
                                          backgroundColor: Colors.white,
                                          progressColor: Color(0xFF3326AE),
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                        ),
                                      ),
                                      /* Text(
                                                      '4636',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontFamily: 'Spartan',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 30,
                                                        color: darkMode
                                                            ? Colors.white
                                                            : Colors.grey[600],
                                                      ),
                                                    ), */
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 5.0),
                                      child: Text(
                                        'G',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          // fontFamily: 'Cheveuxdange',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: darkMode
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 30.0),
                                      child: Text(
                                        'Suite',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          // fontFamily: 'Cheveuxdange',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: darkMode
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 27.0, bottom: 8.0),
                                      child: Text(
                                        '4636',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'Spartan',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: darkMode
                                              ? Colors.white
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: Container(
                                        width: radius,
                                        height: radius,
                                        margin: EdgeInsets.all(0),
                                        padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[200],
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 7.0,
                                                spreadRadius: 1.0),
                                            BoxShadow(
                                                color: Colors.grey[50],
                                                offset: Offset(-2.0, -2.0),
                                                blurRadius: 7.0,
                                                spreadRadius: 1.0),
                                          ],
                                        ),
                                        child: CircularPercentIndicator(
                                          radius: radius - 10.0,
                                          lineWidth: 10.0,
                                          percent: 0.13,
                                          // header: Text("Icon header"),
                                          center: Text(
                                            '100%',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: 'ArmataRegular',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: darkMode
                                                  ? Colors.white
                                                  : Colors.grey[600],
                                            ),
                                          ),
                                          /* Container(
                                                          width: radius - 28,
                                                          height: radius - 28,
                                                          padding: EdgeInsets.all(7),
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[50],
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    50),
                                                          ),
                                                          child: Icon(
                                                            Icons.group_add,
                                                            size: 40.0,
                                                            color: Colors.grey,
                                                          ),
                                                        ), */
                                          backgroundColor: Colors.white,
                                          progressColor: Color(0xFF3326AE),
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                        ),
                                      ),
                                      /* Text(
                                                      '4636',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontFamily: 'Spartan',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 30,
                                                        color: darkMode
                                                            ? Colors.white
                                                            : Colors.grey[600],
                                                      ),
                                                    ), */
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    /* Padding(
                                                    padding:
                                                        const EdgeInsets.only(right: 5.0),
                                                    child: Container(
                                                      // margin: const EdgeInsets.only(
                                                      //     top: 10.0),
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'images/firebase-logo.png'))),
                                                    ),
                                                  ), */
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 30.0),
                                      child: Text(
                                        'Firebase',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          // fontFamily: 'Cheveuxdange',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: darkMode
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            /* Container(
                                            width: radius,
                                            height: radius,
                                            margin: EdgeInsets.all(0),
                                            padding: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(50),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey[200],
                                                    offset: Offset(2.0, 2.0),
                                                    blurRadius: 7.0,
                                                    spreadRadius: 1.0),
                                                BoxShadow(
                                                    color: Colors.grey[50],
                                                    offset: Offset(-2.0, -2.0),
                                                    blurRadius: 7.0,
                                                    spreadRadius: 1.0),
                                              ],
                                            ),
                                            child: CircularPercentIndicator(
                                              radius: radius - 10.0,
                                              lineWidth: 10.0,
                                              percent: 0.13,
                                              // header: Text("Icon header"),
                                              center: Container(
                                                width: radius - 28,
                                                height: radius - 28,
                                                padding: EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[50],
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  /* boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey[400],
                                                        offset: Offset(2.0, 2.0),
                                                        blurRadius: 7.0,
                                                        spreadRadius: 1.0),
                                                    BoxShadow(
                                                        color: Colors.white,
                                                        offset: Offset(-2.0, -2.0),
                                                        blurRadius: 7.0,
                                                        spreadRadius: 1.0),
                                                  ], */
                                                ),
                                                child: Icon(
                                                  Icons.group_add,
                                                  size: 40.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              backgroundColor: Colors.white,
                                              progressColor: Color(0xFF3326AE),
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                            ),
                                          ), */
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ), */
          child: Container(
            width: 380,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: darkMode ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: darkMode ? Colors.black54 : Colors.grey[300],
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: darkMode ? Colors.grey[800] : Colors.white,
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 3.0,
                    spreadRadius: 1.0),
              ],
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Matriculados',
                      // textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Spartan',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: darkMode ? Colors.white : Color(0xFF3326AE),
                      ),
                    ),
                    Text(
                      '5 ago 2020',
                      // textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Spartan',
                        fontWeight: FontWeight.w700,
                        color: darkMode ? Colors.white : Color(0xFF3326AE),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 27.0, bottom: 8.0),
                                child: Text(
                                  'Total',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'ArmataRegular',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Text(
                                  '4636',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Spartan',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              /* Padding(
                                                      padding:
                                                          const EdgeInsets.only(right: 5.0),
                                                      child: Text(
                                                        'G',
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                          // fontFamily: 'Cheveuxdange',
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 20,
                                                          color: darkMode
                                                              ? Colors.white
                                                              : Colors.grey,
                                                        ),
                                                      ),
                                                    ), */
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Text(
                                  'SIMAT',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    // fontFamily: 'Cheveuxdange',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color:
                                        darkMode ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 27.0, bottom: 8.0),
                                child: Text(
                                  '4636',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Spartan',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Container(
                                  width: radius,
                                  height: radius,
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200],
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 7.0,
                                          spreadRadius: 1.0),
                                      BoxShadow(
                                          color: Colors.grey[50],
                                          offset: Offset(-2.0, -2.0),
                                          blurRadius: 7.0,
                                          spreadRadius: 1.0),
                                    ],
                                  ),
                                  child: CircularPercentIndicator(
                                    radius: radius - 10.0,
                                    lineWidth: 10.0,
                                    percent: 0.13,
                                    // header: Text("Icon header"),
                                    center: Text(
                                      '100%',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'ArmataRegular',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: darkMode
                                            ? Colors.white
                                            : Colors.grey[600],
                                      ),
                                    ),
                                    /* Container(
                                                            width: radius - 28,
                                                            height: radius - 28,
                                                            padding: EdgeInsets.all(7),
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey[50],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      50),
                                                            ),
                                                            child: Icon(
                                                              Icons.group_add,
                                                              size: 40.0,
                                                              color: Colors.grey,
                                                            ),
                                                          ), */
                                    backgroundColor: Colors.white,
                                    progressColor: Color(0xFF3326AE),
                                    circularStrokeCap: CircularStrokeCap.round,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 5.0),
                                child: Text(
                                  'G',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    // fontFamily: 'Cheveuxdange',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color:
                                        darkMode ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 30.0),
                                child: Text(
                                  'Suite',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    // fontFamily: 'Cheveuxdange',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color:
                                        darkMode ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  firebaseUsers.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Spartan',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                              Container(
                                width: radius,
                                height: radius,
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 7.0,
                                        spreadRadius: 1.0),
                                    BoxShadow(
                                        color: Colors.grey[50],
                                        offset: Offset(-2.0, -2.0),
                                        blurRadius: 7.0,
                                        spreadRadius: 1.0),
                                  ],
                                ),
                                child: CircularPercentIndicator(
                                  radius: radius - 10.0,
                                  lineWidth: 10.0,
                                  percent: 0.13,
                                  // header: Text("Icon header"),
                                  center: Text(
                                    '100%',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'ArmataRegular',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: darkMode
                                          ? Colors.white
                                          : Colors.grey[600],
                                    ),
                                  ),
                                  /* Container(
                                                            width: radius - 28,
                                                            height: radius - 28,
                                                            padding: EdgeInsets.all(7),
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey[50],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      50),
                                                            ),
                                                            child: Icon(
                                                              Icons.group_add,
                                                              size: 40.0,
                                                              color: Colors.grey,
                                                            ),
                                                          ), */
                                  backgroundColor: Colors.white,
                                  progressColor: Color(0xFF3326AE),
                                  circularStrokeCap: CircularStrokeCap.round,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              /* Padding(
                                                      padding:
                                                          const EdgeInsets.only(right: 5.0),
                                                      child: Container(
                                                        // margin: const EdgeInsets.only(
                                                        //     top: 10.0),
                                                        width: 35,
                                                        height: 35,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'images/firebase-logo.png'))),
                                                      ),
                                                    ), */
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Firebase',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    // fontFamily: 'Cheveuxdange',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color:
                                        darkMode ? Colors.white : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      /* Container(
                        width: radius,
                        height: radius,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                offset: Offset(2.0, 2.0),
                                blurRadius: 7.0,
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.grey[50],
                                offset: Offset(-2.0, -2.0),
                                blurRadius: 7.0,
                                spreadRadius: 1.0),
                          ],
                        ),
                        child: CircularPercentIndicator(
                          radius: radius - 10.0,
                          lineWidth: 10.0,
                          percent: 0.13,
                          // header: Text("Icon header"),
                          center: Container(
                            width: radius - 28,
                            height: radius - 28,
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(50),
                              /* boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey[400],
                                                          offset: Offset(2.0, 2.0),
                                                          blurRadius: 7.0,
                                                          spreadRadius: 1.0),
                                                      BoxShadow(
                                                          color: Colors.white,
                                                          offset: Offset(-2.0, -2.0),
                                                          blurRadius: 7.0,
                                                          spreadRadius: 1.0),
                                                    ], */
                            ),
                            child: Icon(
                              Icons.group_add,
                              size: 40.0,
                              color: Colors.grey,
                            ),
                          ),
                          backgroundColor: Colors.white,
                          progressColor: Color(0xFF3326AE),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ), */
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 500,
          child: Card(
            color: Colors.blueAccent,
            child: Container(
              // height: 100,
              width: 350,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Container(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                      ),
                      Text(
                        'Day 1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(right: 20, left: 20, bottom: 20),
                        child: Text('data'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                getFirebaseUsers();
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
} */

getFirebaseUsers() async {
  final HttpsCallable callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'getAllFirebaseUsers')
        ..timeout = const Duration(seconds: 30);
  try {
    final HttpsCallableResult result = await callable.call(
      <String, dynamic>{
        'data': '109775147545070328639',
      },
    );
    // firebaseUsers = result.data['usuarios'].length;
    return result.data['usuarios'].length;
    // print(result.data['usuarios'].length);
    /* List<dynamic> data = [];
                result.data['usuarios'].forEach((user) {
                  print(user);
                  data.add(user);
                });
                print(result.data['usuarios']);
                print(data.length); */
  } on CloudFunctionsException catch (e) {
    print('caught firebase functions exception');
    print(e.code);
    print(e.message);
    print(e.details);
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}

var conta = 0;
var nex = '';
List<dynamic> usuariosG = [];
getGsuiteUsers(nextPageToken) async {
  final HttpsCallable callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'getAllGsuiteUsers')
        ..timeout = const Duration(seconds: 30);
  try {
    HttpsCallableResult result;
    print(['nextPageToken', nextPageToken]);
    if (nex == '') {
      nex = nextPageToken;
    }
    if (nextPageToken != null) {
      result = await callable.call(
        <String, dynamic>{
          'data': nex,
        },
      );
    } else {
      result = await callable.call(
        <String, dynamic>{
          'data': null,
        },
      );
    }
    // usuariosG.add(result.data['data']);
    print(['Resultado', result.data['data'].length]);
    gSuiteUsers += result.data['data'].length;
    // print(['Num users', gSuiteUsers]);
    print(['Num consulta', conta]);
    // print(['UserId - ', conta, ': ', result.data['data']['users'][0].id]);
    conta += 1;
    return gSuiteUsers;
    /* if ((result.data['data']['nextPageToken'] != null) && (conta < 20)) {
      getGsuiteUsers(result.data['data']['nextPageToken']);
    } else {
      print(['Termino con', gSuiteUsers]);
      print(['Resultado', result.data]);
      return gSuiteUsers;
    } */
    // print(result.data['usuarios'].length);
    /* List<dynamic> data = [];
                result.data['usuarios'].forEach((user) {
                  print(user);
                  data.add(user);
                });
                print(result.data['usuarios']);
                print(data.length); */
  } on CloudFunctionsException catch (e) {
    print('getGsuiteUsers caught firebase functions exception');
    print(e.code);
    print(e.message);
    print(e.details);
  } catch (e) {
    print('getGsuiteUsers caught generic exception');
    print(e);
  }
}

Uint8List uploadedImage;
_pickFiles() async {
  InputElement uploadInput = FileUploadInputElement();
  uploadInput.click();

  uploadInput.onChange.listen((e) {
    // read file content as dataURL
    try {
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();
        /* {
            "name": "gescolar_dev",
            "short_name": "gescolar_dev",
            "start_url": ".",
            "display": "standalone",
            "background_color": "#0175C2",
            "theme_color": "#0175C2",
            "description": "A new Flutter project.",
            "orientation": "portrait-primary",
            "prefer_related_applications": false,
            "icons": [
                {
                    "src": "icons/Icon-192.png",
                    "sizes": "192x192",
                    "type": "image/png"
                },
                {
                    "src": "icons/Icon-512.png",
                    "sizes": "512x512",
                    "type": "image/png"
                }
        }*/
        reader.onLoadEnd.listen((e) {
          try {
            // var _json = json.decode(reader.result);
            // uploadedImage = reader.result;
            // File datos = File(uploadedImage, 'datos.csv');
            // _csv(file.relativePath);
            // io.File _file = io.File.fromRawPath(rawPath);
            // String parte = getApplicationDocumentsDirectory()
            print([file.relativePath, file.name]);
            // print(reader.result);
            var a = reader.result.toString().split("\n");
            var b = [];
            a.forEach((element) {
              b.add(element.toString().split(";"));
            });
            var encabezados = b[0];
            var usuarios = {};
            /*for (var i = 1; i < b.length; i++) {
              b[i]
            } */
            print(b);
            // print(new_data);
            /* setState(() {
              uploadedImage = reader.result;
            }); */
          } catch (e) {
            print(['Error reader', e]);
          }
        });

        reader.onError.listen((fileEvent) {
          const option1Text = "Some Error occured while reading the file";
          print(option1Text);
          /* setState(() {
            option1Text = "Some Error occured while reading the file";
          }); */
        });
        reader.readAsText(file);
        // reader.readAsArrayBuffer(file);
        // reader.readAsDataUrl(file);
      }
    } catch (e) {
      print(['Error picker', e]);
    }
  });
}

_csv(path) async {
  try {
    final tsv = await readCsv(path, fieldSep: '|', textSep: "'");
    print(tsv);
  } catch (e) {
    print(['Error _csv', e]);
  }
}

_startFilePicker() async {
  InputElement uploadInput = FileUploadInputElement();
  uploadInput.click();

  uploadInput.onChange.listen((e) {
    // read file content as dataURL
    final files = uploadInput.files;
    if (files.length == 1) {
      final file = files[0];
      final reader = new FileReader();

      reader.onLoadEnd.listen((e) {
        print(reader.result);
      });
      reader.readAsDataUrl(file);
    }
  });
}
