import 'dart:convert';

import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:http/http.dart' as http;


import 'package:appuniversitario/src/models/avaliacao_model.dart';


class AvaliacaoProvier{
  final String _url ="https://meusapp-931b4.firebaseio.com";
  final _prefs = new PreferenciasUsuario();

  Future<bool> criarAvaliacao(AvaliacoesModel avaliacoesModel) async {

        
    final url = "$_url/${ _prefs.usuario }/avaliacoes.json?auth=${_prefs.token}";
    await http.post(url, body: avaliacoesModelToJson(avaliacoesModel));
    return true;
  }

  Future<bool> deletarAvaliacao(String avaliacao) async {

   
    final url = "$_url/${ _prefs.usuario }/avaliacoes/$avaliacao.json?auth=${_prefs.token}";
    await http.delete(url);
    return true;
  }

  Future<List<AvaliacoesModel>> carregarAvaliacao() async {
    
    
    final url = "$_url/${ _prefs.usuario }/avaliacoes.json?auth=${_prefs.token}";
    final resp = await http.get(url);
    final List<AvaliacoesModel> avaliacoes = new List();

    final Map<String, dynamic> decodeAvaliacoes = json.decode(resp.body);

    if(decodeAvaliacoes == null) return [];

    decodeAvaliacoes.forEach((id, avaliacao){
      final avalTemp = AvaliacoesModel.fromJson(avaliacao);
      avalTemp.id = id;
      avaliacoes.add(avalTemp);
    });

    return avaliacoes;
  }
}