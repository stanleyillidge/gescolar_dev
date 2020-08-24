import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:html';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
// import 'package:gescolar_dev/models/user.dart';
import 'package:gescolar_dev/widgets/Google/Drive/drive.dart';
// import 'package:gescolar_dev/pages/tabla.dart';
import 'package:gescolar_dev/widgets/circular_chart/flutter_circular_chart.dart';
// import 'package:gescolar_dev/widgets/circular_progres/circular_progres.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:gescolar_dev/widgets/pagDataTable/pagDataTable.dart';
import 'package:hive/hive.dart';
// import 'package:json_table/json_table.dart';

final drive = GoogleDrive();
bool darkMode = false;
var firebaseUsers = 0;
var gSuiteUsers = 0;
var simatUsers = 0;
var storage; // = Hive.box('myBox');

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
String u0 =
    '{"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"TARDE","gradoCod":"09","GRUPO":"0903","fechaini":"2020-02-17 07:11:19.0","nui":"YENARI556243828","estrato":"ESTRATO 1","DOC":"1118815346","tipodoc":"TI:TARJETA DE IDENTIDAD","APELLIDO1":"ARIAS","apellido2":"ROSADO","NOMBRE1":"GENESYS","nombre2":"YIRETH","genero":"FEMENINO","fechaNacimiento":"02/11/2005","epsEstudiante":"CAPRECOM EPS","discapacidad":"NO APLICA","paisOrigen":"","correo":"","selected":false,"index":99,"nombre":"GENESYS ARIAS"}';
String u1 =
    '{"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"TARDE","gradoCod":"08","GRUPO":"0801","fechaini":"2020-01-15 15:05:06.0","nui":"SULBAR1494684186","estrato":"ESTRATO 2","DOC":"1029860566","tipodoc":"TI:TARJETA DE IDENTIDAD","APELLIDO1":"BARROS","apellido2":"RODRIGUEZ","NOMBRE1":"ZULAY","nombre2":"MILENA","genero":"FEMENINO","fechaNacimiento":"08/04/2006","epsEstudiante":"","discapacidad":"NO APLICA","paisOrigen":"","correo":"","selected":false,"index":204,"nombre":"ZULAY BARROS"}';
String u2 =
    '{"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"MAÑANA","gradoCod":"07","GRUPO":"0701","fechaini":"2020-01-15 09:34:16.0","nui":"ALAAKO1991855844","estrato":"ESTRATO 1","DOC":"1119394138","tipodoc":"RC:REGISTRO CIVIL DE NACIMIENTO","APELLIDO1":"ACOSTA","apellido2":"MENDOZA","NOMBRE1":"ALAN","nombre2":"DE JESUS","genero":"MASCULINO","fechaNacimiento":"19/01/2008","epsEstudiante":"","discapacidad":"NO APLICA","paisOrigen":"","correo":"","selected":false,"index":9,"nombre":"ALAN ACOSTA"}';
String u3 =
    '{"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"NOCTURNA","gradoCod":"23","GRUPO":"2301","fechaini":"2020-03-16 07:18:29.0","nui":"LUSAMA1048870154","estrato":"ESTRATO 1","DOC":"1118800267","tipodoc":"TI:TARJETA DE IDENTIDAD","APELLIDO1":"AMAYA","apellido2":"POLO","NOMBRE1":"LUZ","nombre2":"BEIDIS","genero":"FEMENINO","fechaNacimiento":"18/11/2003","epsEstudiante":"","discapacidad":"NO APLICA","paisOrigen":"","correo":"","selected":false,"index":58,"nombre":"LUZ AMAYA"}';

String u4 =
    '{"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"MAÑANA","gradoCod":"08","GRUPO":"0802","fechaini":"2020-02-17 14:35:38.0","nui":"KLAASE1322271237","estrato":"ESTRATO 1","DOC":"1047337183","tipodoc":"TI:TARJETA DE IDENTIDAD","APELLIDO1":"ACENDRA","apellido2":"PEDROZO","NOMBRE1":"CLAUDIA","nombre2":"ANDREA","genero":"FEMENINO","fechaNacimiento":"25/05/2006","epsEstudiante":"","discapacidad":"NO APLICA","paisOrigen":"COLOMBIA","correo":"","selected":false,"index":1,"nombre":"CLAUDIA ACENDRA"}';
