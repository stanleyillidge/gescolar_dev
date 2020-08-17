import 'dart:convert';
import 'dart:html';
import 'dart:io' as io;
import 'dart:typed_data';
// import 'package:http/http.dart';
// import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:gescolar_dev/pages/tabla.dart';
import 'package:gescolar_dev/widgets/circular_chart/flutter_circular_chart.dart';
// import 'package:flutter/services.dart';
import 'package:gescolar_dev/widgets/circular_progres/circular_progres.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:gescolar_dev/widgets/pagDataTable/pagDataTable.dart';
import 'package:hive/hive.dart';
import 'package:json_table/json_table.dart';

bool darkMode = false;
var firebaseUsers = 0;
var gSuiteUsers = 0;
var simatUsers = 0;
// final storage = LocalStorage();
var storage;
_initStorage() async {
  storage = await Hive.openBox('myBox');
  print('Init storage');
}

var _json;
List<CircularStackEntry> dataC = <CircularStackEntry>[
  CircularStackEntry(
    <CircularSegmentEntry>[
      CircularSegmentEntry(20.0, Colors.yellow[400], rankKey: 'FIREBASE'),
      CircularSegmentEntry(10.0, Colors.white, rankKey: 'Q1'),
      CircularSegmentEntry(20.0, Colors.blue[400], rankKey: 'GSUITE'),
      CircularSegmentEntry(10.0, Colors.white, rankKey: 'Q2'),
      CircularSegmentEntry(20.0, Colors.deepOrange[400], rankKey: 'SIMAT'),
      CircularSegmentEntry(10.0, Colors.white, rankKey: 'Q3'),
    ],
    rankKey: 'Quarterly Profits',
  ),
];

final String jsonSample =
    '[{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc"},{"name":"Shyam","email":"shyam23@gmail.com",'
    '"age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India",'
    '"area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
    '{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com",'
    '"age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India",'
    '"area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
    '{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,'
    '"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc",'
    '"day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"}]';

class Filas {
  String name;
  String email;
  int age;
  String income;
  String country;
  String area;
  bool selected;

  Filas(
      {this.name,
      this.email,
      this.age,
      this.income,
      this.country,
      this.area,
      this.selected});

  factory Filas.fromJson(Map<String, dynamic> json) {
    return new Filas(
        name: json['name'],
        email: json['email'],
        age: json['age'],
        income: json['income'],
        country: json['country'],
        area: json['area'],
        selected: false);
  }
}

List<Filas> users = (json.decode(jsonSample) as List)
    .map((data) => Filas.fromJson(data))
    .toList();

int numItems = users.length;
List<bool> selected = List<bool>.generate(numItems, (index) => false);
List<bool> simatSelected = List<bool>.generate(numItems, (index) => false);

class Sedes extends StatefulWidget {
  Sedes({Key key}) : super(key: key);

  @override
  _SedesState createState() => _SedesState();
}

