import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:gescolar_dev/models/models.dart';
import 'package:gescolar_dev/widgets/Custom_ExpansionTile/CustomExpansionTile.dart';
import 'package:gescolar_dev/widgets/Neomorphic/clay.dart';
import 'package:gescolar_dev/widgets/Neomorphic/neoButton.dart';
import 'package:gescolar_dev/widgets/Neomorphic/neoCard.dart';
import 'package:gescolar_dev/widgets/custom_switch/custom_switch.dart';
import 'package:gescolar_dev/widgets/multiselect/multiselect_formfield.dart';
import 'package:nm_generators/nm_generators.dart';
import 'package:hive/hive.dart';

//--- variables ------
bool darkMode = false;
const double filtrobtspace = 6.0;
var storage;

class Sedes extends StatefulWidget {
  Sedes({Key key}) : super(key: key);

  @override
  _SedesState createState() => _SedesState();
}

class Test {
  bool grados = false;
  bool areas = false;
  Test({
    this.grados: false,
    this.areas: false,
  });
  Map toJson() => {
        'grados': grados,
        'areas': areas,
      };
}

List<Grado> grados = [];
List<Asignatura> asignaturas = [];
List<Area> areas = [];
List<dynamic> _grados = [];
bool asignaturasTest = false;
Asignatura _asignatura;
Area _area;
Test test = Test(grados: false, areas: false);
final _formKey = GlobalKey<FormState>();
final _procentajeController = TextEditingController();

class _SedesState extends State<Sedes> with SingleTickerProviderStateMixin {
  final ValueNotifier<String> _selectedAnolectivo =
      ValueNotifier<String>('2019');
  // final ValueNotifier<DateTime> selectedDate =
  //     ValueNotifier<DateTime>(DateTime.now());
  void initState() {
    super.initState();
    _loadLocalData();
  }

