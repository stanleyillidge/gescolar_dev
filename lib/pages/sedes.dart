import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:gescolar_dev/widgets/Neomorphic/neoButton.dart';
import 'package:gescolar_dev/widgets/Neomorphic/neoCard.dart';
import 'package:gescolar_dev/widgets/circular_progres/circular_progres.dart';

bool darkMode = false;

class Sedes extends StatelessWidget {
  const Sedes({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    final GlobalKey<AnimatedCircularChartState> _chartKey =
        new GlobalKey<AnimatedCircularChartState>();
    var _chartSize = const Size(100.0, 100.0);
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: darkMode ? Colors.grey[850] : Colors.white,
          body: Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 75),
                    child: NeumorphicCard(
                      darkMode: darkMode,
                      // imagen: 'images/GoogleLogo.png',
                      padding: 8,
                      bevel: 5,
                      child: Column(
                        children: [
                          Text(
                            'Usuarios presentes en G Suiste',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Cheveuxdange',
                              fontWeight: FontWeight.w600,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          /* CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 10.0,
                            percent: 0.63,
                            header: Text("Icon header"),
                            center: Icon(
                              Icons.report,
                              size: 50.0,
                              color: Colors.blue,
                            ),
                            backgroundColor: Colors.grey[200],
                            progressColor: Colors.blue,
                          ), */
                          Container(
                            width: 110,
                            height: 110,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
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
                              ],
                            ),
                            /* child: AnimatedCircularChart(
                              key: _chartKey,
                              size: _chartSize,
                              initialChartData: <CircularStackEntry>[
                                CircularStackEntry(
                                  <CircularSegmentEntry>[
                                    CircularSegmentEntry(
                                      33.33,
                                      Colors.blue[400],
                                      rankKey: 'completed',
                                    ),
                                    CircularSegmentEntry(
                                      66.67,
                                      Colors.blueGrey[100],
                                      rankKey: 'remaining',
                                    ),
                                  ],
                                  rankKey: 'progress',
                                ),
                              ],
                              chartType: CircularChartType.Radial,
                              edgeStyle: SegmentEdgeStyle.round,
                              percentageValues: true,
                            ), */
                            child: CircularPercentIndicator(
                              radius: 100.0,
                              lineWidth: 10.0,
                              percent: 0.63,
                              // header: Text("Icon header"),
                              center: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
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
                                  ],
                                ),
                                child: Icon(
                                  Icons.report,
                                  size: 50.0,
                                  color: Colors.blue,
                                ),
                              ),
                              backgroundColor: Colors.grey[200],
                              progressColor: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 25),
                    child: NeumorphicCard(
                      darkMode: darkMode,
                      imagen: 'images/GoogleLogo.png',
                      padding: 8,
                      bevel: 5,
                      child: Column(
                        children: [
                          Text(
                            'Correo institucional',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Cheveuxdange',
                              fontWeight: FontWeight.w600,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          NeumorphicButton(
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
                                  color:
                                      darkMode ? Colors.white : Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
