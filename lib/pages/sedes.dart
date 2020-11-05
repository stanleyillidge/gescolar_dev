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
import 'package:nm_generators/nm_generators.dart';

//--- variables ------
bool darkMode = false;
const double filtrobtspace = 6.0;

class Sedes extends StatefulWidget {
  Sedes({Key key}) : super(key: key);

  @override
  _SedesState createState() => _SedesState();
}

List<NewGrado> grados2 = [];

class _SedesState extends State<Sedes> with SingleTickerProviderStateMixin {
  final ValueNotifier<String> _selectedAnolectivo =
      ValueNotifier<String>('2019');
  // final ValueNotifier<DateTime> selectedDate =
  //     ValueNotifier<DateTime>(DateTime.now());
  void initState() {
    super.initState();
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
      itemCount: grados2.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0, bottom: 2),
                child: Text(grados2[index].nombre),
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
                    print(['Editado', grados2[index].toJson()]);
                    _newGrado(context, grados2[index]);
                  } else if (value == 2) {
                    print(['Eliminado', grados2[index].toJson()]);
                    _newGrado(context, grados2[index]);
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

  final BoxDecoration _boxDecoration = BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(
      15.0,
    ),
  );
  // valueListenable: _selectedAnolectivo,
  // var _controller = TextEditingController();
  @override
  /* Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double searchWidth = size.width * 0.8;
    return Stack(
      children: [
        Positioned(
          top: 15,
          left: 80,
          right: searchWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /* NeumorphicButton(
                onTap: () {
                  _anolectivo(context);
                  print(['onTap', _selectedAnolectivo.value]);
                  setState(() {
                    _selectedAnolectivo.value = _selectedAnolectivo.value;
                  });
                },
                darkMode: darkMode,
                padding: 10,
                bevel: 5,
                background: Colors.grey[100],
                child: Text(
                  'Año ' + _selectedAnolectivo.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      // fontFamily: 'Cheveuxdange',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: darkMode ? Colors.white : Colors.black),
                ),
              ), */
              ClayContainer(
                onTap: () {
                  _anolectivo(context);
                  print(['onTap', _selectedAnolectivo.value]);
                  setState(() {
                    _selectedAnolectivo.value = _selectedAnolectivo.value;
                  });
                },
                color: Colors.grey[200], //..withOpacity(0.0),
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
                      color: darkMode ? Colors.white : Colors.black),
                ),
              ),
              // Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ClayContainer(
                  // emboss: true,
                  onTap: () {
                    _newAnolectivo(context);
                  },
                  color: Colors.grey[200],
                  padding: 0,
                  height: 35,
                  width: 35,
                  borderRadius: 8,
                  child:
                      Icon(Icons.add, color: Colors.redAccent[700], size: 30),
                  // curveType: CurveType.concave,
                ),
              ),
            ],
          ),
          /* child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            // autofocus: true,
            autocorrect: true,
            onChanged: (value) => {
              setState(() {
                // Filtrar los estudiantes de la tabla
              })
            },
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              /* prefixIcon: Icon(
                Icons.account_box,
                size: 20.0,
              ), */
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  debugPrint('222');
                },
              ),
              isDense: true, // Added this
              contentPadding: EdgeInsets.only(left: 18, top: 0, bottom: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "Buscar",
            ),
          ), */
        ),
        Positioned(
          top: 15,
          left: size.width * 0.8,
          right: 0,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: filtrobtspace * 9, right: filtrobtspace),
                        child: Text("Stanley M. Illidge A."),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('images/monica.png'),
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
        ),
        /* Positioned(
          top: 70,
          left: 80,
          right: searchWidth,
          child: Container(
            decoration: BoxDecoration(
              color: darkMode ? Colors.grey[850] : Colors.grey[300],
              // borderRadius: BorderRadius.all(Radius.circular(50)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: false
                  ? null
                  : [
                      BoxShadow(
                          color: darkMode ? Colors.black54 : Colors.grey,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: darkMode ? Colors.grey[800] : Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                    ],
            ),
            height: 200,
            /* child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      HeaderWidget("Header 1"),
                      HeaderWidget("Header 2"),
                      HeaderWidget("Header 3"),
                      HeaderWidget("Header 4"),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      BodyWidget(Colors.blue),
                      BodyWidget(Colors.red),
                      BodyWidget(Colors.green),
                      BodyWidget(Colors.orange),
                      BodyWidget(Colors.blue),
                      BodyWidget(Colors.red),
                    ],
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  delegate: SliverChildListDelegate(
                    [
                      BodyWidget(Colors.blue),
                      BodyWidget(Colors.green),
                      BodyWidget(Colors.yellow),
                      BodyWidget(Colors.orange),
                      BodyWidget(Colors.blue),
                      BodyWidget(Colors.red),
                    ],
                  ),
                ),
              ],
            ), */
          ),
        ), */
        Positioned(
          top: 70,
          left: 80,
          right: size.width * 0.75,
          child: Container(
            decoration: BoxDecoration(
              color: darkMode ? Colors.grey[850] : Colors.grey[100],
              // borderRadius: BorderRadius.all(Radius.circular(50)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: false
                  ? null
                  : [
                      BoxShadow(
                          color: darkMode ? Colors.black54 : Colors.grey[500]
                            ..withOpacity(0.7),
                          offset: Offset(4.0, 4.0),
                          blurRadius: 6.0,
                          spreadRadius: 3.5),
                      BoxShadow(
                          color: darkMode ? Colors.grey[700] : Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 6.0,
                          spreadRadius: 3.5),
                    ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  // SizedBox(height: 20.0),
                  CustomExpansionTile(
                    title: Text(
                      "Grados",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text('dos'),
                    // leading: Icon(Icons.grade_rounded),
                    children: grados,
                    /* <Widget>[
                      ListTile(
                        title: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              // autofocus: true,
                              autocorrect: true,
                              onChanged: (value) => {
                                setState(() {
                                  // Filtrar los estudiantes de la tabla
                                })
                              },
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_box,
                                  size: 16.0,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    debugPrint('222');
                                  },
                                ),
                                isDense: true, // Added this
                                contentPadding: EdgeInsets.all(0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: "Grados",
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('602'),
                            ),
                            PopupMenuButton<int>(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: Text(
                                      "Editar"), // (users[index].editado) ? Text("Guardar") : Text("Editar"),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Text("Abrir"),
                                ),
                              ],
                              onCanceled: () {
                                print("You have canceled the menu.");
                              },
                              onSelected: (value) {
                                if (value == 1) {
                                  print('Editado');
                                  // users[index].editado = !users[index].editado;
                                  // notifyListeners();
                                } else if (value == 2) {
                                  print('Abrir');
                                  /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditUser(),
                                    ),
                                  ); */
                                }
                              },
                              // icon: Icon(Icons.list),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('602'),
                            ),
                            PopupMenuButton<int>(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: Text(
                                      "Editar"), // (users[index].editado) ? Text("Guardar") : Text("Editar"),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Text("Abrir"),
                                ),
                              ],
                              onCanceled: () {
                                print("You have canceled the menu.");
                              },
                              onSelected: (value) {
                                if (value == 1) {
                                  print('Editado');
                                  // users[index].editado = !users[index].editado;
                                  // notifyListeners();
                                } else if (value == 2) {
                                  print('Abrir');
                                  /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditUser(),
                                    ),
                                  ); */
                                }
                              },
                              // icon: Icon(Icons.list),
                            ),
                          ],
                        ),
                      ),
                    ], */
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 70,
          left: size.width - (size.width * 0.725),
          right: size.width * 0.525,
          child: Container(
            decoration: BoxDecoration(
              color: darkMode ? Colors.grey[850] : Colors.blue[100]
                ..withOpacity(0.3),
              // borderRadius: BorderRadius.all(Radius.circular(50)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: false
                  ? null
                  : [
                      BoxShadow(
                          color: darkMode ? Colors.black54 : Colors.grey[500]
                            ..withOpacity(0.7),
                          offset: Offset(4.0, 4.0),
                          blurRadius: 6.0,
                          spreadRadius: 3.5),
                      BoxShadow(
                          color: darkMode ? Colors.grey[700] : Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 6.0,
                          spreadRadius: 3.5),
                    ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                    accentColor: Colors.black45,
                    unselectedWidgetColor: Colors.black45..withOpacity(0.1)),
                child: ExpansionTile(
                  title: Text("Padding"),
                  children: <Widget>[
                    Text("Left"),
                    Text("Top"),
                    Text("Right"),
                    Text("Bottom"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  } */
  /* Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: FluidLayout(
          child: Builder(
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding:
                    // const EdgeInsets.only(left: 80.0, top: 20),
                    EdgeInsets.symmetric(
                        horizontal: 0.0,
                        vertical: FluidLayout.of(context).horizontalPadding),
                child: FluidGridView(
                  shrinkWrap: true,
                  children: [
                    FluidCell.withFluidHeight(
                      size: context.fluid(3, m: 2, s: 2, xs: 4),
                      heightSize: context.fluid(1, m: 1, s: 1, xs: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /* NeumorphicButton(
                            onTap: () {
                              _anolectivo(context);
                              print(['onTap', _selectedAnolectivo.value]);
                              setState(() {
                                _selectedAnolectivo.value =
                                    _selectedAnolectivo.value;
                              });
                            },
                            darkMode: darkMode,
                            padding: 10,
                            bevel: 5,
                            background: Colors.grey[100],
                            child: Text(
                              'Año ' + _selectedAnolectivo.value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  // fontFamily: 'Cheveuxdange',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      darkMode ? Colors.white : Colors.black),
                            ),
                          ), */
                          ClayContainer(
                            onTap: () {
                              _anolectivo(context);
                              print(['onTap', _selectedAnolectivo.value]);
                              setState(() {
                                _selectedAnolectivo.value =
                                    _selectedAnolectivo.value;
                              });
                            },
                            color: Colors.grey[200], //..withOpacity(0.0),
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
                                  color:
                                      darkMode ? Colors.white : Colors.black),
                            ),
                          ),
                          // Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: ClayContainer(
                              // emboss: true,
                              onTap: () {
                                _newAnolectivo(context);
                              },
                              color: Colors.grey[200],
                              padding: 0,
                              height: 35,
                              width: 35,
                              borderRadius: 8,
                              child: Icon(Icons.add,
                                  color: Colors.redAccent[700], size: 30),
                              // curveType: CurveType.concave,
                            ),
                          ),
                        ],
                      ),
                      /* child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        // autofocus: true,
                        autocorrect: true,
                        onChanged: (value) => {
                          setState(() {
                            // Filtrar los estudiantes de la tabla
                          })
                        },
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_box,
                            size: 20.0,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              debugPrint('222');
                            },
                          ),
                          isDense: true, // Added this
                          contentPadding:
                              EdgeInsets.only(left: 18, top: 0, bottom: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: "Buscar",
                        ),
                      ), */
                    ),
                    FluidCell.withFluidHeight(
                      size: context.fluid(7, m: 8, s: 7, xs: 3),
                      heightSize: context.fluid(2, m: 2, s: 2, xs: 3),
                      child: Container(),
                    ),
                    FluidCell.withFluidHeight(
                      size: context.fluid(2, m: 3, s: 3, xs: 5),
                      heightSize: context.fluid(2, m: 2, s: 2, xs: 3),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                /* Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: filtrobtspace * 9,
                                        right: filtrobtspace),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      // autofocus: true,
                                      autocorrect: true,
                                      onChanged: (value) => {
                                        setState(() {
                                          // Filtrar los estudiantes de la tabla
                                        })
                                      },
                                      style: TextStyle(fontSize: 16),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_box,
                                          size: 20.0,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.search),
                                          onPressed: () {
                                            debugPrint('222');
                                          },
                                        ),
                                        isDense: true, // Added this
                                        contentPadding: EdgeInsets.only(
                                            left: 18, top: 0, bottom: 0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        labelText: "Buscar",
                                      ),
                                    ),
                                  ),
                                ), */
                                Expanded(
                                  // flex: 2,
                                  /* child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80, right: 3),
                                    child: Text("Stanley M. Illidge A."),
                                  ), */
                                  child: Text("Stanley M. Illidge A."),
                                ),
                                Expanded(
                                  child: Material(
                                    elevation: 4.0,
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.hardEdge,
                                    color: Colors.transparent,
                                    child: Ink.image(
                                      image: AssetImage('images/monica.png'),
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
                    ),
                    FluidCell.withFluidHeight(
                      size: context.fluid(3, m: 3, s: 4, xs: 6),
                      heightSize: context.fluid(2, m: 2, s: 2, xs: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: darkMode ? Colors.grey[850] : Colors.grey[100],
                          // borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: false
                              ? null
                              : [
                                  BoxShadow(
                                      color: darkMode
                                          ? Colors.black54
                                          : Colors.grey[400]
                                        ..withOpacity(0.7),
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0,
                                      spreadRadius: 3.5),
                                  BoxShadow(
                                      color: darkMode
                                          ? Colors.grey[700]
                                          : Colors.white,
                                      offset: Offset(-3.0, -3.0),
                                      blurRadius: 5.0,
                                      spreadRadius: 3.5),
                                ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              // SizedBox(height: 20.0),
                              Theme(
                                data: ThemeData(
                                  // Define the default brightness and colors.
                                  brightness: Brightness.light,
                                  primaryColor: Colors.lightBlue[800],
                                  accentColor: Colors
                                      .redAccent[700], // Colors.cyan[600],

                                  // Define the default font family.
                                  // fontFamily: 'Georgia',

                                  // Define the default TextTheme. Use this to specify the default
                                  // text styling for headlines, titles, bodies of text, and more.
                                  textTheme: TextTheme(
                                    headline1: TextStyle(
                                        fontSize: 72.0,
                                        fontWeight: FontWeight.bold),
                                    headline6: TextStyle(
                                        fontSize: 36.0,
                                        fontStyle: FontStyle.italic),
                                    bodyText2: TextStyle(
                                        fontSize: 14.0, fontFamily: 'Hind'),
                                  ),
                                ),
                                child: CustomExpansionTile(
                                  title: Text(
                                    "Grados",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // subtitle: Text('dos'),
                                  // leading: Icon(Icons.grade_rounded),
                                  children: grados,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      /* body: Column(
        children: [
          FluidLayout(
            child: Builder(
              builder: (context) => CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                      child:
                          SizedBox(height: context.fluid(60, xs: 12, s: 12))),
                  /* SliverFluidGrid(
                    children: [
                      if (context.breakpoint.isSmallerThanM)
                        FluidCell.fit(
                          size: context.fluid(12),
                          child: CustomCard(
                            child: Container(
                              height: 100,
                              child: Center(
                                  child: Text('Only visible in small screens')),
                            ),
                          ),
                        ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(12),
                        heightSize: context.fluid(4),
                        child: CustomCard(
                          color: Colors.green,
                          child: Center(child: Text('Header')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 3, s: 6, xs: 6),
                        heightSize: context.fluid(3, m: 3, s: 6, xs: 6),
                        child: CustomCard(
                          child: Center(child: Text('A')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 3, s: 6, xs: 6),
                        heightSize: context.fluid(3, m: 3, s: 4, xs: 4),
                        child: CustomCard(
                          child: Center(child: Text('B')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 3, s: 6, xs: 6),
                        heightSize: context.fluid(3, m: 3, s: 6, xs: 6),
                        child: CustomCard(
                          child: Center(child: Text('C')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 3, s: 6, xs: 6),
                        heightSize: context.fluid(3, m: 3, s: 4, xs: 4),
                        child: CustomCard(
                          child: Center(child: Text('D')),
                        ),
                      ),
                      FluidCell.withFixedHeight(
                        size: context.fluid(12),
                        height: 1,
                        child: Container(
                          color: Colors.black12,
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 6, s: 12, xs: 12),
                        heightSize: 3,
                        child: CustomCard(
                          color: Colors.green,
                          child: Center(child: Text('1')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 6, s: 6, xs: 6),
                        heightSize: context.fluid(1.45, s: 2, xs: 2),
                        child: CustomCard(
                          child: Center(child: Text('2')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 6, s: 6, xs: 6),
                        heightSize: context.fluid(1.45, s: 2, xs: 2),
                        child: CustomCard(
                          child: Center(child: Text('3')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 6, s: 6, xs: 6),
                        heightSize: context.fluid(1.45, s: 2, xs: 2),
                        child: CustomCard(
                          child: Center(child: Text('4')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 6, s: 6, xs: 6),
                        heightSize: context.fluid(1.45, s: 2, xs: 2),
                        child: CustomCard(
                          child: Center(child: Text('5')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 6, s: 6, xs: 6),
                        heightSize: context.fluid(1.45, s: 2, xs: 2),
                        child: CustomCard(
                          child: Center(child: Text('6')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 6, s: 6, xs: 6),
                        heightSize: context.fluid(1.45, s: 2, xs: 2),
                        child: CustomCard(
                          child: Center(child: Text('7')),
                        ),
                      ),
                      FluidCell.withFixedHeight(
                        size: 12,
                        height: 150,
                        child: CustomCard(
                          color: Colors.green,
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(2, l: 2, m: 4, s: 3, xs: 4),
                        heightSize: context.fluid(2, l: 2, m: 3, s: 3, xs: 4),
                        child: CustomCard(
                          child: Center(child: Text('I')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(2, l: 2, m: 4, s: 3, xs: 4),
                        heightSize: context.fluid(2, l: 2, m: 3, s: 3, xs: 4),
                        child: CustomCard(
                          child: Center(child: Text('I')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(2, l: 2, m: 4, s: 3, xs: 4),
                        heightSize: context.fluid(2, l: 2, m: 3, s: 3, xs: 4),
                        child: CustomCard(
                          child: Center(child: Text('I')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(2, l: 2, m: 4, s: 3, xs: 4),
                        heightSize: context.fluid(2, l: 2, m: 3, s: 3, xs: 4),
                        child: CustomCard(
                          child: Center(child: Text('I')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(2, l: 2, m: 4, s: 3, xs: 4),
                        heightSize: context.fluid(2, l: 2, m: 3, s: 3, xs: 4),
                        child: CustomCard(
                          child: Center(child: Text('I')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(2, l: 2, m: 4, s: 3, xs: 4),
                        heightSize: context.fluid(2, l: 2, m: 3, s: 3, xs: 4),
                        child: CustomCard(
                          child: Center(child: Text('I')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(4, s: 12, xs: 12),
                        heightSize: context.fluid(4, s: 12, xs: 12),
                        child: CustomCard(
                          child: Center(child: Text('A')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(4, s: 12, xs: 12),
                        heightSize: context.fluid(4, s: 12, xs: 12),
                        child: CustomCard(
                          child: Center(child: Text('B')),
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(4, s: 12, xs: 12),
                        heightSize: context.fluid(4, s: 12, xs: 12),
                        child: CustomCard(
                          child: Center(child: Text('C')),
                        ),
                      ),
                    ],
                  ), */
                  SliverFluidGrid(
                    // spacing: 5.0,
                    // horizontalPadding: 20.0,
                    children: [
                      FluidCell.withFluidHeight(
                        size: context.fluid(3, m: 2, s: 2, xs: 4),
                        heightSize: context.fluid(1, m: 1, s: 1, xs: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              color: Colors.grey[200], //..withOpacity(0.0),
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
                                    color:
                                        darkMode ? Colors.white : Colors.black),
                              ),
                            ),
                            // Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: ClayContainer(
                                // emboss: true,
                                onTap: () {
                                  _newAnolectivo(context);
                                },
                                color: Colors.grey[200],
                                padding: 0,
                                height: 35,
                                width: 35,
                                borderRadius: 8,
                                child: Icon(Icons.add,
                                    color: Colors.redAccent[700], size: 30),
                                // curveType: CurveType.concave,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(7, m: 8, s: 7, xs: 3),
                        heightSize: context.fluid(2, m: 2, s: 2, xs: 3),
                        child: Container(),
                      ),
                      FluidCell.withFluidHeight(
                        size: context.fluid(2, m: 3, s: 3, xs: 5),
                        heightSize: context.fluid(2, m: 2, s: 2, xs: 3),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    // flex: 2,
                                    child: Text("Stanley M. Illidge A."),
                                  ),
                                  Expanded(
                                    child: Material(
                                      elevation: 4.0,
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.hardEdge,
                                      color: Colors.transparent,
                                      child: Ink.image(
                                        image: AssetImage('images/monica.png'),
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
                      ),
                      /* FluidCell.fit(
                        size: context.fluid(3, m: 3, s: 4, xs: 6),
                        // height: context.fluid(50, m: 50, s: 50, xs: 50),
                        child: Text('Hola mundo'),
                        /* child: Container(
                          decoration: BoxDecoration(
                            color: darkMode ? Colors.grey[850] : Colors.grey[100],
                            // borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: false
                                ? null
                                : [
                                    BoxShadow(
                                        color: darkMode
                                            ? Colors.black54
                                            : Colors.grey[400]
                                          ..withOpacity(0.7),
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 5.0,
                                        spreadRadius: 3.5),
                                    BoxShadow(
                                        color: darkMode
                                            ? Colors.grey[700]
                                            : Colors.white,
                                        offset: Offset(-3.0, -3.0),
                                        blurRadius: 5.0,
                                        spreadRadius: 3.5),
                                  ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: <Widget>[
                                // SizedBox(height: 20.0),
                                Theme(
                                  data: ThemeData(
                                    // Define the default brightness and colors.
                                    brightness: Brightness.light,
                                    primaryColor: Colors.lightBlue[800],
                                    accentColor:
                                        Colors.redAccent[700], // Colors.cyan[600],

                                    // Define the default font family.
                                    // fontFamily: 'Georgia',

                                    // Define the default TextTheme. Use this to specify the default
                                    // text styling for headlines, titles, bodies of text, and more.
                                    textTheme: TextTheme(
                                      headline1: TextStyle(
                                          fontSize: 72.0,
                                          fontWeight: FontWeight.bold),
                                      headline6: TextStyle(
                                          fontSize: 36.0,
                                          fontStyle: FontStyle.italic),
                                      bodyText2: TextStyle(
                                          fontSize: 14.0, fontFamily: 'Hind'),
                                    ),
                                  ),
                                  child: CustomExpansionTile(
                                    title: Text(
                                      "Grados",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // subtitle: Text('dos'),
                                    // leading: Icon(Icons.grade_rounded),
                                    children: grados,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ), */
                      ), */
                    ],
                  ),
                  /* SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      color: Colors.green,
                      height: 200,
                      child: Center(child: Text('Expanded')),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 40)),
                  context.breakpoint.isLargerThanM
                      ? SliverFluid(
                          sliver: SliverToBoxAdapter(
                            child: CustomCard(
                              child: Container(
                                height: 300,
                                child: Center(
                                    child: Text('Only visible in large screen')),
                              ),
                            ),
                          ),
                        )
                      : SliverToBoxAdapter(child: Container()),
                  SliverToBoxAdapter(child: SizedBox(height: 40)), */
                ],
              ),
            ),
          ),
        ],
      ), */
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  } */
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // double searchWidth = size.width * 0.8;
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints);
        // _calcPos(constraints);
        /* return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 15,
                left: 80,
                right: constraints.maxWidth - 220,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClayContainer(
                      onTap: () {
                        _anolectivo(context);
                        print(['onTap', _selectedAnolectivo.value]);
                        setState(() {
                          _selectedAnolectivo.value = _selectedAnolectivo.value;
                        });
                      },
                      color: Colors.grey[200], //..withOpacity(0.0),
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
                            color: darkMode ? Colors.white : Colors.black),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0), //15
                      child: ClayContainer(
                        // emboss: true,
                        onTap: () {
                          _newAnolectivo(context);
                        },
                        color: Colors.grey[200],
                        padding: 0,
                        height: 35,
                        width: 35,
                        borderRadius: 8,
                        child: Icon(Icons.add,
                            color: Colors.redAccent[700], size: 30),
                        // curveType: CurveType.concave,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 15,
                left: (constraints.maxWidth > 444)
                    ? (constraints.maxWidth - 180)
                    : (constraints.maxWidth - 60), //size.width * 0.8,
                right: 0,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          (constraints.maxWidth > 444)
                              ? FittedBox(
                                  child: Text("Stanley M. Illidge A."),
                                )
                              : Container(),
                          FittedBox(
                            child: Material(
                              elevation: 4.0,
                              shape: CircleBorder(),
                              clipBehavior: Clip.hardEdge,
                              color: Colors.transparent,
                              child: Ink.image(
                                image: AssetImage('images/monica.png'),
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
              ),
              Padding(
                padding: const EdgeInsets.all(70.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: darkMode ? Colors.grey[850] : Colors.grey[100],
                          // borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: false
                              ? null
                              : [
                                  BoxShadow(
                                      color: darkMode
                                          ? Colors.black54
                                          : Colors.grey[400]
                                        ..withOpacity(0.7),
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0,
                                      spreadRadius: 3.5),
                                  BoxShadow(
                                      color: darkMode
                                          ? Colors.grey[700]
                                          : Colors.white,
                                      offset: Offset(-3.0, -3.0),
                                      blurRadius: 5.0,
                                      spreadRadius: 3.5),
                                ],
                        ),
                        child: Column(
                          children: <Widget>[
                            // SizedBox(height: 20.0),
                            Theme(
                              data: ThemeData(
                                // Define the default brightness and colors.
                                brightness: Brightness.light,
                                primaryColor: Colors.lightBlue[800],
                                accentColor: Colors.redAccent[700],
                                // Define the default font family.
                                // fontFamily: 'Georgia',
                                textTheme: TextTheme(
                                  headline1: TextStyle(
                                      fontSize: 72.0,
                                      fontWeight: FontWeight.bold),
                                  headline6: TextStyle(
                                      fontSize: 36.0,
                                      fontStyle: FontStyle.italic),
                                  bodyText2: TextStyle(
                                      fontSize: 14.0, fontFamily: 'Hind'),
                                ),
                              ),
                              child: CustomExpansionTile(
                                title: Text(
                                  "Grados",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text('dos'),
                                // leading: Icon(Icons.grade_rounded),
                                children: [
                                  ListTile(
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: RaisedButton(
                                            color: Colors.redAccent[700],
                                            // icon: Icon(Icons.add),
                                            child: Text(
                                              "Añadir grado",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () => _newGrado(context),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: darkMode ? Colors.grey[850] : Colors.grey[100],
                          // borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: false
                              ? null
                              : [
                                  BoxShadow(
                                      color: darkMode
                                          ? Colors.black54
                                          : Colors.grey[400]
                                        ..withOpacity(0.7),
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0,
                                      spreadRadius: 3.5),
                                  BoxShadow(
                                      color: darkMode
                                          ? Colors.grey[700]
                                          : Colors.white,
                                      offset: Offset(-3.0, -3.0),
                                      blurRadius: 5.0,
                                      spreadRadius: 3.5),
                                ],
                        ),
                        child: Column(
                          children: <Widget>[
                            // SizedBox(height: 20.0),
                            Theme(
                              data: ThemeData(
                                // Define the default brightness and colors.
                                brightness: Brightness.light,
                                primaryColor: Colors.lightBlue[800],
                                accentColor: Colors.redAccent[700],
                                // Define the default font family.
                                // fontFamily: 'Georgia',
                                textTheme: TextTheme(
                                  headline1: TextStyle(
                                      fontSize: 72.0,
                                      fontWeight: FontWeight.bold),
                                  headline6: TextStyle(
                                      fontSize: 36.0,
                                      fontStyle: FontStyle.italic),
                                  bodyText2: TextStyle(
                                      fontSize: 14.0, fontFamily: 'Hind'),
                                ),
                              ),
                              child: CustomExpansionTile(
                                title: Text(
                                  "Grados",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text('dos'),
                                // leading: Icon(Icons.grade_rounded),
                                children: [
                                  ListTile(
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: RaisedButton(
                                            color: Colors.redAccent[700],
                                            // icon: Icon(Icons.add),
                                            child: Text(
                                              "Añadir grado",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () => _newGrado(context),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                    ),
                  ],
                ),
              ),
              /* Positioned(
                top: 70,
                left: 80,
                right: constraints.maxWidth - 280,
                child: Container(
                  decoration: BoxDecoration(
                    color: darkMode ? Colors.grey[850] : Colors.grey[100],
                    // borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: false
                        ? null
                        : [
                            BoxShadow(
                                color:
                                    darkMode ? Colors.black54 : Colors.grey[400]
                                      ..withOpacity(0.7),
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                                spreadRadius: 3.5),
                            BoxShadow(
                                color:
                                    darkMode ? Colors.grey[700] : Colors.white,
                                offset: Offset(-3.0, -3.0),
                                blurRadius: 5.0,
                                spreadRadius: 3.5),
                          ],
                  ),
                  child: Column(
                    children: <Widget>[
                      // SizedBox(height: 20.0),
                      Theme(
                        data: ThemeData(
                          // Define the default brightness and colors.
                          brightness: Brightness.light,
                          primaryColor: Colors.lightBlue[800],
                          accentColor: Colors.redAccent[700],
                          // Define the default font family.
                          // fontFamily: 'Georgia',
                          textTheme: TextTheme(
                            headline1: TextStyle(
                                fontSize: 72.0, fontWeight: FontWeight.bold),
                            headline6: TextStyle(
                                fontSize: 36.0, fontStyle: FontStyle.italic),
                            bodyText2:
                                TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                          ),
                        ),
                        child: CustomExpansionTile(
                          title: Text(
                            "Grados",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text('dos'),
                          // leading: Icon(Icons.grade_rounded),
                          children: [
                            ListTile(
                              title: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      color: Colors.redAccent[700],
                                      // icon: Icon(Icons.add),
                                      child: Text(
                                        "Añadir grado",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () => _newGrado(context),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
              ),
              Positioned(
                top: _calcPos(constraints, Posiciones(padding: Pad(top: 70)))
                    .top,
                left: 80,
                right: constraints.maxWidth - 280,
                child: Container(
                  decoration: BoxDecoration(
                    color: darkMode ? Colors.grey[850] : Colors.grey[100],
                    // borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: false
                        ? null
                        : [
                            BoxShadow(
                                color:
                                    darkMode ? Colors.black54 : Colors.grey[400]
                                      ..withOpacity(0.7),
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                                spreadRadius: 3.5),
                            BoxShadow(
                                color:
                                    darkMode ? Colors.grey[700] : Colors.white,
                                offset: Offset(-3.0, -3.0),
                                blurRadius: 5.0,
                                spreadRadius: 3.5),
                          ],
                  ),
                  child: Column(
                    children: <Widget>[
                      // SizedBox(height: 20.0),
                      Theme(
                        data: ThemeData(
                          // Define the default brightness and colors.
                          brightness: Brightness.light,
                          primaryColor: Colors.lightBlue[800],
                          accentColor: Colors.redAccent[700],
                          // Define the default font family.
                          // fontFamily: 'Georgia',
                          textTheme: TextTheme(
                            headline1: TextStyle(
                                fontSize: 72.0, fontWeight: FontWeight.bold),
                            headline6: TextStyle(
                                fontSize: 36.0, fontStyle: FontStyle.italic),
                            bodyText2:
                                TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                          ),
                        ),
                        child: CustomExpansionTile(
                          title: Text(
                            "Areas y asignaturas",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text('dos'),
                          // leading: Icon(Icons.grade_rounded),
                          children: [
                            ListTile(
                              title: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      color: Colors.redAccent[700],
                                      // icon: Icon(Icons.add),
                                      child: Text(
                                        "Añadir grado",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () => _newGrado(context),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
              ), */
              /* Positioned(
                top: 70,
                left: constraints.maxWidth - (constraints.maxWidth * 0.725),
                right: constraints.maxWidth * 0.525,
                child: Container(
                  decoration: BoxDecoration(
                    color: darkMode ? Colors.grey[850] : Colors.blue[100]
                      ..withOpacity(0.3),
                    // borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: false
                        ? null
                        : [
                            BoxShadow(
                                color:
                                    darkMode ? Colors.black54 : Colors.grey[500]
                                      ..withOpacity(0.7),
                                offset: Offset(4.0, 4.0),
                                blurRadius: 6.0,
                                spreadRadius: 3.5),
                            BoxShadow(
                                color:
                                    darkMode ? Colors.grey[700] : Colors.white,
                                offset: Offset(-4.0, -4.0),
                                blurRadius: 6.0,
                                spreadRadius: 3.5),
                          ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          accentColor: Colors.black45,
                          unselectedWidgetColor: Colors.black45
                            ..withOpacity(0.1)),
                      child: ExpansionTile(
                        title: Text("Padding"),
                        children: <Widget>[
                          Text("Left"),
                          Text("Top"),
                          Text("Right"),
                          Text("Bottom"),
                        ],
                      ),
                    ),
                  ),
                ),
              ), */
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ); */
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
                                color: Colors.grey[200], //..withOpacity(0.0),
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
                                color: Colors.grey[200],
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
                        /* Container(
                          // first child
                          width:
                              80, // give it a width, it takes up the height of parent since it is wrapped with an expanded widget
                          decoration: _boxDecoration,
                        ), */

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
                                          decoration: BoxDecoration(
                                            color: darkMode
                                                ? Colors.grey[850]
                                                : Colors.grey[100],
                                            // borderRadius: BorderRadius.all(Radius.circular(50)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: false
                                                ? null
                                                : [
                                                    BoxShadow(
                                                        color: darkMode
                                                            ? Colors.black54
                                                            : Colors.grey[400]
                                                          ..withOpacity(0.7),
                                                        offset:
                                                            Offset(2.0, 2.0),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 3.5),
                                                    BoxShadow(
                                                        color: darkMode
                                                            ? Colors.grey[700]
                                                            : Colors.white,
                                                        offset:
                                                            Offset(-3.0, -3.0),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 3.5),
                                                  ],
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              // SizedBox(height: 20.0),
                                              Theme(
                                                data: ThemeData(
                                                  // Define the default brightness and colors.
                                                  brightness: Brightness.light,
                                                  primaryColor:
                                                      Colors.lightBlue[800],
                                                  accentColor:
                                                      Colors.redAccent[700],
                                                  // Define the default font family.
                                                  // fontFamily: 'Georgia',
                                                  textTheme: TextTheme(
                                                    headline1: TextStyle(
                                                        fontSize: 72.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    headline6: TextStyle(
                                                        fontSize: 36.0,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                    bodyText2: TextStyle(
                                                        fontSize: 14.0,
                                                        fontFamily: 'Hind'),
                                                  ),
                                                ),
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
                                                                      context),
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
                                        Container(
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: darkMode
                                                ? Colors.grey[850]
                                                : Colors.grey[100],
                                            // borderRadius: BorderRadius.all(Radius.circular(50)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: false
                                                ? null
                                                : [
                                                    BoxShadow(
                                                        color: darkMode
                                                            ? Colors.black54
                                                            : Colors.grey[400]
                                                          ..withOpacity(0.7),
                                                        offset:
                                                            Offset(2.0, 2.0),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 3.5),
                                                    BoxShadow(
                                                        color: darkMode
                                                            ? Colors.grey[700]
                                                            : Colors.white,
                                                        offset:
                                                            Offset(-3.0, -3.0),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 3.5),
                                                  ],
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              // SizedBox(height: 20.0),
                                              Theme(
                                                data: ThemeData(
                                                  // Define the default brightness and colors.
                                                  brightness: Brightness.light,
                                                  primaryColor:
                                                      Colors.lightBlue[800],
                                                  accentColor:
                                                      Colors.redAccent[700],
                                                  // Define the default font family.
                                                  // fontFamily: 'Georgia',
                                                  textTheme: TextTheme(
                                                    headline1: TextStyle(
                                                        fontSize: 72.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    headline6: TextStyle(
                                                        fontSize: 36.0,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                    bodyText2: TextStyle(
                                                        fontSize: 14.0,
                                                        fontFamily: 'Hind'),
                                                  ),
                                                ),
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
                                                                      context),
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
                                      ],
                                    )
                                  : Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: darkMode
                                                  ? Colors.grey[850]
                                                  : Colors.grey[100],
                                              // borderRadius: BorderRadius.all(Radius.circular(50)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: false
                                                  ? null
                                                  : [
                                                      BoxShadow(
                                                          color: darkMode
                                                              ? Colors.black54
                                                              : Colors.grey[400]
                                                            ..withOpacity(0.7),
                                                          offset:
                                                              Offset(2.0, 2.0),
                                                          blurRadius: 5.0,
                                                          spreadRadius: 3.5),
                                                      BoxShadow(
                                                          color: darkMode
                                                              ? Colors.grey[700]
                                                              : Colors.white,
                                                          offset: Offset(
                                                              -3.0, -3.0),
                                                          blurRadius: 5.0,
                                                          spreadRadius: 3.5),
                                                    ],
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                // SizedBox(height: 20.0),
                                                Theme(
                                                  data: ThemeData(
                                                    // Define the default brightness and colors.
                                                    brightness:
                                                        Brightness.light,
                                                    primaryColor:
                                                        Colors.lightBlue[800],
                                                    accentColor:
                                                        Colors.redAccent[700],
                                                    // Define the default font family.
                                                    // fontFamily: 'Georgia',
                                                    textTheme: TextTheme(
                                                      headline1: TextStyle(
                                                          fontSize: 72.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      headline6: TextStyle(
                                                          fontSize: 36.0,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                      bodyText2: TextStyle(
                                                          fontSize: 14.0,
                                                          fontFamily: 'Hind'),
                                                    ),
                                                  ),
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
                                                                        context),
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
                                          Container(
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: darkMode
                                                  ? Colors.grey[850]
                                                  : Colors.grey[100],
                                              // borderRadius: BorderRadius.all(Radius.circular(50)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: false
                                                  ? null
                                                  : [
                                                      BoxShadow(
                                                          color: darkMode
                                                              ? Colors.black54
                                                              : Colors.grey[400]
                                                            ..withOpacity(0.7),
                                                          offset:
                                                              Offset(2.0, 2.0),
                                                          blurRadius: 5.0,
                                                          spreadRadius: 3.5),
                                                      BoxShadow(
                                                          color: darkMode
                                                              ? Colors.grey[700]
                                                              : Colors.white,
                                                          offset: Offset(
                                                              -3.0, -3.0),
                                                          blurRadius: 5.0,
                                                          spreadRadius: 3.5),
                                                    ],
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                // SizedBox(height: 20.0),
                                                Theme(
                                                  data: ThemeData(
                                                    // Define the default brightness and colors.
                                                    brightness:
                                                        Brightness.light,
                                                    primaryColor:
                                                        Colors.lightBlue[800],
                                                    accentColor:
                                                        Colors.redAccent[700],
                                                    // Define the default font family.
                                                    // fontFamily: 'Georgia',
                                                    textTheme: TextTheme(
                                                      headline1: TextStyle(
                                                          fontSize: 72.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      headline6: TextStyle(
                                                          fontSize: 36.0,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                      bodyText2: TextStyle(
                                                          fontSize: 14.0,
                                                          fontFamily: 'Hind'),
                                                    ),
                                                  ),
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
                                                                        context),
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
                                        ],
                                      ),
                                    ),
                              // add spacing
                              SizedBox(
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
  Future _newGrado(context, [NewGrado grado]) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var validate = true;
        List faltantes = [];
        grado = (grado != null) ? grado : NewGrado();
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
                child: Text('Approve'),
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
                      () => {_addGrado(grado)},
                    );
                    print([grado.toJson(), validate]);
                    grado = NewGrado();
                    Navigator.of(context).pop();
                  } else {
                    setState(() {
                      print([validate, faltantes.toList().toString()]);
                    });
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
                        print(value);
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
}

_addGrado(NewGrado grado) {
  grados2.add(grado);
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