String u =
    '[{"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"MAÑANA","gradoCod":"08","GRUPO":"0802","fechaini":"2020-02-17 14:35:38.0","nui":"KLAASE1322271237","estrato":"ESTRATO 1","DOC":"1047337183","tipodoc":"TI:TARJETA DE IDENTIDAD","APELLIDO1":"ACENDRA","apellido2":"PEDROZO","NOMBRE1":"CLAUDIA","nombre2":"ANDREA","genero":"FEMENINO","fechaNacimiento":"25/05/2006","epsEstudiante":"","discapacidad":"NO APLICA","paisOrigen":"COLOMBIA","correo":"","selected":false,"index":1,"nombre":"CLAUDIA ACENDRA"}, {"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"TARDE","gradoCod":"10","GRUPO":"1004","fechaini":"2020-01-16 10:04:32.0","nui":"KARAKO1578261071","estrato":"ESTRATO 1","DOC":"1118807924","tipodoc":"TI:TARJETA DE IDENTIDAD","APELLIDO1":"ACOSTA","apellido2":"MENDOZA","NOMBRE1":"CARLOS","nombre2":"ALBERTO","genero":"MASCULINO","fechaNacimiento":"15/01/2005","epsEstudiante":"","discapacidad":"NO APLICA","paisOrigen":"","correo":"","selected":false,"index":10,"nombre":"CARLOS ACOSTA"}, {"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"TARDE","gradoCod":"11","GRUPO":"1101","fechaini":"2020-01-16 10:35:09.0","nui":"LINARI905814677","estrato":"ESTRATO 1","DOC":"1118800460","tipodoc":"TI:TARJETA DE IDENTIDAD","APELLIDO1":"ARIZA","apellido2":"BARROS","NOMBRE1":"LINA","nombre2":"MARCELA","genero":"FEMENINO","fechaNacimiento":"06/06/2003","epsEstudiante":"","discapacidad":"NO APLICA","paisOrigen":"","correo":"","selected":false,"index":100,"nombre":"LINA ARIZA"}, {"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"MAÑANA","gradoCod":"10","GRUPO":"1002","fechaini":"2020-01-15 13:20:38.0","nui":"DINBAR749331842","estrato":"ESTRATO 1","DOC":"1029860652","tipodoc":"TI:TARJETA DE IDENTIDAD","APELLIDO1":"BARROS","apellido2":"MOSCOTE","NOMBRE1":"DEINNYS","nombre2":"SANDRITH","genero":"FEMENINO","fechaNacimiento":"15/06/2006","epsEstudiante":"","discapacidad":"NO APLICA","paisOrigen":"","correo":"","selected":false,"index":200,"nombre":"DEINNYS BARROS"}, {"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"MAÑANA","gradoCod":"11","GRUPO":"1101","fechaini":"2020-01-15 13:37:14.0","nui":"ANDBRI2035542230","estrato":"ESTRATO 2","DOC":"1118802808","tipodoc":"TI:TARJETA DE IDENTIDAD","APELLIDO1":"BRITO","apellido2":"PEREZ","NOMBRE1":"ANDRES","nombre2":"JOSE","genero":"MASCULINO","fechaNacimiento":"19/07/2003","epsEstudiante":"","discapacidad":"NO APLICA","paisOrigen":"","correo":"","selected":false,"index":300,"nombre":"ANDRES BRITO"}, {"ano":"2020","estado":"MATRICULADO","SEDE":"LIVIO REGINALDO FISCHIONE","codigoDaneSede":"244001002356","zonaSede":"URBANA","JORNADA":"TARDE","gradoCod":"09","GRUPO":"0903","fechaini":"2020-01-16 09:07:08.0","nui":"LERKAS1263687305","estrato":"ESTRATO 1","DOC":"1118812779","tipodoc":"TI:TARJETA DE IDENTIDAD","APELLIDO1":"CASTAÑEDA","apellido2":"VELASQUEZ","NOMBRE1":"LEREIDYS","nombre2":"LERIETH","genero":"FEMENINO","fechaNacimiento":"03/09/2005","epsEstudiante":"","discapacidad":"NO APLICA","paisOrigen":"","correo":"","selected":false,"index":400,"nombre":"LEREIDYS CASTAÑEDA"}]';
