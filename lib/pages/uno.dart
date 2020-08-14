import 'dart:io';
// import 'dart:io' show Platform;
// Platform.isAndroid
// Platform.isFuchsia
// Platform.isIOS
// Platform.isLinux
// Platform.isMacOS
// Platform.isWindows
// import 'dart:html';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:gescolar_dev/models/institucion.dart';
import 'package:gescolar_dev/pages/dos.dart';
import 'package:gescolar_dev/pages/login.dart';
import 'package:gescolar_dev/services/firebase_auth_service.dart';
// import 'package:gescolar_dev/widgets/forms/empty_state.dart';
import 'package:gescolar_dev/widgets/forms/sedesForm.dart';
import 'package:gescolar_dev/widgets/forms/sedes_multi_form.dart';
import 'package:gescolar_dev/widgets/multiselect/multiselect_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'dart:math';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:gescolar_dev/models/sede.dart';

class Uno extends StatefulWidget {
  @override
  State createState() {
    return UnoState();
  }
}

// LocalStorage storage = new LocalStorage('gescolar_app');

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

List<Widget> lista = []; //solo de prueba

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
          // lista.add(element.documentID);
          // storage.setItem('database1', element.documentID);
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

List<dynamic> _nivelEnsenanza = [];
List<dynamic> _size = [Size(400, 300), Size(400, 200), Size(400, 400)];
List<double> _height = [0, 0, 0];
var maskTelefono = MaskTextInputFormatter(
    mask: "(###) ### ## ##", filter: {"#": RegExp(r'[0-9]')});
var maskCedula =
    MaskTextInputFormatter(mask: "### ###", filter: {"#": RegExp(r'[0-9]')});
var maskRut = MaskTextInputFormatter(
    mask: "### ### - #", filter: {"#": RegExp(r'[0-9]')});

