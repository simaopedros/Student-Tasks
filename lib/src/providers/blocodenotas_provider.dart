
import 'dart:convert';

import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:http/http.dart' as http;

import 'package:appuniversitario/src/models/bocodenotas_model.dart';

class BlocoDeNotasProvider {
    final String _url = 'https://meusapp-931b4.firebaseio.com';
    final _prefs = new PreferenciasUsuario();

    Future<bool> criarNota(BlocoDeNotasModel nota) async {


    final url = '$_url/${ _prefs.usuario }/notas.json?auth=${ _prefs.token }';
    final resp = await http.post(url, body: blocoDeNotasModelToJson(nota));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }


  Future<bool> deletarNota(BlocoDeNotasModel nota) async {

    
    final url =  '$_url/${ _prefs.usuario }/notas/${ nota.id }.json?auth=${ _prefs.token }'; 
    final resp = await http.delete(url);
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }


  Future<List<BlocoDeNotasModel>> carregarNotas() async {

   
    final url = '$_url/${ _prefs.usuario }/notas.json?auth=${ _prefs.token }';

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