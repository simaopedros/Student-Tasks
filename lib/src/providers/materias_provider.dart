import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:appuniversitario/src/models/materia_model.dart';

class MateriasProvider {
  final String _url = 'https://meusapp-931b4.firebaseio.com';

  Future<bool> criarMateria(MateriaModel materia, String usuario) async {
    final url = "$_url/$usuario/materias.json";
    await http.post(url, body: materiaModelToJson(materia));
    
    return true;
  }

  Future<bool> deletarMateria(MateriaModel materia, String usuario) async {
    final url = "$_url/$usuario/materias/${ materia.id }.json";
    await http.delete(url);
    return true;
  }

  Future<List<MateriaModel>> carregarMaterias(String usuario) async {
    final url = "$_url/$usuario/materias.json";

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