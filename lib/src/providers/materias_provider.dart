import 'dart:convert';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:http/http.dart' as http;

import 'package:appuniversitario/src/models/materia_model.dart';

class MateriasProvider {
  final String _url = 'https://meusapp-931b4.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> criarMateria(MateriaModel materia) async {

    final url = "$_url/${ _prefs.usuario }/materias.json?auth=${_prefs.token}";
    await http.post(url, body: materiaModelToJson(materia));
    
    return true;
  }

  Future<bool> deletarMateria(MateriaModel materia) async {

    final url = "$_url/${ _prefs.usuario }/materias/${ materia.id }.json?auth=${_prefs.token}";
    await http.delete(url);
    return true;
  }

  Future<List<MateriaModel>> carregarMaterias() async {


    final url = "$_url/${ _prefs.usuario }/materias.json?auth=${_prefs.token}";

    final resp = await http.get(url);
    final List<MateriaModel> materias = new List();

    final Map<String, dynamic> decodeNota = json.decode(resp.body);

    if(decodeNota == null) return [];


    decodeNota.forEach((id, materia){
      final matTemp = MateriaModel.fromJson(materia);
      matTemp.id = id;
      materias.add(matTemp);
    });
    return materias;
  }
}