  _loadLocalData() async {
    grados = [];
    storage = await Hive.openBox('instStorage');
    var gradost = await storage.get('grados');
    var areast = await storage.get('areas');
    if (gradost != null) {
      gradost.forEach((gradot) {
        // print(gradot['nivelEstudios']);
        grados.add(Grado(
          nivelEstudios: gradot['nivelEstudios'],
          nombre: gradot['nombre'],
          codigo: gradot['codigo'],
          siguiente: gradot['siguiente'],
          siguienteTest: gradot['siguienteTest'],
        ));
      });
      setState(() {
        grados = grados;
        test.grados = true;
      });
      print(gradost);
    }
    if (areast != null) {
      areast.forEach((areat) {
        List<Asignatura> asig = [];
        if (areat['asignaturas'] != null) {
          areat['asignaturas'].forEach((asigt) {
            asig.add(Asignatura(
              nombre: asigt['nombre'],
              intHoraria: asigt['intHoraria'],
              porcentaje: asigt['porcentaje'],
            ));
          });
        }
        areas.add(Area(
          nombre: areat['nombre'],
          grados: grados,
          asignaturas: asig,
          obligatoria: areat['obligatoria'],
        ));
      });
      setState(() {
        areas = areas;
        test.areas = true;
      });
      print(areast);
    }
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  int switchValue;
  Widget get gradosList {
    return ListView.builder(
      itemCount: grados.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0, bottom: 2),
                child: Text(grados[index].nombre),
              ),
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text("Editar"),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text("Eliminar"),
                  ),
                ],
                onCanceled: () {
                  print("You have canceled the menu.");
                },
                onSelected: (value) {
                  if (value == 1) {
                    print(['Editado', grados[index].toJson()]);
                    _newGrado(context, 'editar', grados[index], index);
                  } else if (value == 2) {
                    print(['Eliminado', grados[index].toJson()]);
                    _eliminarGrado(context, grados[index], index);
                  }
                },
                // icon: Icon(Icons.list),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget get areasList {
    return ListView.builder(
      itemCount: areas.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var size = MediaQuery.of(context).size;
        return Theme(
          data: temaExpansionTile1,
          child: ExpansionTile(
            title: Text(
              areas[index].nombre,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Colors.redAccent,
                    child: Text(
                      "Eliminar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async => {
                      /* await _newAsignatura(context, 'crear', _area),
                              setState(
                                () => {
                                  _area = _area,
                                  test.areas = true
                                },
                              ) */
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blueAccent[700],
                    child: Text(
                      "Editar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async => {
                      print(['editar', areas[index].toJson()]),
                      await _newArea(context, 'editar', areas[index]),
                      setState(
                        () => {_area = _area, test.areas = true},
                      )
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ],
              ),
              Container(
                width: size.width * 0.165,
                height: (areas[index].asignaturas != null)
                    ? (size.height * 0.075 * areas[index].asignaturas.length)
                    : size.height * 0.075,
                child: (areas[index].asignaturas != null)
                    ? ListView(
                        children: areas[index]
                            .asignaturas
                            .map<Widget>(
                              (asig) => ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(asig.nombre),
                                    Text(asig.intHoraria.toString() + ' hr'),
                                    Text((asig.porcentaje).toString() + '%'),
                                  ],
                                ),
                              ),
                            )
                            .toList())
                    : Container(),
              ),
            ],
          ),
        );
      },
    );
  }

  final BoxDecoration _boxDecoration = BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(
      15.0,
    ),
  );
  final ThemeData temaExpansionTile = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    dividerColor: Colors.transparent,
    primaryColor: Colors.lightBlue[800],
    accentColor: Colors.redAccent[700],
    // Define the default font family.
    // fontFamily: 'Georgia',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );
  final ThemeData temaExpansionTile1 = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    dividerColor: Colors.transparent,
    primaryColor: Colors.lightBlue[800],
    accentColor: Colors.blueAccent[700],
    // Define the default font family.
    // fontFamily: 'Georgia',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );
  final BoxDecoration neumorpDecoration = BoxDecoration(
    color: darkMode ? Colors.grey[850] : Colors.grey[100],
    // borderRadius: BorderRadius.all(Radius.circular(50)),
    borderRadius: BorderRadius.circular(10),
    boxShadow: false
        ? null
        : [
            BoxShadow(
                color: darkMode ? Colors.black54 : Colors.grey[400]
                  ..withOpacity(0.7),
                offset: Offset(2.0, 2.0),
                blurRadius: 5.0,
                spreadRadius: 3.5),
            BoxShadow(
                color: darkMode ? Colors.grey[700] : Colors.white,
                offset: Offset(-3.0, -3.0),
                blurRadius: 5.0,
                spreadRadius: 3.5),
          ],
  );
  // valueListenable: _selectedAnolectivo,
  // var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // double searchWidth = size.width * 0.8;
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints);
        return Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 60, bottom: 10, right: 10),
            // parent container housing all other widgets
            child: Container(
              child: Column(
                children: [
                  // frist container [give it a height, it takes up the width of the parent]
                  Container(
                    // height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClayContainer(
                                onTap: () {
                                  _anolectivo(context);
                                  print(['onTap', _selectedAnolectivo.value]);
                                  setState(() {
                                    _selectedAnolectivo.value =
                                        _selectedAnolectivo.value;
                                  });
                                },
                                color: Colors.grey[100], //..withOpacity(0.0),
                                // emboss: true,
                                padding: 8,
                                borderRadius: 6,
                                child: Text(
                                  'Año ' + _selectedAnolectivo.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      // fontFamily: 'Cheveuxdange',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: darkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ClayContainer(
                                // emboss: true,
                                onTap: () {
                                  _newAnolectivo(context);
                                },
                                color: Colors.grey[100],
                                padding: 0,
                                height: 35,
                                width: 35,
                                borderRadius: 8,
                                child: Icon(Icons.add,
                                    color: Colors.redAccent[700], size: 30),
                                // curveType: CurveType.concave,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    (constraints.maxWidth > 444)
                                        ? FittedBox(
                                            child:
                                                Text("Stanley M. Illidge A."),
                                          )
                                        : Container(),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    FittedBox(
                                      child: Material(
                                        elevation: 4.0,
                                        shape: CircleBorder(),
                                        clipBehavior: Clip.hardEdge,
                                        color: Colors.transparent,
                                        child: Ink.image(
                                          image:
                                              AssetImage('images/monica.png'),
                                          fit: BoxFit.contain,
                                          width: 45.0,
                                          height: 45.0,
                                          child: InkWell(
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // add spacing
                  SizedBox(
                    height: 15,
                  ),

                  // second child of the column [consists of a Row with children]
                  Expanded(
                    child: Row(
                      // row
                      children: [
                        // add spacing
                        SizedBox(
                          // second child
                          width: 15,
                        ),

                        Expanded(
                          // thrid child [consists a column with children ]
                          child: Column(
                            children: [
                              (constraints.maxWidth >= 605)
                                  ? Row(
                                      children: [
                                        Container(
                                          width: 200,
                                          decoration: neumorpDecoration,
                                          child: Column(
                                            children: <Widget>[
                                              // SizedBox(height: 20.0),
                                              Theme(
                                                data: temaExpansionTile,
                                                child: CustomExpansionTile(
                                                  title: Text(
                                                    "Grados",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  // subtitle: Text('dos'),
                                                  // leading: Icon(Icons.grade_rounded),
                                                  children: [
                                                    ListTile(
                                                      title: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: RaisedButton(
                                                              color: Colors
                                                                      .redAccent[
                                                                  700],
                                                              // icon: Icon(Icons.add),
                                                              child: Text(
                                                                "Añadir grado",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              onPressed: () =>
                                                                  _newGrado(
                                                                      context,
                                                                      'crear'),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    gradosList
                                                  ], //grados,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        (test.grados)
                                            ? Container(
                                                width: 250,
                                                decoration: neumorpDecoration,
                                                child: Column(
                                                  children: <Widget>[
                                                    // SizedBox(height: 20.0),
                                                    Theme(
                                                      data: temaExpansionTile,
                                                      child:
                                                          CustomExpansionTile(
                                                        title: Text(
                                                          "Areas y asignaturas",
                                                          style: TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        // subtitle: Text('dos'),
                                                        // leading: Icon(Icons.grade_rounded),
                                                        children: [
                                                          ListTile(
                                                            title: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      RaisedButton(
                                                                    color: Colors
                                                                            .redAccent[
                                                                        700],
                                                                    // icon: Icon(Icons.add),
                                                                    child: Text(
                                                                      "Añadir area",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    onPressed: () =>
                                                                        _newArea(
                                                                            context,
                                                                            'crear'),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          areasList
                                                        ], //grados,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    )
                                  : Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: (constraints.maxWidth > 605)
                                                ? 200
                                                : constraints.maxWidth,
                                            decoration: neumorpDecoration,
                                            child: Column(
                                              children: <Widget>[
                                                // SizedBox(height: 20.0),
                                                Theme(
                                                  data: temaExpansionTile,
                                                  child: CustomExpansionTile(
                                                    title: Text(
                                                      "Grados",
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    // subtitle: Text('dos'),
                                                    // leading: Icon(Icons.grade_rounded),
                                                    children: [
                                                      ListTile(
                                                        title: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  RaisedButton(
                                                                color: Colors
                                                                        .redAccent[
                                                                    700],
                                                                // icon: Icon(Icons.add),
                                                                child: Text(
                                                                  "Añadir grado",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                onPressed: () =>
                                                                    _newGrado(
                                                                        context,
                                                                        'crear'),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      gradosList
                                                    ], //grados,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          (test.grados)
                                              ? Container(
                                                  width: (constraints.maxWidth >
                                                          605)
                                                      ? 250
                                                      : constraints.maxWidth,
                                                  decoration: neumorpDecoration,
                                                  child: Column(
                                                    children: <Widget>[
                                                      // SizedBox(height: 20.0),
                                                      Theme(
                                                        data: temaExpansionTile,
                                                        child:
                                                            CustomExpansionTile(
                                                          title: Text(
                                                            "Areas y asignaturas",
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          // subtitle: Text('dos'),
                                                          // leading: Icon(Icons.grade_rounded),
                                                          children: [
                                                            ListTile(
                                                              title: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child:
                                                                        RaisedButton(
                                                                      color: Colors
                                                                              .redAccent[
                                                                          700],
                                                                      // icon: Icon(Icons.add),
                                                                      child:
                                                                          Text(
                                                                        "Añadir Area",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      onPressed: () => _newArea(
                                                                          context,
                                                                          'crear'),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            areasList
                                                          ], //grados,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                              // add spacing
                              /* SizedBox(
                                // second child
                                height: 20,
                              ),

                              Expanded(
                                // third child [consists of a row with 3 containsers]
                                child: Row(
                                  children: [
                                    Expanded(
                                      // first container
                                      child: Container(
                                        decoration: _boxDecoration,
                                      ),
                                    ),

                                    // add spacing
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      // second container
                                      child: Container(
                                        decoration: _boxDecoration,
                                      ),
                                    ),

                                    // add spacing
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      // third container
                                      child: Container(
                                        decoration: _boxDecoration,
                                      ),
                                    ),
                                  ],
                                ),
                              ), */
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Posiciones _calcPos(BoxConstraints size, [Posiciones pos]) {
    pos = (pos != null) ? pos : Posiciones();
    pos.top = pos.padding.top * 2;
    print(pos.toJson());
    return pos;
  }

  bool checkedValue = false;
  Future _newGrado(context, String action, [Grado grado, int index]) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var validate = true;
        List faltantes = [];
        grado = (grado != null) ? grado : Grado();
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FittedBox(
                    child: DropdownButton<String>(
                      items: <String>[
                        "Preescolar",
                        "Basica Primaria",
                        "Basica Secundaria",
                        "Educacion basica para adultos",
                        "Educacion media",
                        "Educacion media para adultos"
                      ].map((String nvalue) {
                        return DropdownMenuItem<String>(
                          value: nvalue,
                          child: Text(nvalue),
                        );
                      }).toList(),
                      hint: Text('Seleccione un nivel de estudios'),
                      value: grado.nivelEstudios,
                      onChanged: (newValue) {
                        setState(() {
                          grado.nivelEstudios = newValue;
                          // print(newValue);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          child: TextFormField(
                            initialValue: grado.nombre,
                            // controller: _controller,
                            textAlignVertical: TextAlignVertical.center,
                            // autofocus: true,
                            autocorrect: true,
                            onChanged: (value) => {
                              setState(() {
                                // print(value);
                                grado.nombre = value;
                                // _controller.clear();
                              })
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                print(value);
                                grado.nombre = value;
                                // _controller.clear();
                              });
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              labelText: "Nombre del grado",
                              contentPadding: EdgeInsets.all(5),
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          child: TextFormField(
                            initialValue: grado.codigo,
                            // controller: _controller,
                            textAlignVertical: TextAlignVertical.center,
                            // autofocus: true,
                            autocorrect: true,
                            onChanged: (value) => {
                              setState(() {
                                // print(value);
                                grado.codigo = value;
                                // _controller.clear();
                              })
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                print(value);
                                grado.codigo = value;
                                // _controller.clear();
                              });
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              labelText: "Codigo",
                              contentPadding: EdgeInsets.all(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CheckboxListTile(
                    activeColor: Colors.redAccent[700],
                    // checkColor: Colors.redAccent[700],
                    title: Text("Existe un grado siguiente?"),
                    value: grado.siguienteTest,
                    onChanged: (newValue) {
                      setState(() {
                        // checkedValue = newValue;
                        grado.siguienteTest = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  (grado.siguienteTest)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                          child: TextFormField(
                            initialValue: grado.siguiente,
                            // controller: _controller,
                            textAlignVertical: TextAlignVertical.center,
                            // autofocus: true,
                            autocorrect: true,
                            onChanged: (value) => {
                              setState(() {
                                // print(value);
                                grado.siguiente = value;
                                // _controller.clear();
                              })
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                print(value);
                                grado.siguiente = value;
                                // _controller.clear();
                              });
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              labelText: "Nombre del siguiente grado",
                              contentPadding: EdgeInsets.all(5),
                            ),
                          ),
                        )
                      : Container(),
                ],
              );
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0, bottom: 8.0),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent[700]),
                ),
                child: Text(action),
                onPressed: () {
                  validate = true;
                  faltantes = [];
                  grado.toJson().forEach((key, value) {
                    if ((key == 'nivelEstudios' ||
                            key == 'nombre' ||
                            key == 'codigo') &&
                        value == null) {
                      validate = false;
                      faltantes.add(key);
                    }
                  });
                  if (validate) {
                    setState(
                      () => {
                        _adminGrados(grado, action, index),
                        grados = grados,
                        test.grados = true
                      },
                    );
                    print([grado.toJson(), validate]);
                    Navigator.of(context).pop();
                  } else {
                    print([validate, faltantes.toList().toString()]);
                    Fluttertoast.showToast(
                      msg: 'Falta ' + faltantes.toList().toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 4,
                      backgroundColor: Colors.white,
                      webBgColor: '#ffffff',
                      webPosition: 'center',
                      textColor: Colors.redAccent[700],
                      fontSize: 16.0,
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future _eliminarGrado(context, [Grado grado, int index]) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //your code dropdown button here
                  Text('Cuidado'),
                  Text(
                      'Estas intentando eliminar un grado, estas seguro de hacerlo?'),
                ],
              );
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0, bottom: 8.0),
              child: TextButton(
                child: Text('Si, eliminar'),
                onPressed: () {
                  // print(_selectedAnolectivo.value);
                  Navigator.of(context).pop();
                  setState(
                    () => {
                      _adminGrados(grados[index], 'eliminar', index),
                      grados = grados
                    },
                  );
                  return;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 45.0, bottom: 8.0),
              child: TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future _newArea(context, String action, [Area area, int index]) async {
    return await showDialog<void>(
      context: context,
      builder: (context) {
        var validate = true;
        var dataSource = [];
        List faltantes = [];
        asignaturas = [];
        asignaturasTest = false;
        area = (area != null) ? area : Area();
        _area = area;
        if (action == 'crear') {
          area.grados = grados;
        }
        area.grados.forEach((grado) {
          dataSource.add({
            "display": grado.nombre,
            "value": grado.nombre,
          });
        });
        if (action == 'editar') {
          dataSource.forEach((grado) {
            _grados.add(grado['display']);
          });
        }
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              var size = MediaQuery.of(context).size;
              // print(['_area', _area.toJson()]);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                    child: TextFormField(
                      initialValue: _area.nombre,
                      // controller: _controller,
                      textAlignVertical: TextAlignVertical.center,
                      // autofocus: true,
                      autocorrect: true,
                      onChanged: (value) => {
                        setState(() {
                          // print(value);
                          _area.nombre = value;
                          // _controller.clear();
                        })
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          // print(value);
                          _area.nombre = value;
                          // _controller.clear();
                        });
                      },
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "Nombre del area",
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                  MultiSelectFormField(
                    autovalidate: false,
                    titleText: 'Grados',
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Por favor selecciona una o más opciones';
                      }
                      return null;
                    },
                    dataSource: dataSource,
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    // required: true,
                    hintText: 'Por favor selecciona una o más opciones',
                    initialValue: _grados,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        _grados = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Colors.redAccent[700],
                    // checkColor: Colors.redAccent[700],
                    title: Text("Obligatoria"),
                    value: area.obligatoria,
                    onChanged: (newValue) {
                      setState(() {
                        // checkedValue = newValue;
                        _area.obligatoria = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Asignaturas:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      (!asignaturasTest)
                          ? RaisedButton(
                              color: Colors.blueAccent[700],
                              // icon: Icon(Icons.add),
                              child: Text(
                                "Añadir Asignatura",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async => {
                                // print(['crear asig en: ', area.toJson()]),
                                await _newAsignatura(context, 'crear', _area),
                                setState(
                                  () => {
                                    // print([action, asignatura.toJson(), area.toJson()]),
                                    // print(['#3', action, _area.toJson()]),
                                    _area = _area,
                                    test.areas = true
                                  },
                                )
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            )
                          : RaisedButton(
                              color: Colors.grey,
                              // icon: Icon(Icons.add),
                              child: Text(
                                "Añadir Asignatura",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () async => {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width * 0.2,
                    height: (action == 'crear')
                        ? size.height * 0.2
                        : (size.height * 0.06) * _area.asignaturas.length,
                    child: (_area.asignaturas != null)
                        ? Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: ListView(
                                children: _area.asignaturas
                                    .map<Widget>((asig) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(asig.nombre),
                                            Text(asig.intHoraria.toString() +
                                                ' hr'),
                                            Text((asig.porcentaje).toString() +
                                                '%'),
                                            IconButton(
                                              onPressed: () async {
                                                await _newAsignatura(context,
                                                    'editar', _area, asig);
                                                setState(
                                                  () => {
                                                    _area = _area,
                                                    test.areas = true
                                                  },
                                                );
                                              },
                                              icon: Icon(Icons.edit,
                                                  color: Colors.redAccent[400]),
                                            ),
                                          ],
                                        ))
                                    .toList()),
                          )
                        : Container(),
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 15.0, bottom: 8.0),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent[700]),
                ),
                child: Text(action),
                onPressed: () {
                  validate = true;
                  faltantes = [];
                  _area.toJson().forEach((key, value) {
                    if ((key == 'nombre') && value == null) {
                      validate = false;
                      faltantes.add(key);
                    }
                  });
                  if (validate) {
                    setState(
                      () => {
                        _adminAreas(_area, action, index),
                        _area = _area,
                        areas = areas,
                        test.areas = true
                      },
                    );
                    // print([area.toJson(), validate]);
                    Navigator.of(context).pop();
                  } else {
                    // print([validate, faltantes.toList().toString()]);
                    Fluttertoast.showToast(
                      msg: 'Falta ' + faltantes.toList().toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 4,
                      backgroundColor: Colors.white,
                      webBgColor: '#ffffff',
                      webPosition: 'center',
                      textColor: Colors.redAccent[700],
                      fontSize: 16.0,
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future _newAsignatura(context, String action, Area area,
      [Asignatura asignatura, int index]) async {
    return await showDialog<void>(
      context: context,
      builder: (context) {
        var validate = true;
        List faltantes = [];
        asignatura = (asignatura != null) ? asignatura : Asignatura();
        for (var i = 0; i < asignaturas.length; i++) {
          if ((asignatura != null) && (index == null)) {
            // if(asignatura==asignaturas[i]){}
            index = (asignatura.nombre == asignaturas[i].nombre) ? i : null;
          }
          print(
              ['asig', i, index, asignatura.toJson(), asignaturas[i].toJson()]);
        }
        _procentajeController.text = asignatura.porcentaje.toString();
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: 260,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                        child: TextFormField(
                          initialValue: asignatura.nombre,
                          // controller: _procentajeController,
                          textAlignVertical: TextAlignVertical.center,
                          // autofocus: true,
                          autocorrect: true,
                          onChanged: (value) => {
                            setState(() {
                              // print(value);
                              asignatura.nombre = value;
                              // _controller.clear();
                            })
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              // print(value);
                              asignatura.nombre = value;
                              // _controller.clear();
                            });
                          },
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            labelText: "Nombre del asignatura",
                            contentPadding: EdgeInsets.all(5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              child: TextFormField(
                                initialValue: asignatura.intHoraria.toString(),
                                // controller: _controller,
                                textAlignVertical: TextAlignVertical.center,
                                // autofocus: true,
                                autocorrect: true,
                                onChanged: (value) => {
                                  value = (value == '') ? '0' : value,
                                  setState(() {
                                    // print(value);
                                    asignatura.intHoraria = double.parse(value);
                                    // _controller.clear();
                                  })
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    // print(value);
                                    asignatura.intHoraria = double.parse(value);
                                    // _controller.clear();
                                  });
                                },
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: "Intensidad horaria",
                                  helperText: 'Numeros entre 1 - 10',
                                  helperStyle: TextStyle(fontSize: 10),
                                  contentPadding: EdgeInsets.all(5),
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              child: TextFormField(
                                // initialValue: asignatura.porcentaje.toString(),
                                controller: _procentajeController,
                                textAlignVertical: TextAlignVertical.center,
                                // autofocus: true,
                                autocorrect: true,
                                /* validator: (value) {
                                  double p = 0.0;
                                  // print(['asignaturas.length', asignaturas.length]);
                                  switch (action) {
                                    case 'crear':
                                      if (asignaturas.length > 0) {
                                        for (var i = 0;
                                            i < asignaturas.length;
                                            i++) {
                                          p += asignaturas[i].porcentaje;
                                          // print(['p+=', p, i, asignaturas[i].porcentaje]);
                                        }
                                        p += double.parse(value);
                                      } else {
                                        p = double.parse(value);
                                      }
                                      break;
                                    case 'editar':
                                      for (var i = 0;
                                          i < asignaturas.length;
                                          i++) {
                                        p += asignaturas[i].porcentaje;
                                      }
                                      p -= asignaturas[index].porcentaje;
                                      p += double.parse(value);
                                      break;
                                    default:
                                  }
                                  // print(['value', value, p]);
                                  if (p == 100) {
                                    setState(() => {asignaturasTest = true});
                                  } else {
                                    setState(() => {asignaturasTest = false});
                                  }
                                  if (p > 100) {
                                    return 'Solo entre 0 y ' +
                                        (double.parse(value) + (100 - p))
                                            .toString();
                                  } else if (p < 0) {
                                    return 'Solo mayor que cero';
                                  }
                                  return null;
                                }, */
                                onChanged: (value) {
                                  // _procentajeController.text =
                                  //     (value == '') ? '0' : value;
                                  setState(() {
                                    asignatura.porcentaje = (value == '')
                                        ? 0
                                        : double.parse(
                                            _procentajeController.text);
                                  });
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    // print(value);
                                    asignatura.porcentaje = double.parse(
                                        _procentajeController.text);
                                    // _controller.clear();
                                  });
                                },
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: "Porcentaje",
                                  helperText: 'Numeros entre 0 - 100',
                                  errorText: validatePorcentaje(
                                      asignatura.porcentaje,
                                      asignaturas,
                                      action,
                                      index),
                                  helperStyle: TextStyle(fontSize: 10),
                                  contentPadding: EdgeInsets.all(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0, bottom: 8.0),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent[700]),
                ),
                child: Text(action),
                onPressed: () {
                  validate = true;
                  faltantes = [];
                  double p = 0.0;
                  switch (action) {
                    case 'crear':
                      if (asignaturas.length > 0) {
                        for (var i = 0; i < asignaturas.length; i++) {
                          p += asignaturas[i].porcentaje;
                          // print(['p+=', p, i, asignaturas[i].porcentaje]);
                        }
                        p += asignatura.porcentaje;
                      } else {
                        p = asignatura.porcentaje;
                      }
                      break;
                    case 'editar':
                      for (var i = 0; i < asignaturas.length; i++) {
                        p += asignaturas[i].porcentaje;
                      }
                      p -= asignaturas[index].porcentaje;
                      p += asignatura.porcentaje;
                      break;
                    default:
                  }
                  // print(['asignatura.porcentaje', asignatura.porcentaje, p]);
                  if (p == 100) {
                    setState(() => {asignaturasTest = true});
                  } else {
                    setState(() => {asignaturasTest = false});
                  }
                  print(['asignaturas.length', asignaturas.length, p]);
                  asignatura.toJson().forEach((key, value) {
                    if ((key == 'nombre') && value == null) {
                      validate = false;
                      faltantes.add(key);
                    }
                  });
                  if (validate && (p <= 100)) {
                    // if (_formKey.currentState.validate()) {
                    setState(
                      () {
                        // print([action, asignatura.toJson(), area.toJson()]),
                        if (action == 'crear') {
                          asignaturas.add(asignatura);
                        } else if (action == 'editar') {
                          asignaturas[index] = asignatura;
                        }
                        _adminAsignaturas(area, asignatura, action, index);
                        _procentajeController.clear();
                        _area = _area;
                        areas = areas;
                        test.areas = true;
                      },
                    );
                    // print([asignatura.toJson(), validate]);
                    Navigator.of(context).pop();
                    // }
                  } else if (!validate) {
                    // print([validate, faltantes.toList().toString()]);
                    Fluttertoast.showToast(
                      msg: 'Falta ' + faltantes.toList().toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 4,
                      backgroundColor: Colors.white,
                      webBgColor: '#ffffff',
                      webPosition: 'center',
                      textColor: Colors.redAccent[700],
                      fontSize: 16.0,
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future _anolectivo(context) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //your code dropdown button here
                  Text('Grados'),
                  DropdownButton<String>(
                    items: <String>["2019", "2020"].map((String nvalue) {
                      return DropdownMenuItem<String>(
                        value: nvalue,
                        child: Text(nvalue),
                      );
                    }).toList(),
                    hint: Text('Seleccione un año lectivo'),
                    value: _selectedAnolectivo.value,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedAnolectivo.value = newValue;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0, bottom: 8.0),
              child: TextButton(
                child: Text('ok'),
                onPressed: () {
                  // print(_selectedAnolectivo.value);
                  Navigator.of(context).pop();
                  setState(() {
                    _selectedAnolectivo.value = _selectedAnolectivo.value;
                  });
                  return _selectedAnolectivo.value;
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future _newAnolectivo(context) async {
    AnoLectivo anoLectivo = AnoLectivo();
    anoLectivo.inicio = DateTime.now();
    anoLectivo.fin = DateTime.now();
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              _selectDate(BuildContext context, String campo) async {
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: (campo == 'inicio')
                      ? anoLectivo.inicio
                      : anoLectivo.fin, // Refer step 1
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );
                if (picked != null &&
                    picked !=
                        ((campo == 'inicio')
                            ? anoLectivo.inicio
                            : anoLectivo.fin))
                  setState(() {
                    (campo == 'inicio')
                        ? anoLectivo.inicio = picked
                        : anoLectivo.fin = picked;
                  });
                return ((campo == 'inicio')
                    ? anoLectivo.inicio
                    : anoLectivo.fin);
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    // controller: _controller,
                    textAlignVertical: TextAlignVertical.center,
                    // autofocus: true,
                    autocorrect: true,
                    onChanged: (value) => {
                      setState(() {
                        // print(value);
                        anoLectivo.nombre = value;
                        // _controller.clear();
                      })
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        // print(value);
                        anoLectivo.nombre = value;
                        // _controller.clear();
                      });
                    },
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: "Nombre",
                      contentPadding: EdgeInsets.all(5),
                    ),
                  ),
                  SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Inicio: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        anoLectivo.inicio.toLocal().toString().split(' ')[0],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          _selectDate(context, 'inicio');
                          setState(() {
                            anoLectivo.inicio = anoLectivo.inicio;
                          });
                        },
                        icon: Icon(Icons.calendar_today_rounded,
                            color: Colors.redAccent[700], size: 20),
                      ),
                    ],
                  ),
                  SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fin:     ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        anoLectivo.fin.toLocal().toString().split(' ')[0],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          _selectDate(context, 'fin');
                          setState(() {
                            anoLectivo.fin = anoLectivo.fin;
                          });
                        },
                        icon: Icon(Icons.calendar_today_rounded,
                            color: Colors.redAccent[700], size: 20),
                      ),
                    ],
                  ),
                  SizedBox(),
                  /* CheckboxListTile(
                    title: Text("Activo"),
                    value: anoLectivo.activo,
                    onChanged: (newValue) {
                      setState(() {
                        anoLectivo.activo = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ), */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Activo',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                      CustomSwitch(
                        activeColor: Colors.redAccent[700],
                        value: anoLectivo.activo,
                        onChanged: (value) {
                          print("VALUE : $value");
                          setState(() {
                            anoLectivo.activo = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0, bottom: 8.0),
              child: TextButton(
                child: Text('ok'),
                onPressed: () {
                  print('ok');
                  print(anoLectivo.toJson());
                  Navigator.of(context).pop();
                  setState(() {
                    anoLectivo = anoLectivo;
                  });
                  return anoLectivo;
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String validatePorcentaje(double value,
      [dynamic asignaturas, String action, int index]) {
    double p = 0.0;
    // print(['asignaturas.length', asignaturas.length]);
    switch (action) {
      case 'crear':
        if (asignaturas.length > 0) {
          for (var i = 0; i < asignaturas.length; i++) {
            p += asignaturas[i].porcentaje;
            // print(['p+=', p, i, asignaturas[i].porcentaje]);
          }
          p += value;
        } else {
          p = value;
        }
        break;
      case 'editar':
        for (var i = 0; i < asignaturas.length; i++) {
          p += asignaturas[i].porcentaje;
        }
        p -= asignaturas[index].porcentaje;
        p += value;
        break;
      default:
    }
    print(['value', value, p]);
    if (p > 100) {
      // _procentajeController.text = (value + (100 - p)).toString();
      return 'Solo entre 0 y ' + (value + (100 - p)).toString();
    } else if (p < 0) {
      // _procentajeController.text = '0';
      return 'Solo mayor que cero';
    }
    return null;
  }
}

_adminGrados(Grado grado, String action, [int index]) async {
  switch (action) {
    case 'crear':
      grados.add(grado);
      break;
    case 'editar':
      grados[index] = Grado(
        nivelEstudios: grado.nivelEstudios,
        nombre: grado.nombre,
        codigo: grado.codigo,
        siguiente: grado.siguiente,
        siguienteTest: grado.siguienteTest,
      );
      break;
    case 'eliminar':
      grados.removeAt(index);
      break;
    default:
  }
  var gs = [];
  grados.forEach((gradot) {
    gs.add(gradot.toJson());
  });
  try {
    await storage.put('grados', gs);
  } catch (e) {
    print(['Error grados', e]);
  }
}

_adminAreas(Area area, String action, [int index]) async {
  switch (action) {
    case 'crear':
      areas.add(area);
      break;
    case 'editar':
      areas[index] = Area(
        nombre: area.nombre,
        grados: area.grados,
        asignaturas: area.asignaturas,
        obligatoria: area.obligatoria,
      );
      break;
    case 'eliminar':
      areas.removeAt(index);
      break;
    default:
  }
  var gs = [];
  areas.forEach((areat) {
    gs.add(areat.toJson());
  });
  try {
    await storage.put('areas', gs);
  } catch (e) {
    print(['Error areas', e]);
  }
}

_adminAsignaturas(Area area, Asignatura asignatura, String action,
    [int index]) async {
  _area = area;
  _asignatura = asignatura;
  print([action, index, asignatura.toJson(), area.toJson()]);
  switch (action) {
    case 'crear':
      if (_area.asignaturas == null) {
        _area.asignaturas = [];
      }
      _area.asignaturas.add(asignatura);
      break;
    case 'editar':
      _area.asignaturas[index] = Asignatura(
        nombre: asignatura.nombre,
        intHoraria: asignatura.intHoraria,
        porcentaje: asignatura.porcentaje,
      );
      break;
    case 'eliminar':
      _area.asignaturas.removeAt(index);
      break;
    default:
  }
  /* var gs = [];
  areas.forEach((areat) {
    gs.add(areat.toJson());
  });
  try {
    await storage.put('areas', gs);
  } catch (e) {
    print(['Error areas', e]);
  } */
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function() onTap;

  const CustomCard({Key key, this.child, this.color, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
          child: Padding(child: child, padding: EdgeInsets.all(20)),
          onTap: onTap,
          borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.grey,
      elevation: 12,
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String text;

  HeaderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(text),
      color: Colors.grey[200],
    );
  }
}

class BodyWidget extends StatelessWidget {
  final Color color;

  BodyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: color,
      alignment: Alignment.center,
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final appBarSize = expandedHeight - shrinkOffset;
    // final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    // final proportion = 2 - (expandedHeight / appBarSize);
    // final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return Stack(
      children: [
        AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          elevation: 4.0,
          title: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            // autofocus: true,
            autocorrect: true,
            onChanged: (value) => {print('onChanged')},
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
                size: 20.0,
              ),
              /* suffixIcon: IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  debugPrint('222');
                },
              ), */
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "Incluir",
            ),
          ),
        ),
        /* SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              backgroundColor: Colors.green,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              elevation: 0.0,
              title: Opacity(
                  opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                  child: Text("Test")),
            ),
          ), */
        /* Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                child: Card(
                  elevation: 20.0,
                  child: Center(
                    child: Text("Header"),
                  ),
                ),
              ),
            ),
          ), */
      ],
    );
    /* return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          AppBar(
            backgroundColor: Colors.green,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            elevation: 0.0,
            title: Text("Test"),
          ),
          /* SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              backgroundColor: Colors.green,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              elevation: 0.0,
              title: Opacity(
                  opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                  child: Text("Test")),
            ),
          ), */
          /* Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                child: Card(
                  elevation: 20.0,
                  child: Center(
                    child: Text("Header"),
                  ),
                ),
              ),
            ),
          ), */
        ],
      ),
    ); */
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
