import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
// import 'package:gescolar_dev/widgets/Neomorphic/neoButton.dart';
// import 'package:gescolar_dev/widgets/Neomorphic/neoCard.dart';
import 'package:gescolar_dev/widgets/circular_progres/circular_progres.dart';
import 'package:cloud_functions/cloud_functions.dart';

bool darkMode = false;
String _response = 'no response';
int _responseCount = 0;

class Sedes extends StatelessWidget {
  const Sedes({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'getFirebaseUser')
          ..timeout = const Duration(seconds: 30);
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
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () async {
              try {
                final HttpsCallableResult result = await callable.call(
                  // <String>['JbldmJETyUMUpm2kIm0f0CyAGoW2'],
                  <String, dynamic>{
                    'data': 'JbldmJETyUMUpm2kIm0f0CyAGoW2',
                  },
                );
                print(result.data);
                // _response = result.data['repeat_message'];
                // _responseCount = result.data['repeat_count'];
              } on CloudFunctionsException catch (e) {
                print('caught firebase functions exception');
                print(e.code);
                print(e.message);
                print(e.details);
              } catch (e) {
                print('caught generic exception');
                print(e);
              }
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
