/* class Simat {
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
      this.index});

  factory Simat.fromJson(Map<String, dynamic> json) {
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
    );
  }
  factory Simat.fromList(List<String> list) {
    return Simat(
      ano: list[0],
      estado: list[2],
      sede: list[8],
      codigoDaneSede: list[9],
      zonaSede: list[11],
      jornada: list[12],
      gradoCod: list[13],
      grupo: list[14],
      fechaini: list[17],
      nui: list[18],
      estrato: list[19],
      doc: list[22],
      tipodoc: list[23],
      apellido1: list[24],
      apellido2: list[25],
      nombre1: list[26],
      nombre2: list[27],
      genero: list[28],
      fechaNacimiento: list[29],
      epsEstudiante: list[31],
      discapacidad: list[39],
      paisOrigen: list[40],
      correo: list[41],
      selected: false,
      index: 0,
    );
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
      };
} */

/* class User {
  String uid;
  String email;
  String photoUrl;
  String displayName;

  User({
    this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
  });
} */
/* import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    @required this.uid,
    this.email,
    this.photoUrl,
    this.displayName
  });

  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
} */
