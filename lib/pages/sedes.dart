import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:gescolar_dev/widgets/Custom_ExpansionTile/CustomExpansionTile.dart';

//--- variables ------
bool darkMode = false;
const double filtrobtspace = 6.0;

class NewGrado {
  String nivelEstudios;
  String nombre;
  String siguiente;
  bool siguienteTest = false;
  NewGrado();
  Map toJson() => {
        'nivelEstudios': nivelEstudios,
        'nombre': nombre,
        'siguiente': siguiente,
        'siguienteTest': siguienteTest,
      };
}

class Sedes extends StatefulWidget {
  Sedes({Key key}) : super(key: key);

  @override
  _SedesState createState() => _SedesState();
}

List<Widget> grados = [];

class _SedesState extends State<Sedes> with SingleTickerProviderStateMixin {
  void initState() {
    super.initState();
    if (grados.length == 0) {
      grados.add(
        ListTile(
          title: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                /* child: TextFormField(
                  controller: _controller,
                  textAlignVertical: TextAlignVertical.center,
                  // autofocus: true,
                  autocorrect: true,
                  onSaved: (value) => {
                    print(['onSaved', value])
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      /* grados.add(
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(value),
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
                                    child: Text("Eliminar"),
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
                                    print('Eliminado');
                                  }
                                },
                                // icon: Icon(Icons.list),
                              ),
                            ],
                          ),
                        ),
                      ); */
                      _showMyDialog();
                      _controller.clear();
                    });
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
                        print(['suffixIcon onPressed', '222']);
                      },
                    ),
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Grados",
                  ),
                ), */
                child: ButtonTheme(
                  minWidth: 300.0,
                  child: RaisedButton.icon(
                      icon: Icon(Icons.add),
                      label: Text("Añadir grado"),
                      onPressed: () => _showDialog(context),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double searchWidth = size.width * 0.8;
    return Stack(
      children: [
        Positioned(
          top: 15,
          left: 80,
          right: searchWidth,
          child: TextFormField(
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
          ),
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
  }

  String _selectedNivelEstudios;
  bool checkedValue = false;
  Future<void> _showMyDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                DropdownButton<String>(
                  items: <String>['A', 'B', 'C', 'D'].map((String nvalue) {
                    return DropdownMenuItem<String>(
                      value: nvalue,
                      child: Text(nvalue),
                    );
                  }).toList(),
                  hint: Text('Please choose a location'),
                  value: _selectedNivelEstudios,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedNivelEstudios = newValue;
                      print(newValue);
                    });
                  },
                ),
                /* PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                          "Editar"), // (users[index].editado) ? Text("Guardar") : Text("Editar"),
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
                      print('Editado');
                      // users[index].editado = !users[index].editado;
                      // notifyListeners();
                    } else if (value == 2) {
                      print('Eliminado');
                    }
                  },
                  // icon: Icon(Icons.list),
                ), */
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future _showDialog(context) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        NewGrado grado = NewGrado();
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //your code dropdown button here
                  Text('Grados'),
                  DropdownButton<String>(
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
                  TextFormField(
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
                  CheckboxListTile(
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
                      ? TextFormField(
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
                child: Text('Approve'),
                onPressed: () {
                  var validate = true;
                  grado.toJson().forEach((key, value) {
                    validate = ((key == 'nivelEstudios' || key == 'nombre') &&
                            value == null)
                        ? false
                        : validate;
                  });
                  if (validate) {
                    setState(() => {
                          grados.add(
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(grado.nombre),
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
                                        child: Text("Eliminar"),
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
                                        print('Eliminado');
                                      }
                                    },
                                    // icon: Icon(Icons.list),
                                  ),
                                ],
                              ),
                            ),
                          )
                        });
                  }
                  print([grado.toJson(), validate]);
                  grado = NewGrado();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
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
