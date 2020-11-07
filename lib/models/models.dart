import 'dart:convert';
import 'package:flutter/material.dart';
import 'string_apis.dart';
// import 'package:animations/animations.dart';

class AnoLectivo {
  String nombre;
  DateTime inicio;
  DateTime fin;
  bool activo;
  AnoLectivo({
    this.nombre,
    this.inicio,
    this.fin,
    this.activo: true,
  });
  Map toJson() => {
        'nombre': nombre,
        'inicio': inicio,
        'fin': fin,
        'activo': activo,
      };
}

class Simat {
  String ano;
  String etc;
  String estado;
  String jerarquia;
  String institucion;
  String dane;
  String calendario;
  String sector;
  String sede;
  String codigoDaneSede;
  String consecutivo;
  String zonaSede;
  String jornada;
  String gradoCod;
  String grupo;
  String modelo;
  String motivo;
  String fechaini;
  String fechafin;
  String nui;
  String estrato;
  String sisbenTres;
  String perId;
  String doc;
  String tipodoc;
  String apellido1;
  String apellido2;
  String nombre1;
  String nombre2;
  String genero;
  String fechaNacimiento;
  String barrio;
  String eps;
  String tipoDeSangre;
  String matriculacontratada;
  String fuenteRecursos;
  String internado;
  String numContrato;
  String apoyoAcademicoEspecial;
  String srpa;
  String discapacidad;
  String paisOrigen;
  String correo;
  //------------
  String id;
  String nombre;
  bool activo;
  bool editado;
  String fechaEdicion;
  String fechaCreacion;
  String plataformaState;