final String jsonSample =
    '[' + u4 + ',' + u0 + ',' + u1 + ',' + u2 + ',' + u3 + ']';

class Filas {
  String name;
  String email;
  int age;
  String income;
  String country;
  String area;
  bool selected;
  Widget grafico;
  int index;

  Filas(
      {this.name,
      this.email,
      this.age,
      this.income,
      this.country,
      this.area,
      this.grafico,
      this.selected,
      this.index});

  factory Filas.fromJson(Map<String, dynamic> json) {
    return new Filas(
      name: json['name'],
      email: json['email'],
      age: json['age'],
      income: json['income'],
      country: json['country'],
      area: json['area'],
      selected: false,
      index: 0,
    );
  }
}

class Simat {
  String ano;
  String estado;
  String sede;
  String codigoDaneSede;
  String zonaSede;
  String jornada;
  String gradoCod;
  String grupo;
  String fechaini;
  String nui;
  String estrato;
  String doc;
  String tipodoc;
  String apellido1;
  String apellido2;
  String nombre1;
  String nombre2;
  String genero;
  String fechaNacimiento;
  String epsEstudiante;
  String discapacidad;
  String paisOrigen;
  String correo;
  bool selected;
  int index;
  String nombre;

  Simat(
      {this.ano,
      this.estado,
      this.sede,
      this.codigoDaneSede,
      this.zonaSede,
      this.jornada,
      this.gradoCod,
      this.grupo,
      this.fechaini,
      this.nui,
      this.estrato,
      this.doc,
      this.tipodoc,
      this.apellido1,
      this.apellido2,
      this.nombre1,
      this.nombre2,
      this.genero,
      this.fechaNacimiento,
      this.epsEstudiante,
      this.discapacidad,
      this.paisOrigen,
      this.correo,
      this.selected,
      this.index,
      this.nombre});

  factory Simat.fromJson(Map<String, dynamic> json) {
    var nombre = ((json['nombre1'] != null) && (json['apellido1'] != null))
        ? json['nombre1'] + ' ' + json['apellido1']
        : '';
    return Simat(
      ano: json['ano'],
      estado: json['estado'],
      sede: json['sede'],
      codigoDaneSede: json['codigoDaneSede'],
      zonaSede: json['zonaSede'],
      jornada: json['jornada'],
      gradoCod: json['gradoCod'],
      grupo: json['grupo'],
      fechaini: json['fechaini'],
      nui: json['nui'],
      estrato: json['estrato'],
      doc: json['doc'],
      tipodoc: json['tipodoc'],
      apellido1: json['apellido1'],
      apellido2: json['apellido2'],
      nombre1: json['nombre1'],
      nombre2: json['nombre2'],
      genero: json['genero'],
      fechaNacimiento: json['fechaNacimiento'],
      epsEstudiante: json['epsEstudiante'],
      discapacidad: json['discapacidad'],
      paisOrigen: json['paisOrigen'],
      correo: json['correo'],
      selected: false,
      index: 0,
      nombre: nombre,
    );
  }
  factory Simat.fromLocal(Map<String, dynamic> json) {
    var nombre = ((json['NOMBRE1'] != null) && (json['APELLIDO1'] != null))
        ? json['NOMBRE1'] + ' ' + json['APELLIDO1']
        : '';
    return Simat(
      ano: json['ANO'],
      estado: json['ESTADO'],
      sede: json['SEDE'],
      codigoDaneSede: json['CODIGO_DANE_SEDE'],
      zonaSede: json['ZONA_SEDE'],
      jornada: json['JORNADA'],
      gradoCod: json['GRADO_COD'],
      grupo: json['GRUPO'],
      fechaini: json['FECHAINI'],
      nui: json['NUI'],
      estrato: json['ESTRATO'],
      doc: json['DOC'],
      tipodoc: json['TIPODOC'],
      apellido1: json['APELLIDO1'],
      apellido2: json['APELLIDO2'],
      nombre1: json['NOMBRE1'],
      nombre2: json['NOMBRE2'],
      genero: json['GENERO'],
      fechaNacimiento: json['FECHA_NACIMIENTO'],
      epsEstudiante: json['EPS_ESTUDIANTE'],
      discapacidad: json['DISCAPACIDAD'],
      paisOrigen: json['PAIS_ORIGEN'],
      correo: json['CORREO'],
      selected: false,
      index: 0,
      nombre: nombre,
    );
  }
  factory Simat.fromList(List<String> list) {
    var nombre = ((list[27] != null) && (list[25] != null))
        ? list[27] + ' ' + list[25]
        : '';
    return Simat(
        ano: list[0].substring(1),
        estado: list[2],
        sede: list[8],
        codigoDaneSede: list[9],
        zonaSede: list[11],
        jornada: list[12],
        gradoCod: list[13],
        grupo: list[14],
        fechaini: list[17],
        nui: list[19],
        estrato: list[20],
        doc: list[23],
        tipodoc: list[24],
        apellido1: list[25],
        apellido2: list[26],
        nombre1: list[27],
        nombre2: list[28],
        genero: list[29],
        fechaNacimiento: list[30],
        epsEstudiante: list[32],
        discapacidad: list[40],
        paisOrigen: list[41],
        correo: list[42].substring(list[42].length),
        selected: false,
        index: 0,
        nombre: nombre);
  }
  Map toJson() => {
        'ano': ano,
        'estado': estado,
        'sede': sede,
        'codigoDaneSede': codigoDaneSede,
        'zonaSede': zonaSede,
        'jornada': jornada,
        'gradoCod': gradoCod,
        'grupo': grupo,
        'fechaini': fechaini,
        'nui': nui,
        'estrato': estrato,
        'doc': doc,
        'tipodoc': tipodoc,
        'apellido1': apellido1,
        'apellido2': apellido2,
        'nombre1': nombre1,
        'nombre2': nombre2,
        'genero': genero,
        'fechaNacimiento': fechaNacimiento,
        'epsEstudiante': epsEstudiante,
        'discapacidad': discapacidad,
        'paisOrigen': paisOrigen,
        'correo': correo,
        'selected': false,
        'index': index,
        'nombre': nombre
      };
}

