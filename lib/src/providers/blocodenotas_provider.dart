
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:appuniversitario/src/models/bocodenotas_model.dart';

class BlocoDeNotasProvider {
    final String _url = 'https://meusapp-931b4.firebaseio.com';

    Future<bool> criarNota(BlocoDeNotasModel nota, String usuario) async {
    final url = '$_url/$usuario/notas.json';
    final resp = await http.post(url, body: blocoDeNotasModelToJson(nota));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }


  Future<bool> deletarNota(BlocoDeNotasModel nota, String usuario) async {
    final url =  '$_url/$usuario/notas/${ nota.id }.json'; 
    final resp = await http.delete(url);
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }


  Future<List<BlocoDeNotasModel>> carregarNotas(String usuario) async {
    final url = '$_url/$usuario/notas.json';

    final resp = await http.get(url);
    final List<BlocoDeNotasModel> notas = new List();

    final Map<String, dynamic> decodeData = json.decode(resp.body);

    if(decodeData == null) return [];

    decodeData.forEach((id, nota){
      final eventTemp = BlocoDeNotasModel.fromJson(nota);
      eventTemp.id = id;
      notas.add(eventTemp);
    });

    return notas;
  }

}