  Simat({
    this.ano,
    this.etc,
    this.estado,
    this.jerarquia,
    this.institucion,
    this.dane,
    this.calendario,
    this.sector,
    this.sede,
    this.codigoDaneSede,
    this.consecutivo,
    this.zonaSede,
    this.jornada,
    this.gradoCod,
    this.grupo,
    this.modelo,
    this.motivo,
    this.fechaini,
    this.fechafin,
    this.nui,
    this.estrato,
    this.sisbenTres,
    this.perId,
    this.doc,
    this.tipodoc,
    this.apellido1,
    this.apellido2,
    this.nombre1,
    this.nombre2,
    this.genero,
    this.fechaNacimiento,
    this.barrio,
    this.eps,
    this.tipoDeSangre,
    this.matriculacontratada,
    this.fuenteRecursos,
    this.internado,
    this.numContrato,
    this.apoyoAcademicoEspecial,
    this.srpa,
    this.discapacidad,
    this.paisOrigen,
    this.correo,
    this.id,
    this.activo,
    this.editado,
    this.nombre,
    this.fechaEdicion,
    this.fechaCreacion,
    this.plataformaState,
  });
  factory Simat.fromJson(Map<String, dynamic> json) {
    var nombre = ((json['nombre1'] != null) && (json['apellido1'] != null))
        ? ((json['nombre1'] != null) &&
                (json['apellido1'] != null) &&
                (json['apellido2'] != null))
            ? ((json['nombre1'] != null) &&
                    (json['nombre2'] != null) &&
                    (json['apellido1'] != null) &&
                    (json['apellido2'] != null))
                ? json['nombre1'] +
                    ' ' +
                    json['nombre2'] +
                    ' ' +
                    json['apellido1'] +
                    ' ' +
                    json['apellido2']
                : json['nombre1'] +
                    ' ' +
                    json['apellido1'] +
                    ' ' +
                    json['apellido2']
            : json['nombre1'] + ' ' + json['apellido1']
        : '';
    return Simat(
      ano: json['ano'],
      etc: json['etc'],
      estado: json['estado'],
      jerarquia: json['jerarquia'],
      institucion: json['institucion'],
      dane: json['dane'],
      calendario: json['calendario'],
      sector: json['sector'],
      sede: json['sede'],
      codigoDaneSede: json['codigoDaneSede'],
      consecutivo: json['consecutivo'],
      zonaSede: json['zonaSede'],
      jornada: json['jornada'],
      gradoCod: json['gradoCod'],
      grupo: json['grupo'],
      modelo: json['modelo'],
      motivo: json['motivo'],
      fechaini: json['fechaini'],
      fechafin: json['fechafin'],
      nui: json['nui'],
      estrato: json['estrato'],
      sisbenTres: json['sisbenTres'],
      perId: json['perId'],
      doc: json['doc'],
      tipodoc: json['tipodoc'],
      apellido1: json['apellido1'],
      apellido2: json['apellido2'],
      nombre1: json['nombre1'],
      nombre2: json['nombre2'],
      genero: json['genero'],
      fechaNacimiento: json['fechaNacimiento'],
      barrio: json['barrio'],
      eps: json['eps'],
      tipoDeSangre: json['tipoDeSangre'],
      matriculacontratada: json['matriculacontratada'],
      fuenteRecursos: json['fuenteRecursos'],
      internado: json['internado'],
      numContrato: json['numContrato'],
      apoyoAcademicoEspecial: json['apoyoAcademicoEspecial'],
      srpa: json['srpa'],
      discapacidad: json['discapacidad'],
      paisOrigen: json['paisOrigen'],
      correo: json['correo'],
      id: json['id'],
      nombre: json['nombre'],
      activo: json['activo'],
      editado: json['editado'],
      fechaEdicion: json['fechaEdicion'],
      fechaCreacion: json['fechaCreacion'],
      plataformaState: json['plataformaState'],
    );
  }
  factory Simat.fromLocal(Map<String, dynamic> json) {
    var nombre = ((json['NOMBRE1'] != null) && (json['APELLIDO1'] != null))
        ? ((json['NOMBRE1'] != null) &&
                (json['APELLIDO1'] != null) &&
                (json['APELLIDO2'] != null))
            ? ((json['NOMBRE1'] != null) &&
                    (json['NOMBRE2'] != null) &&
                    (json['APELLIDO1'] != null) &&
                    (json['APELLIDO2'] != null))
                ? json['NOMBRE1'] +
                    ' ' +
                    json['NOMBRE2'] +
                    ' ' +
                    json['APELLIDO1'] +
                    ' ' +
                    json['APELLIDO2']
                : json['NOMBRE1'] +
                    ' ' +
                    json['APELLIDO1'] +
                    ' ' +
                    json['APELLIDO2']
            : json['NOMBRE1'] + ' ' + json['APELLIDO1']
        : '';
    return Simat(
        ano: json['AÑO'],
        etc: json['ETC'],
        estado: json['ESTADO'],
        jerarquia: json['JERARQUIA'],
        institucion: json['INSTITUCION'],
        dane: json['DANE'],
        calendario: json['CALENDARIO'],
        sector: json['SECTOR'],
        sede: json['SEDE'],
        codigoDaneSede: json['CODIGO_DANE_SEDE'],
        consecutivo: json['CONSECUTIVO'],
        zonaSede: json['ZONA_SEDE'],
        jornada: json['JORNADA'],
        gradoCod: json['GRADO_COD'],
        grupo: json['GRUPO'],
        modelo: json['MODELO'],
        motivo: json['MOTIVO'],
        fechaini: json['FECHAINI'],
        fechafin: json['FECHAFIN'],
        nui: json['NUI'],
        estrato: json['ESTRATO'],
        sisbenTres: json['SISBEN_TRES'],
        perId: json['PER_ID'],
        doc: json['DOC'],
        tipodoc: json['TIPODOC'],
        apellido1: json['APELLIDO1'],
        apellido2: json['APELLIDO2'],
        nombre1: json['NOMBRE1'],
        nombre2: json['NOMBRE2'],
        genero: json['GENERO'],
        fechaNacimiento: json['FECHA_NACIMIENTO'],
        barrio: json['BARRIO'],
        eps: json['EPS'],
        tipoDeSangre: json['TIPO DE SANGRE'],
        matriculacontratada: json['MATRICULACONTRATADA'],
        fuenteRecursos: json['FUENTE_RECURSOS'],
        internado: json['INTERNADO'],
        numContrato: json['NUM_CONTRATO'],
        apoyoAcademicoEspecial: json['APOYO_ACADEMICO_ESPECIAL'],
        srpa: json['SRPA'],
        discapacidad: json['DISCAPACIDAD'],
        paisOrigen: json['PAIS_ORIGEN'],
        correo: json['CORREO'],
        id: json['ID'],
        activo: json['ACTIVO'],
        editado: json['EDITADO'],
        fechaEdicion: json['FECHAEDICION'],
        fechaCreacion: json['FECHACREACION'],
        nombre: (json['NOMBRE']) ? json['NOMBRE'] : nombre,
        plataformaState: json['PLATAFORMASTATE']);
  }
  factory Simat.fromList(List<dynamic> list) {
    var nombre = ((list.asMap().containsKey(27)) &&
            (list.asMap().containsKey(25)))
        ? ((list.asMap().containsKey(27)) &&
                (list.asMap().containsKey(25)) &&
                (list.asMap().containsKey(26)))
            ? ((list.asMap().containsKey(27)) &&
                    (list.asMap().containsKey(28)) &&
                    (list.asMap().containsKey(25)) &&
                    (list.asMap().containsKey(26)))
                ? list[27] + ' ' + list[28] + ' ' + list[25] + ' ' + list[26]
                : list[27] + ' ' + list[25] + ' ' + list[26]
            : list[27] + ' ' + list[25]
        : '';
    return Simat(
      ano: list.asMap().containsKey(0) ? list[0] : '',
      etc: list.asMap().containsKey(1) ? list[1] : '',
      estado: list.asMap().containsKey(2) ? list[2] : '',
      jerarquia: list.asMap().containsKey(3) ? list[3] : '',
      institucion: list.asMap().containsKey(4) ? list[4] : '',
      dane: list.asMap().containsKey(5) ? list[5] : '',
      calendario: list.asMap().containsKey(6) ? list[6] : '',
      sector: list.asMap().containsKey(7) ? list[7] : '',
      sede: list.asMap().containsKey(8) ? list[8] : '',
      codigoDaneSede: list.asMap().containsKey(9) ? list[9] : '',
      consecutivo: list.asMap().containsKey(10) ? list[10] : '',
      zonaSede: list.asMap().containsKey(11) ? list[11] : '',
      jornada: list.asMap().containsKey(12) ? list[12] : '',
      gradoCod: list.asMap().containsKey(13) ? list[13] : '',
      grupo: list.asMap().containsKey(14) ? list[14] : '',
      modelo: list.asMap().containsKey(15) ? list[15] : '',
      motivo: list.asMap().containsKey(16) ? list[16] : '',
      fechaini: list.asMap().containsKey(17) ? list[17] : '',
      fechafin: list.asMap().containsKey(18) ? list[18] : '',
      nui: list.asMap().containsKey(19) ? list[19] : '',
      estrato: list.asMap().containsKey(20) ? list[20] : '',
      sisbenTres: list.asMap().containsKey(21) ? list[21] : '',
      perId: list.asMap().containsKey(22) ? list[22] : '',
      doc: list.asMap().containsKey(23) ? list[23] : '',
      tipodoc: list.asMap().containsKey(24) ? list[24] : '',
      apellido1: list.asMap().containsKey(25) ? list[25] : '',
      apellido2: list.asMap().containsKey(26) ? list[26] : '',
      nombre1: list.asMap().containsKey(27) ? list[27] : '',
      nombre2: list.asMap().containsKey(28) ? list[28] : '',
      genero: list.asMap().containsKey(29) ? list[29] : '',
      fechaNacimiento: list.asMap().containsKey(30) ? list[30] : '',
      barrio: list.asMap().containsKey(31) ? list[31] : '',
      eps: list.asMap().containsKey(32) ? list[32] : '',
      tipoDeSangre: list.asMap().containsKey(33) ? list[33] : '',
      matriculacontratada: list.asMap().containsKey(34) ? list[34] : '',
      fuenteRecursos: list.asMap().containsKey(35) ? list[35] : '',
      internado: list.asMap().containsKey(36) ? list[36] : '',
      numContrato: list.asMap().containsKey(37) ? list[37] : '',
      apoyoAcademicoEspecial: list.asMap().containsKey(38) ? list[38] : '',
      srpa: list.asMap().containsKey(39) ? list[39] : '',
      discapacidad: list.asMap().containsKey(40) ? list[40] : '',
      paisOrigen: list.asMap().containsKey(41) ? list[41] : '',
      correo: list.asMap().containsKey(42) ? list[42] : '',
      id: list.asMap().containsKey(43) ? list[43].toString() : '',
      nombre: list.asMap().containsKey(44) ? list[44].toString() : nombre,
      activo: list.asMap().containsKey(45)
          ? list[45].toString().toLowerCase().parseBool()
          : true,
      editado: list.asMap().containsKey(46)
          ? list[46].toString().toLowerCase().parseBool()
          : false,
      fechaEdicion: list.asMap().containsKey(47) ? list[47] : '',
      fechaCreacion: list.asMap().containsKey(48) ? list[48] : '',
      plataformaState: list.asMap().containsKey(49) ? list[49].toString() : '',
    );
  }