class EstadoF {
  bool existe;
  bool actualizado;
  bool primerUso;
  int index;
  EstadoF(
    this.existe,
    this.actualizado,
    this.primerUso,
    this.index,
  );
}

class Filtro {
  String campo;
  String valor;
  List datos;
  EstadoF estados;
  Filtro(
    this.campo,
    this.valor,
    this.datos,
    this.estados,
  );
}

Map<String, dynamic> ftemp = {
  'valor': 'jornada',
  'datos': List<Simat>(),
  'exist': false
};
List<Filtro> filtros = [
  Filtro('jornada', 'jornada', List<Simat>(), EstadoF(false, false, true, 0)),
  Filtro('grupo', 'grupo', List<Simat>(), EstadoF(false, false, true, 0))
];

List<Simat> users;
List<Simat> usersTemp;
// List<dynamic> users2 = (json.decode(jsonSample) as List)
//     .map((data) => Simat.fromJson(data))
//     .toList();
// String users3 = json.encode(users2);

// List<Simat> users = (json.decode(jsonSample) as List)
//     .map((data) => Simat.fromJson(data))
//     .toList();

var jornadas = ['jornada'];
var grupos = ['grupo'];
int numItems;
List<bool> selected;
List<bool> simatSelected;

class Sedes extends StatefulWidget {
  Sedes({Key key}) : super(key: key);

  @override
  _SedesState createState() => _SedesState();
}

