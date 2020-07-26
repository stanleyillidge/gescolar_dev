import 'package:gescolar_dev/models/selecciones.dart';

class Institucion {
  String key;
  String nombre;
  String mision;
  String calendario;
  String razonSocial;
  String rut;
  String nit;
  String escudo;
  String dane;
  String resolucionAprobacion;
  String generoAtendido;
  NivelEnsenanza nivelEnsenanza;

  Institucion({
    this.key,
    this.nombre,
    this.mision,
    this.calendario,
    this.razonSocial,
    this.rut,
    this.nit,
    this.escudo,
    this.dane,
    this.resolucionAprobacion,
    this.generoAtendido,
    this.nivelEnsenanza,
  });
  Institucion.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        nombre = json['nombre'],
        mision = json['mision'],
        calendario = json['calendario'],
        razonSocial = json['razonSocial'],
        rut = json['rut'],
        nit = json['nit'],
        escudo = json['escudo'],
        dane = json['dane'],
        resolucionAprobacion = json['resolucionAprobacion'],
        generoAtendido = json['generoAtendido'],
        nivelEnsenanza = json['nivelEnsenanza'];

  Map<String, dynamic> toJson() => {
        'key': key,
        'nombre': nombre,
        'mision': mision,
        'calendario': calendario,
        'razonSocial': razonSocial,
        'rut': rut,
        'nit': nit,
        'escudo': escudo,
        'dane': dane,
        'resolucionAprobacion': resolucionAprobacion,
        'generoAtendido': generoAtendido,
        'nivelEnsenanza': nivelEnsenanza.toJson()
      };
}

class NivelEnsenanza {
  bool preescolar;
  bool basicaPrimaria;
  bool basicaSecundaria;
  bool educacionBasicaAdultos;
  bool educacionMedia;
  bool educacionMediaAdultos;

  NivelEnsenanza({
    this.preescolar = false,
    this.basicaPrimaria = false,
    this.basicaSecundaria = false,
    this.educacionBasicaAdultos = false,
    this.educacionMedia = false,
    this.educacionMediaAdultos = false,
  });
  NivelEnsenanza.fromJson(Map<bool, dynamic> json)
      : preescolar = json['preescolar'],
        basicaPrimaria = json['    basicaPrimaria'],
        basicaSecundaria = json['    basicaSecundaria'],
        educacionBasicaAdultos = json['    educacionBasicaAdultos'],
        educacionMedia = json['    educacionMedia'],
        educacionMediaAdultos = json['    educacionMediaAdultos'];
  Map<String, dynamic> toJson() => {
        'preescolar': preescolar,
        'basicaPrimaria': basicaPrimaria,
        'basicaSecundaria': basicaSecundaria,
        'educacionBasicaAdultos': educacionBasicaAdultos,
        'educacionMedia': educacionMedia,
        'educacionMediaAdultos': educacionMediaAdultos,
      };
}