  List toSheet(Simat data) {
    List<dynamic> simat = [];
    var list = data.toJson();
    list.forEach((key, value) {
      // print([key.toString(), value.toString()]);
      if ((value.toString().length == 0) || (value.toString().length == 1)) {
        simat.add('');
      } else if (value.toString().length >= 2) {
        simat.add(value);
      }
    });
    return simat;
  }

  Map toJson() => {
        'ano': ano,
        'etc': etc,
        'estado': estado,
        'jerarquia': jerarquia,
        'institucion': institucion,
        'dane': dane,
        'calendario': calendario,
        'sector': sector,
        'sede': sede,
        'codigoDaneSede': codigoDaneSede,
        'consecutivo': consecutivo,
        'zonaSede': zonaSede,
        'jornada': jornada,
        'gradoCod': gradoCod,
        'grupo': grupo,
        'modelo': modelo,
        'motivo': motivo,
        'fechaini': fechaini,
        'fechafin': fechafin,
        'nui': nui,
        'estrato': estrato,
        'sisbenTres': sisbenTres,
        'perId': perId,
        'doc': doc,
        'tipodoc': tipodoc,
        'apellido1': apellido1,
        'apellido2': apellido2,
        'nombre1': nombre1,
        'nombre2': nombre2,
        'genero': genero,
        'fechaNacimiento': fechaNacimiento,
        'barrio': barrio,
        'eps': eps,
        'tipoDeSangre': tipoDeSangre,
        'matriculacontratada': matriculacontratada,
        'fuenteRecursos': fuenteRecursos,
        'internado': internado,
        'numContrato': numContrato,
        'apoyoAcademicoEspecial': apoyoAcademicoEspecial,
        'srpa': srpa,
        'discapacidad': discapacidad,
        'paisOrigen': paisOrigen,
        'correo': correo,
        'id': id,
        'nombre': nombre,
        'activo': activo,
        'editado': editado,
        'fechaEdicion': fechaEdicion,
        'fechaCreacion': fechaCreacion,
        'plataformaState': plataformaState,
      };
}