class _SedesState extends State<Sedes> with SingleTickerProviderStateMixin {
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => {print(jsonEncode(users[0]))});
    _getLoacalUsers();
    if (users != null) {
      setState(() {
        users = users;
        numItems = users.length;
        selected = List<bool>.generate(numItems, (index) => false);
        simatSelected = List<bool>.generate(numItems, (index) => false);
      });
    }
  }

  bool _sortNameAsc = true;
  bool _sortAsc = true;
  int _sortColumnIndex;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Simat'),
    Tab(text: 'G Suite'),
    Tab(text: 'Firebase'),
  ];
  var _jornada = 'jornada';
  var _grupo = 'grupo';
  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    _json = jsonDecode(jsonSample);
    int _rowPerPage = PagDataTable.defaultRowsPerPage;
    List<DataColumn> columnas = [
      DataColumn(
        label: Text('nombre'),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            users.sort((a, b) => a.nombre.compareTo(b.nombre));
            if (!_sortAsc) {
              users = users.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        // label: Text('jornada'),
        label: DropdownButton(
          hint: Text('Selecciona una jornada'), // Not necessary for Option 1
          value: _jornada,
          onChanged: (newValue) {
            print(['newValue', newValue]);
            var newUsers = usersTemp;
            if (filtros[0].estados.existe) {
              if (newValue == 'jornada') {
                filtros[0].valor = newValue;
                filtros[0].datos = usersTemp;
                filtros[0].estados.existe = false;
                filtros[0].estados.actualizado = false;
                print('Se borro el filtro jornada');
              } else {
                filtros[0].valor = newValue;
                filtros[0].estados.actualizado = true;
                print([
                  'Fue actualizado el filtro jornada',
                  filtros[0].valor,
                  filtros[0].datos.length
                ]);
              }
            } else {
              filtros[0].valor = newValue;
              filtros[0].datos = users;
              filtros[0].estados.existe = true;
              filtros[0].estados.primerUso = (filtros[1].estados.primerUso ||
                  filtros[0].estados.primerUso);
              print([
                'Se creo el filtro jornada',
                filtros[0].valor,
                filtros[0].datos.length
              ]);
            }
            if (filtros.length > 0) {
              print([
                'Filtro iterado',
                filtros[0].campo,
                filtros[0].valor,
                filtros[0].datos.length
              ]);
              newUsers = filtros[0].datos;
              // case 'jornada':
              var uniques = {};
              grupos = [];
              newUsers = newUsers
                  .where((user) => (user.jornada == filtros[0].valor))
                  .toList();
              newUsers.forEach((user) {
                if (uniques[user.grupo] == null) {
                  uniques[user.grupo] = true;
                  grupos.add(user.grupo);
                }
              });
              grupos.add('grupo');
              if (filtros[0].estados.primerUso) {
                filtros[0].datos = newUsers;
                filtros[0].estados.primerUso = false;
                filtros[1].estados.primerUso = false;
                print([
                  'Datos del filtro jornada actualizados',
                  filtros[0].datos.length
                ]);
              }
            }
            print([newValue, newUsers.length]);
            setState(() {
              users = newUsers;
              _jornada = newValue;
            });
          },
          items: jornadas.map((location) {
            return DropdownMenuItem(
              child: Text(location),
              value: location,
            );
          }).toList(),
        ),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            users.sort((a, b) => a.jornada.compareTo(b.jornada));
            if (!_sortAsc) {
              users = users.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        // label: Text('grupo'),
        label: DropdownButton(
          hint: Text('Selecciona un grupo'), // Not necessary for Option 1
          value: _grupo,
          onChanged: (newValue) {
            var newUsers = usersTemp;
            // configuración del filtro
            if (filtros[1].estados.existe) {
              if (newValue == 'grupo') {
                filtros[1].valor = newValue;
                filtros[1].datos = usersTemp;
                filtros[1].estados.existe = false;
                filtros[1].estados.actualizado = false;
                print('Se borro el filtro grupo');
              } else {
                filtros[1].valor = newValue;
                filtros[1].estados.actualizado = true;
                print([
                  'Fue actualizado el filtro grupo',
                  filtros[1].valor,
                  filtros[1].datos.length
                ]);
              }
            } else {
              filtros[1].valor = newValue;
              filtros[1].datos = users;
              filtros[1].estados.existe = true;
              filtros[1].estados.primerUso = (filtros[1].estados.primerUso ||
                  filtros[0].estados.primerUso);
              print([
                'Se creo el filtro grupo',
                filtros[1].valor,
                filtros[1].datos.length
              ]);
            }
            // --- Filtrar lod datos y ajustar los demas filtros ----
            if (filtros.length > 0) {
              print([
                'Filtro iterado',
                filtros[1].campo,
                filtros[1].valor,
                filtros[1].datos.length
              ]);
              newUsers = filtros[1].datos;
              var uniques = {};
              // case 'grupo':
              uniques = {};
              jornadas = [];
              newUsers = newUsers
                  .where((user) => (user.grupo == filtros[1].valor))
                  .toList();
              newUsers.forEach((user) {
                if (uniques[user.jornada] == null) {
                  uniques[user.jornada] = true;
                  jornadas.add(user.jornada);
                }
              });
              jornadas.add('jornada');
              if (filtros[1].estados.primerUso) {
                filtros[1].datos = newUsers;
                filtros[0].estados.primerUso = false;
                filtros[1].estados.primerUso = false;
                print([
                  'Datos del filtro grupo actualizados',
                  filtros[1].datos.length
                ]);
              }
            }
            print([newValue, newUsers.length]);
            setState(() {
              users = newUsers;
              _grupo = newValue;
            });
          },
          items: grupos.map((location) {
            return DropdownMenuItem(
              child: Text(location),
              value: location,
            );
          }).toList(),
        ),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            users.sort((a, b) => a.grupo.compareTo(b.grupo));
            if (!_sortAsc) {
              users = users.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: Text('doc'),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            users.sort((a, b) => a.doc.compareTo(b.doc));
            if (!_sortAsc) {
              users = users.reversed.toList();
            }
          });
        },
      ),
      DataColumn(label: Text(''))
    ];
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
                          GestureDetector(
                            onTap: () async {
                              print('onTap');
                              _pickFiles();
                            },
                            child: Column(
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
                                          : Colors
                                              .deepOrange[400], //.grey[600],
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
                (users != null)
                    ? Card(
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
                      )
                    : Container(),
                /* Card(
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
                ), */
                // Container(),
                Container(),
                /* Card(
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
                ), */
                Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickFiles() async {
    final completer = Completer<List<String>>();
    final InputElement input = FileUploadInputElement();
    input.click();
    // onChange doesn't work on mobile safari
    input.addEventListener('change', (e) async {
      final List<File> files = input.files;
      Iterable<Future<String>> resultsFutures = files.map((file) {
        final reader = FileReader();
        reader.readAsText(file);
        reader.onError.listen((error) => completer.completeError(error));
        return reader.onLoad.first.then((_) => reader.result as String);
      });
      final results = await Future.wait(resultsFutures);
      completer.complete(results);
    });
    // input.click(); can be here
    final List<String> r = await completer.future;
    var a = r.toString().split("\n");
    users = [];
    // var encabezados;
    var conta = 0;
    a.forEach((element) {
      var uno = element.toString().split(";");
      var uno1 = uno.toString().replaceAll(RegExp(', '), ',');
      var dos = Simat.fromList(uno1.toString().split(","));
      dos.index = conta;
      if (conta != 0) {
        users.add(dos);
      }
      // else{encabezados = uno1.toString().split(",");}
      conta += 1; // Simat.fromList(dos)
    });
    a.clear();
    setState(() {
      print('set estate');
      users = users;
      usersTemp = users;
      storage.put('simat', json.encode(users));
      numItems = users.length;
      selected = List<bool>.generate(numItems, (index) => false);
      simatSelected = List<bool>.generate(numItems, (index) => false);
    });
    var uniques = {};
    jornadas = [];
    grupos = [];
    users.forEach((user) {
      if (uniques[user.jornada] == null) {
        uniques[user.jornada] = true;
        jornadas.add(user.jornada);
      } else if (uniques[user.grupo] == null) {
        uniques[user.grupo] = true;
        grupos.add(user.grupo);
      }
    });
    grupos.add('grupo');
    jornadas.add('jornada');
    // print(['uniques', jornadas]);
    print(['Cantidad de usuarios en', users.length]);
    // print(['Encabezados', encabezados]); //, jsonEncode(b[1])
    /* print([
      jsonEncode(users[1]),
      jsonEncode(users[10]),
      jsonEncode(users[100]),
      jsonEncode(users[200]),
      jsonEncode(users[300]),
      jsonEncode(users[400])
    ]); */
    // setState(() {});
    input.remove();
  }
}

class DTS extends DataTableSource {
  int _selectedCount = 0;
  final List<Simat> _users;
  // final Function onRowSelected;
  DTS(this._users);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _users.length) return null;
    final Simat user = _users[index];
    user.index = index;
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
        DataCell(Text(users[index].nombre)),
        DataCell(Text(users[index].jornada.toString())),
        DataCell(Text(users[index].grupo.toString())),
        DataCell(Text(users[index].doc.toString())),
        DataCell(
          AnimatedCircularChart(
            key: GlobalKey<AnimatedCircularChartState>(),
            size: const Size(20.0, 20.0),
            initialChartData: <CircularStackEntry>[
              CircularStackEntry(
                <CircularSegmentEntry>[
                  CircularSegmentEntry(20.0, Colors.yellow[400],
                      rankKey: 'FIREBASE$user.index'),
                  CircularSegmentEntry(10.0, Colors.white,
                      rankKey: 'Q$user.index'),
                  CircularSegmentEntry(20.0, Colors.blue[400],
                      rankKey: 'GSUITE$user.index'),
                  CircularSegmentEntry(10.0, Colors.white,
                      rankKey: 'Q$user.index'),
                  CircularSegmentEntry(20.0, Colors.deepOrange[400],
                      rankKey: 'SIMAT$user.index'),
                  CircularSegmentEntry(10.0, Colors.white,
                      rankKey: 'Q$user.index'),
                ],
                rankKey: 'Quarterly Profits$user.index',
              ),
            ],
            chartType: CircularChartType.Radial,
          ),
        ),
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

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}