class _SedesState extends State<Sedes> with SingleTickerProviderStateMixin {
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          _initStorage(),
          print(users)
          /* getFirebaseUsers().then((a) => {
                setState(() {
                  firebaseUsers = a;
                })
              }),
          getGsuiteUsers(null).then((b) => {
                setState(() {
                  gSuiteUsers = gSuiteUsers;
                })
              }) */
        });
  }

  bool _sortNameAsc = true;
  bool _sortAgeAsc = true;
  bool _sortHightAsc = true;
  bool _sortAsc = true;
  int _sortColumnIndex;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Simat'),
    Tab(text: 'G Suite'),
    Tab(text: 'Firebase'),
  ];

  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // firebaseUsers = 0;
    /*(storage.getItem('firebaseUsers') == null)
          ? getFirebaseUsers().then((a) => {
                setState(() {
                  firebaseUsers = a;
                })
              })
          : firebaseUsers = storage.getItem('firebaseUsers'); */
    // gSuiteUsers = 0;
    /* (storage.getItem('gSuiteUsers') == null)
          ? getGsuiteUsers(null).then((b) => {
                setState(() {
                  gSuiteUsers = gSuiteUsers;
                })
              })
          : gSuiteUsers = storage.getItem('gSuiteUsers'); */
    // --------------------------------------
    double radius = 100.0;
    _json = jsonDecode(jsonSample);
    final GlobalKey<AnimatedCircularChartState> _chartKey =
        GlobalKey<AnimatedCircularChartState>();
    int _rowPerPage = PagDataTable.defaultRowsPerPage;
    List<DataColumn> columnas = [
      DataColumn(
        label: Text('name'),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            users.sort((a, b) => a.name.compareTo(b.name));
            if (!_sortAsc) {
              users = users.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: Text('email'),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            users.sort((a, b) => a.email.compareTo(b.email));
            if (!_sortAsc) {
              users = users.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: Text('age'),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            users.sort((a, b) => a.age.compareTo(b.age));
            if (!_sortAsc) {
              users = users.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: Text('income'),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            users.sort((a, b) => a.income.compareTo(b.income));
            if (!_sortAsc) {
              users = users.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: Text('country'),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            users.sort((a, b) => a.country.compareTo(b.country));
            if (!_sortAsc) {
              users = users.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: Text('area'),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            users.sort((a, b) => a.area.compareTo(b.area));
            if (!_sortAsc) {
              users = users.reversed.toList();
            }
          });
        },
      ),
    ];
    /* return Stack(
      children: [
        /* Positioned(
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
        ), */
        Positioned(
          top: 10,
          left: 500,
          child: Card(
            color: Colors.white38,
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
                        // style: TextStyle(
                        //   color: Colors.white,
                        // ),
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
                        child: AnimatedCircularChart(
                          key: _chartKey,
                          size: const Size(30.0, 30.0),
                          initialChartData: dataC,
                          chartType: CircularChartType.Radial,
                          // edgeStyle: SegmentEdgeStyle.round,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 80),
          child: Container(
            width: size.width * 0.85,
            height: size.height * 0.825,
            child: Tabla(),
            /* child: JsonTable(
              _json,
              // showColumnToggle: true,
              allowRowHighlight: true,
              rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
              paginationRowCount: 10,
              onRowSelect: (index, map) {
                print(index);
                print(map);
              },
            ), */
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, right: 10),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                clearHive();
              },
              child: Icon(Icons.remove_circle),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 80.0, right: 10),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                _initStorage();
              },
              child: Icon(Icons.star_border),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 160.0, right: 10),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                getFirebaseUsers().then((a) => {
                      // print(['Firebase Users', storage.get('firebaseUsers')]),
                      setState(() {
                        firebaseUsers = a;
                      })
                    });
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 240.0, right: 10),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                getGsuiteUsers(null).then((b) => {
                      readG(),
                      setState(() {
                        gSuiteUsers = gSuiteUsers;
                      })
                    });
              },
              child: Icon(Icons.wrap_text),
            ),
          ),
        ),
      ],
    ); */
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 80, top: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 15, right: 15),
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 60.0, bottom: 8.0),
                                child: Text(
                                  'Simat',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'ArmataRegular',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.deepOrange[400], //.grey[600],
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 60.0, bottom: 8.0),
                                child: Text(
                                  'Firebase',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'ArmataRegular',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.yellow[700], //.grey[600],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Text(
                                  firebaseUsers.toString(),
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 60.0, bottom: 8.0),
                                child: Text(
                                  'G Suite',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'ArmataRegular',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: darkMode
                                        ? Colors.white
                                        : Colors.blue[400], //.grey[600],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Text(
                                  gSuiteUsers.toString(),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 80, top: 140),
          child: Container(
            width: 260,
            height: 40,
            // decoration: BoxDecoration(color: Colors.white),
            child: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              controller: _tabController,
              tabs: myTabs,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 80, top: 185.0, bottom: 10),
          child: Container(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: PagDataTable(
                      header: Text('Mi tabla Gsuite'),
                      columns: columnas,
                      source: DTS(users),
                      showCheckboxColumn: true,
                      onRowsPerPageChanged: (r) {
                        setState(() {
                          _rowPerPage = r;
                        });
                      },
                      rowsPerPage: _rowPerPage,
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAsc,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: DataTable(
                      columnSpacing: 0.0,
                      sortAscending: true,
                      columns: columnas,
                      rows: List<DataRow>.generate(
                        users.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text(users[index].name)),
                            DataCell(Text(users[index].email)),
                            DataCell(Text(users[index].age.toString())),
                            DataCell(Text(users[index].income)),
                            DataCell(Text(users[index].country)),
                            DataCell(Text(users[index].area)),
                          ],
                          selected: simatSelected[index],
                          onSelectChanged: (bool value) {
                            value ? print(index) : null;
                            setState(() {
                              simatSelected[index] = value;
                            });
                          },
                        ),
                      ),
                      /* users
                          .map(
                            (data) => DataRow(
                              cells: [
                                DataCell(Text(data.name)),
                                DataCell(Text(data.email)),
                                DataCell(Text(data.age.toString())),
                                DataCell(Text(data.income)),
                                DataCell(Text(data.country)),
                                DataCell(Text(data.area)),
                              ],
                            ),
                          )
                          .toList(), */
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('Number'),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        numItems,
                        (index) => DataRow(
                          /* color: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            // All rows will have the same selected color.
                            if (states.contains(MaterialState.selected))
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.08);
                            // Even rows will have a grey color.
                            if (index % 2 == 0)
                              return Colors.grey.withOpacity(0.3);
                            return null; // Use default value for other states and odd rows.
                          }), */
                          cells: [DataCell(Text('Row $index'))],
                          selected: selected[index],
                          onSelectChanged: (bool value) {
                            value ? print(index) : null;
                            setState(() {
                              selected[index] = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DTS extends DataTableSource {
  int _selectedCount = 0;
  final List<Filas> _users;
  // final Function onRowSelected;
  DTS(this._users);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _users.length) return null;
    final Filas user = _users[index];
    return DataRow.byIndex(
      selected: user.selected,
      onSelectChanged: (bool value) {
        _selectedCount += value ? 1 : -1;
        assert(_selectedCount >= 0);
        user.selected = value;
        notifyListeners();
        print(['selectedCount', _selectedCount]);
        value ? print(index) : null;
      },
      index: index,
      cells: [
        DataCell(Text(users[index].name)),
        DataCell(Text(users[index].email)),
        DataCell(Text(users[index].age.toString())),
        DataCell(Text(users[index].income)),
        DataCell(Text(users[index].country)),
        DataCell(Text(users[index].area)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
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
String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}

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
    firebaseUsers = result.data['usuarios'].length;
    // print(['firebase', result.data['usuarios'].length]);
    // var _json = json.encode(result.data['usuarios'][0].toString());
    // print(['firebase', 0, result.data['usuarios'][0]['uid']]);
    // print(['firebase', 1, result.data['usuarios'][1]['uid']]);
    await storage.put('firebaseUsers', result.data['usuarios']);
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
    result = await callable.call(
      <String, dynamic>{
        'data': null,
      },
    );
    // usuariosG.add(result.data['data']);
    print(['Resultado', result.data['data'].length]);
    print(['Resultado', 0, result.data['data'][0]]);
    gSuiteUsers += result.data['data'].length;
    // print(['Num users', gSuiteUsers]);
    print(['Num consulta', conta]);
    // print(['UserId - ', conta, ': ', result.data['data']['users'][0].id]);
    conta += 1;
    // print(['Guiste Users previo', result.data['data']]);
    // var _json = json.decode(result.data['data']);
    // print(['Guiste Users', _json]);
    await storage.put('gSuiteUsers', result.data['data']);
    return gSuiteUsers;
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

readG() async {
  var a = await storage.get('gSuiteUsers');
  print(['Gsuite Users', a[0]]);
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
            "description": "A Flutter project.",
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

clearHive() async {
  await storage.close();
  print('Clear storage');
}