class GsuiteUser {
  // adaptador para crear usuarios con directory api de g-suite
  String id;
  Map<String, dynamic> name;
  String password;
  String primaryEmail;
  String organizations;
  String orgUnitPath;
  // includeInGlobalAddressList
  // relations
  // addresses
  // phones
  // gender
  // customSchemas
  GsuiteUser({
    this.id,
    this.name,
    this.password,
    this.primaryEmail,
    this.organizations,
    this.orgUnitPath,
  });
  factory GsuiteUser.fromJson(Map<String, dynamic> json) {
    var familyName = (json['apellido2'] != null)
        ? json['apellido1'] + ' ' + json['apellido2']
        : json['apellido1'];
    var givenName = (json['nombre2'] != null)
        ? json['nombre1'] + ' ' + json['nombre2']
        : json['nombre1'];
    var fullName = givenName + ' ' + familyName;
    var primaryEmail = json['nombre1'] +
        '.' +
        json['apellido1'] +
        '.' +
        json['apellido2'] +
        '@estudiantes.lreginaldofischione.edu.co'; // .toString().toLowerCase()
    var sede = '';
    switch (json['sede']) {
      case 'LIVIO REGINALDO FISCHIONE':
        sede = 'Principal';
        break;
      case 'EL PARAISO':
        sede = 'Paraiso';
        break;
      case 'CELIA CATALINA DE L¢PEZ':
        sede = 'Celia Catalina';
        break;
      default:
    }
    var orgUnitPath = '/Ensayo/' +
        sede +
        '/' +
        capitalize(json['jornada']) +
        '/Estudiantes/2020';
    return GsuiteUser(
      id: '',
      name: {
        'familyName': capitalize(familyName),
        'givenName': capitalize(givenName),
        'fullName': capitalize(fullName)
      },
      password: '123456789',
      primaryEmail: primaryEmail.toString().toLowerCase(),
      orgUnitPath: '/Ensayo', //orgUnitPath,
      organizations: '',
    );
  }
  Map toJson() => {
        'id': id,
        'name': name,
        'password': password,
        'primaryEmail': primaryEmail,
        'organizations': organizations,
        'orgUnitPath': orgUnitPath,
      };
}