List<Simat> users2;
_getLoacalUsers() async {
  try {
    storage = await Hive.openBox('myBox');
    var userst = await storage.get('simat');
    if (userst != null) {
      users2 = (json.decode(userst) as List)
          .map((data) => Simat.fromJson(data))
          .toList();
      print([
        'Carga de users2 localStorage',
        users2.length,
        jsonEncode(users2[1])
      ]);
    } else {
      print(['Carga de userst localStorage', userst]);
    }
    return userst;
  } catch (e) {
    print(['Error get local', e]);
  }
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

_pickFiles2() async {
  InputElement uploadInput = FileUploadInputElement();
  uploadInput.click();

  uploadInput.onChange.listen((e) {
    // read file content as dataURL
    try {
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();
        reader.onLoadEnd.listen((e) {
          try {
            // var _json = json.decode(reader.result);
            // uploadedImage = reader.result;
            // File datos = File(uploadedImage, 'datos.csv');
            // _csv(file.relativePath);
            // io.File _file = io.File.fromRawPath(rawPath);
            // String parte = getApplicationDocumentsDirectory()
            // print(reader.result);
            var a = reader.result.toString().split("\n");
            // print(['Cantidad de usuarios', a.length]);
            var b = [];
            a.forEach((element) {
              // var _json = json.decode(element.toString().split(";"));
              var uno = element.toString().split(";");
              var dos = uno.toString().split(",");
              b.add(dos); // Simat.fromList(dos)
            });
            var encabezados = b[0];
            a = [];
            print(['Cantidad de usuarios en', file.name, b.length]);
            print(['Encabezados', encabezados]); //, jsonEncode(b[1])
            // print(['Año', b[1][0]]);
            /* var usuarios = {};
            for (var i = 1; i < b.length; i++) {
              b[i]
            } */
            // print(b);
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

/* _driveFiles() async {
  /* try {
    io.File files = await FilePicker.getFile(); //FilePicker.getMultiFile() ?? [];
    await drive.upload(files);
  } catch (e) {
    print(['Error reader', e]);
  } */

  InputElement uploadInput = FileUploadInputElement();
  uploadInput.click();

  uploadInput.onChange.listen((e) {
    // read file content as dataURL
    try {
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();
        reader.onLoadEnd.listen((e) async {
          try {
            // print(reader.result);
            Uint8List data = Uint8List.fromList(reader.result);
            File _file = File(data, 'StanleySIMAT.txt');
            // print([_file.size, _file.relativePath, data]);
            // io.File _file2 = io.File.fromRawPath(reader.result);
            /* io.File('StanleySIMAT.txt')
                .writeAsString('reader.result.toString()')
                .then((io.File _newFile) async {
              // Do something with the file.
              try {
                print(_newFile);
                await drive.upload(_newFile);
              } catch (e) {
                print(['Error create Files', e]);
              }
            }); */
            await drive.upload(_file.size, ' ', reader.result);
          } catch (e) {
            print(['Error reader', e]);
          }
        });

        reader.onError.listen((fileEvent) {
          const option1Text = "Some Error occured while reading the file";
          print(option1Text);
        });
        // reader.readAsText(file);
        reader.readAsArrayBuffer(file);
        // reader.readAsDataUrl(file);
      }
    } catch (e) {
      print(['Error picker', e]);
    }
  });
} */

clearHive() async {
  await storage.close();
  print('Clear storage');
}