class UnoState extends State<Uno> with TickerProviderStateMixin {
  List<dynamic> users = [];
  var crossAxisCount = 4;
  List<bool> _enableBtn = [false, false, false];
  void initState() {
    super.initState();
    _nivelEnsenanza = [];
    lista = [];
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {_prueba(), _initDataBases()});
  }

  String calendario = 'calendarioA';
  String generoAtendido = 'mixto';

  List _nivelEnsenanza;

  List<dynamic> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  var _logow;
  final picker = ImagePicker();

  Future getImage() async {
    // print(['Windows', Platform.isWindows]);
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      // _logo = File(pickedFile.path);
      if (kIsWeb) {
        _logow = Image.network(pickedFile.path);
      } else {
        _logow = Image.file(File(pickedFile.path));
      }
    });
    /* if (kIsWeb) {
      Image fromPicker =
          await ImagePickerWeb.getImage(outputType: ImageType.widget);
      if (fromPicker != null) {
        setState(() {
          _logow = fromPicker;
          _logo = File('uno');
        });
      }
    } else {
      PickedFile pickedFile =
          await picker.getImage(source: ImageSource.gallery);
      setState(() {
        _logo = File(pickedFile.path);
      });
    } */
  }

  _prueba() {
    Institucion inst = Institucion(
      nit: '123456789',
      nombre: 'Livio Reginaldo Fischione',
      nivelEnsenanza: NivelEnsenanza(
          preescolar: true, basicaPrimaria: true, educacionMedia: true),
    );
    // storage.setItem('database', inst.toJson());
    print(['Json', inst.toJson()]);
    lista.add(ResponsiveConstraints(
      constraintsWhen: blockWidthConstraints,
      child: _ImageView(),
    ));
    lista.add(ResponsiveConstraints(
      constraintsWhen: blockWidthConstraints,
      child: _formulario(0, 400.0, context),
    ));
  }

  var size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double _formWidth = 220.0;
    double _top = 15;
    double _left = 40;
    if (size.width > 450) {
      _formWidth = (size.width * 0.25);
      _top = 25;
      _left = 80;
      print('Laptop');
    }
    return Container(
      padding: EdgeInsets.only(top: _top, left: _left, bottom: 0),
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget),
          defaultScale: true,
          minWidth: 450,
          defaultName: MOBILE,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.resize(451, name: TABLET),
            ResponsiveBreakpoint.resize(999, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ResponsiveBreakpoint.resize(1281, name: "4K"),
          ],
        ),
        home: Scaffold(
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
                    /* child: Wrap(
                      children: <Widget>[
                        ResponsiveConstraints(
                          constraintsWhen: blockWidthConstraints,
                          child: _ImageView(),
                        ),
                        ResponsiveConstraints(
                          constraintsWhen: blockWidthConstraints,
                          child: _formulario(0, _formWidth, context),
                        ),
                        ResponsiveConstraints(
                          constraintsWhen: blockWidthConstraints,
                          child: users.length <= 0
                              ? ResponsiveConstraints(
                                  constraintsWhen: blockWidthConstraints,
                                  child: EmptyState(
                                    title: 'Oops',
                                    message:
                                        'Add form by tapping add button below',
                                  ),
                                )
                              : ResponsiveConstraints(
                                  constraintsWhen: blockWidthConstraints,
                                  child: Container(
                                    width: 400,
                                    height: 500,
                                    child: ListView.builder(
                                      addAutomaticKeepAlives: true,
                                      itemCount: users.length,
                                      itemBuilder: (_, i) => users[i],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ), */
                    child: Wrap(
                      children: lista,
                      /* <Widget>[
                        /* ResponsiveConstraints(
                          constraintsWhen: blockWidthConstraints,
                          child: _ImageView(),
                        ),
                        ResponsiveConstraints(
                          constraintsWhen: blockWidthConstraints,
                          child: _formulario(0, _formWidth, context),
                        ), */
                        /* ResponsiveConstraints(
                          constraintsWhen: blockWidthConstraints,
                          child: ListView.builder(
                            addAutomaticKeepAlives: true,
                            itemCount: users.length,
                            itemBuilder: (_, i) => users[i],
                          ),
                        ), */
                      ], */
                    ),
                  ),
                ),
              ],
            ),
          ),
          /* body: ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: users.length,
            itemBuilder: (_, i) => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    alignment: Alignment.centerLeft,
                    child: users[i],
                  ),
                ),
              ],
            ),
          ), */
          floatingActionButton: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      // _prueba();
                      _db2();
                      _db1();
                      onAddForm();
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
                    heroTag: 'login1',
                    onPressed: () {
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      ); */
                      /* Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage())); */
                      FirebaseAuthService().signOut().then((value) =>
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage())));
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

  Widget _ImageView() {
    const _padding = 10.0;
    var imagen = Image.asset('images/logo-.png');
    if (_logow != null) {
      imagen = _logow;
    }
    return ResponsiveConstraints(
      constraintsWhen: blockWidthConstraints,
      child: Padding(
        padding: size.width < 451
            ? const EdgeInsets.only(
                bottom: _padding * 2, left: _padding * 5, right: _padding)
            : const EdgeInsets.only(
                bottom: _padding * 2, left: _padding, right: _padding),
        child: GestureDetector(
          onTap: () {
            getImage();
          },
          child: CircleAvatar(
            radius: 80.0,
            child: imagen,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  _formulario(index, width, context) {
    var selects;
    FocusNode myFocusNode;
    myFocusNode = FocusNode();
    var _textIsVaalid = false;
    const _padding = 10.0;
    const scale = 2;
    bool _isDense = true;
    if (size.width > 450) {
      // si es laptop
      const scale = 1;
      _isDense = false;
    }
    return ResponsiveConstraints(
      constraintsWhen: blockWidthConstraints,
      child: Padding(
        padding: const EdgeInsets.only(left: _padding * scale),
        child: Form(
          key: _formKeys[index],
          child: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: _padding),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    // autofocus: true,
                    // autovalidate: true,
                    autocorrect: true,
                    onChanged: (value) => {
                      setState(() {
                        _enableBtn[index] = true;
                      })
                    },
                    style: TextStyle(fontSize: 13),
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
                      isDense: _isDense, // Added this
                      contentPadding: EdgeInsets.all(0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Nombre de la institución",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: _padding),
                  child: TextField(
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      isDense: _isDense, // Added this
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Misión",
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: _padding),
                  child: DropdownButton<String>(
                    value: calendario,
                    // icon: Icon(Icons.arrow_downward),
                    iconSize: 16,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        calendario = newValue;
                      });
                    },
                    items: <String>['calendarioA', 'calendarioB']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: _padding),
                  child: DropdownButton<String>(
                    value: generoAtendido,
                    // icon: Icon(Icons.arrow_downward),
                    iconSize: 16,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newGenero) {
                      setState(() {
                        generoAtendido = newGenero;
                      });
                    },
                    items: <String>['mixto', 'masculino', 'femenino']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: _padding),
                  child: MultiSelectFormField(
                    autovalidate: false,
                    titleText: 'Niveles de enseñanza',
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Por favor selecciona una o más opciones';
                      }
                      return null;
                    },
                    dataSource: [
                      {
                        "display": "Preescolar",
                        "value": "Preescolar",
                      },
                      {
                        "display": "Basica Primaria",
                        "value": "BasicaPrimaria",
                      },
                      {
                        "display": "Basica Secundaria",
                        "value": "BasicaSecundaria",
                      },
                      {
                        "display": "Educacion Basica para Adultos",
                        "value": "EducacionBasicaAdultos",
                      },
                      {
                        "display": "Educacion Media",
                        "value": "EducacionMedia",
                      },
                      {
                        "display": "Educacion Media para Adultos",
                        "value": "EducacionMediaAdultos",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    // required: true,
                    hintText: 'Por favor selecciona una o más opciones',
                    initialValue: _nivelEnsenanza,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        _nivelEnsenanza = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: _padding),
                  child: TextFormField(
                    inputFormatters: [maskTelefono],
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      isDense: _isDense, // Added this
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Telefono",
                      hintText: "(123) 123 45 67",
                      // fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: _padding),
                  child: TextFormField(
                    // textDirection: TextDirection.rtl,
                    /* onChanged: (value) => {
                    print(value.length),
                    if (value.length == 11)
                      {maskCedula.updateMask("# ### ### - #")}
                    else if (value.length == 13)
                      {maskCedula.updateMask("## ### ### - #")}
                    else if (value.length == 14)
                      {maskCedula.updateMask("### ### ### - #")}
                    else if (value.length == 15)
                      {maskCedula.updateMask("# ### ### ### - #")}
                    else if (value.length < 14)
                      {maskCedula.updateMask("## ### ### - #")}
                    else if (value.length < 13)
                      {maskCedula.updateMask("# ### ### - #")}
                    else if (value.length < 11)
                      {maskCedula.updateMask("### ### - #")}
                  }, */
                    // inputFormatters: [maskCedula],
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      isDense: _isDense, // Added this
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Rut",
                      // hintText: "84 091 141",
                      // fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: _padding),
                  child: TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      isDense: _isDense, // Added this
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Nit",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: _padding),
                  child: TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      isDense: _isDense, // Added this
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Dane",
                    ),
                  ),
                ),
                /* TextField(
                // textDirection: TextDirection.rtl,
                onChanged: (value) => {
                  print(value.length),
                  if (value.length == 7)
                    {maskCedula.updateMask("#.###.###")}
                  else if (value.length == 8)
                    {maskCedula.updateMask("##.###.###")}
                  else if (value.length == 10)
                    {maskCedula.updateMask("###.###.###")}
                  else if (value.length == 11)
                    {maskCedula.updateMask("#.###.###.###")}
                  else if (value.length < 10)
                    {maskCedula.updateMask("##.###.###")}
                  else if (value.length < 8)
                    {maskCedula.updateMask("#.###.###")}
                  else if (value.length < 7)
                    {maskCedula.updateMask("###.###")}
                },
                inputFormatters: [maskCedula],
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "Cedula",
                    // hintText: "84 091 141",
                    // fillColor: Colors.white,
                    filled: true),
              ), */
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: AnimatedOpacity(
                    // If the widget is visible, animate to 0.0 (invisible).
                    // If the widget is hidden, animate to 1.0 (fully visible).
                    opacity: _enableBtn[index] ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 250),
                    // The green box must be a child of the AnimatedOpacity widget.
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: RaisedButton(
                        onPressed: () {
                          // devolverá true si el formulario es válido, o falso si
                          // el formulario no es válido.
                          if (_formKeys[index].currentState.validate()) {
                            // Si el formulario es válido, queremos mostrar un Snackbar
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Guardando los datos')));
                          }
                        },
                        child: Text('Guardar'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///on form user deleted
  void onDelete(Sede _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = Sede();
      // users.add(_ImageView());
      // users.add(_formulario(0, 220.0, context));
      lista.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = users.map((it) => it.user).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('List of Users'),
              ),
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(
                    child: Text(data[i].fullName.substring(0, 1)),
                  ),
                  title: Text(data[i].fullName),
                  subtitle: Text(data[i].email),
                ),
              ),
            ),
          ),
        );
      }
    }
  }

  _acordeonSta(title, index) {
    var _isExpanded = true;
    if (_height[index] != _size[index].h) {
      _isExpanded = !_isExpanded;
    }
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
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              color: Colors.blueAccent,
              height: 25.0,
              width: _size[index].w,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            child: !_isExpanded
                ? null
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _formulario(index, 300, context),
                  ),
            // height: _height[index],
            color: Colors.tealAccent,
            width: _size[index].w,
          )
        ],
      ),
    );
  }
}