class GescolarUser {
  String id;
  String ano;
  String photoURL;
  String nombre;
  String sede;
  String jornada;
  String grado;
  String grupo;
  String fechaCreacion;
  bool activo;
  bool editado;
  String rol;
  String email;
  String genero;
  String fechaMatricula;
  String fechaNacimiento;
  String documentoTipo;
  String documentoNum;
  String telefonos;
  String direcciones;
  String relaciones;
  String token;
  String fechaEdicion;
  //------------
  bool selected;
  int index;
  String plataformaState;
  Simat simat;

  GescolarUser(
      {this.id,
      this.ano,
      this.photoURL,
      this.nombre,
      this.sede,
      this.jornada,
      this.grado,
      this.grupo,
      this.fechaCreacion,
      this.activo,
      this.editado,
      this.rol,
      this.email,
      this.genero,
      this.fechaMatricula,
      this.fechaNacimiento,
      this.documentoTipo,
      this.documentoNum,
      this.telefonos,
      this.direcciones,
      this.relaciones,
      this.token,
      this.fechaEdicion,
      this.selected,
      this.index,
      this.plataformaState,
      this.simat});

  factory GescolarUser.fromJson(Map<String, dynamic> json) {
    var nombre = ((json['nombre1'] != null) && (json['apellido1'] != null))
        ? ((json['nombre1'] != null) &&
                (json['apellido1'] != null) &&
                (json['apellido2'] != null))
            ? ((json['nombre1'] != null) &&
                    (json['nombre2'] != null) &&
                    (json['apellido1'] != null) &&
                    (json['apellido2'] != null))
                ? json['nombre1'] +
                    ' ' +
                    json['nombre2'] +
                    ' ' +
                    json['apellido1'] +
                    ' ' +
                    json['apellido2']
                : json['nombre1'] +
                    ' ' +
                    json['apellido1'] +
                    ' ' +
                    json['apellido2']
            : json['nombre1'] + ' ' + json['apellido1']
        : '';
    return GescolarUser(
      ano: json['ano'],
      nombre: nombre,
      sede: json['sede'],
      jornada: json['jornada'],
      grado: json['gradoCod'],
      grupo: json['grupo'],
      fechaCreacion: DateTime.now().toString(),
      activo:
          (json['plataformaState'] == 'ok') ? true : false, // TODO como activar
      editado: false,
      rol: 'Estudiante',
      fechaMatricula: json['fechaini'],
      documentoNum: json['doc'],
      documentoTipo: json['tipodoc'],
      genero: json['genero'],
      fechaNacimiento: json['fechaNacimiento'],
      email: json['correo'],
      selected: false,
      index: 0,
      plataformaState: json['plataformaState'],
      simat: Simat.fromJson(json),
    );
  }
  factory GescolarUser.fromLocal(Map<String, dynamic> json) {
    var nombre = ((json['NOMBRE1'] != null) && (json['APELLIDO1'] != null))
        ? ((json['NOMBRE1'] != null) &&
                (json['APELLIDO1'] != null) &&
                (json['APELLIDO2'] != null))
            ? ((json['NOMBRE1'] != null) &&
                    (json['NOMBRE2'] != null) &&
                    (json['APELLIDO1'] != null) &&
                    (json['APELLIDO2'] != null))
                ? json['NOMBRE1'] +
                    ' ' +
                    json['NOMBRE2'] +
                    ' ' +
                    json['APELLIDO1'] +
                    ' ' +
                    json['APELLIDO2']
                : json['NOMBRE1'] +
                    ' ' +
                    json['APELLIDO1'] +
                    ' ' +
                    json['APELLIDO2']
            : json['NOMBRE1'] + ' ' + json['APELLIDO1']
        : '';
    return GescolarUser(
      ano: json['ANO'],
      nombre: nombre,
      sede: json['SEDE'],
      jornada: json['JORNADA'],
      grado: json['GRADO_COD'],
      grupo: json['GRUPO'],
      fechaCreacion: DateTime.now().toString(),
      activo: true,
      editado: false,
      rol: 'Estudiante',
      fechaMatricula: json['FECHAINI'],
      documentoNum: json['DOC'],
      documentoTipo: json['TIPODOC'],
      genero: json['GENERO'],
      fechaNacimiento: json['FECHA_NACIMIENTO'],
      email: json['CORREO'],
      selected: false,
      index: 0,
      plataformaState: 'pendiente',
      simat: Simat.fromLocal(json),
    );
  }
  factory GescolarUser.fromList(List<dynamic> list) {
    var nombre = ((list.asMap().containsKey(27)) &&
            (list.asMap().containsKey(25)))
        ? ((list.asMap().containsKey(27)) &&
                (list.asMap().containsKey(25)) &&
                (list.asMap().containsKey(26)))
            ? ((list.asMap().containsKey(27)) &&
                    (list.asMap().containsKey(28)) &&
                    (list.asMap().containsKey(25)) &&
                    (list.asMap().containsKey(26)))
                ? list[27] + ' ' + list[28] + ' ' + list[25] + ' ' + list[26]
                : list[27] + ' ' + list[25] + ' ' + list[26]
            : list[27] + ' ' + list[25]
        : '';
    return GescolarUser(
      ano: (list.asMap().containsKey(0)) ? list[0] : '',
      nombre: nombre,
      sede: (list.asMap().containsKey(8)) ? list[8] : '',
      jornada: (list.asMap().containsKey(12)) ? list[12] : '',
      grado: (list.asMap().containsKey(13)) ? list[13] : '',
      grupo: (list.asMap().containsKey(14)) ? list[14] : '',
      fechaCreacion: DateTime.now().toString(),
      activo: true,
      editado: false,
      rol: 'Estudiante',
      fechaMatricula: (list.asMap().containsKey(17)) ? list[17] : '',
      documentoNum: (list.asMap().containsKey(23)) ? list[23] : '',
      documentoTipo: (list.asMap().containsKey(24)) ? list[24] : '',
      genero: (list.asMap().containsKey(29)) ? list[29] : '',
      fechaNacimiento: (list.asMap().containsKey(30)) ? list[30] : '',
      email: (list.asMap().containsKey(42)) ? list[42] : '',
      selected: false,
      index: 0,
      plataformaState: 'pendiente',
      simat: Simat.fromList(list),
    );
  }
  Map toJson() => {
        'ano': ano,
        'nombre': nombre,
        'sede': sede,
        'jornada': jornada,
        'grado': grado,
        'grupo': grupo,
        'fechaCreacion': fechaCreacion,
        'activo': activo,
        'editado': editado,
        'rol': rol,
        'fechaMatricula': fechaMatricula,
        'documentoNum': documentoNum,
        'documentoTipo': documentoTipo,
        'genero': genero,
        'fechaNacimiento': fechaNacimiento,
        'email': email,
        'selected': selected,
        'index': index,
        'plataformaState': plataformaState,
        'simat': simat,
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

class NewGrado {
  String nivelEstudios;
  String nombre;
  String codigo;
  String siguiente;
  bool siguienteTest = false;
  NewGrado({
    this.nivelEstudios,
    this.nombre,
    this.codigo,
    this.siguiente,
    this.siguienteTest: false,
  });
  Map toJson() => {
        'nivelEstudios': nivelEstudios,
        'codigo': codigo,
        'nombre': nombre,
        'siguiente': siguiente,
        'siguienteTest': siguienteTest,
      };
}

class Posiciones {
  // padding
  // top
  // bottom
  // left
  // right
  Pad padding = Pad();
  double top = 0;
  double bottom = 0;
  double left = 0;
  double right = 0;
  Posiciones({this.padding});
  Map toJson() => {
        'padding': (padding != null) ? padding.toJson() : Pad(),
        'top': top,
        'bottom': bottom,
        'left': left,
        'right': right,
      };
}

class Pad {
  double top = 0;
  double bottom = 0;
  double left = 0;
  double right = 0;
  Pad({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });
  Map toJson() => {
        'top': top,
        'bottom': bottom,
        'left': left,
        'right': right,
      };
}

capitalize(String string) {
  // if (string == null) {
  //   throw ArgumentError("string: $string");
  // }

  // if (string.isEmpty) {
  //   return string;
  // }

  return string[0].toUpperCase() + string.substring(1);
}

// --- animacion para las rutas ----
/* class Routes {
  static const String sedes = "/";
  static const String landing = "landing";
  static const String style = "style";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
} */
