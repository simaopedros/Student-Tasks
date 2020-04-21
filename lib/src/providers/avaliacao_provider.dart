import 'dart:convert';

import 'package:http/http.dart' as http;


import 'package:appuniversitario/src/models/avaliacao_model.dart';


class AvaliacaoProvier{
  final String _url ="https://meusapp-931b4.firebaseio.com";

  Future<bool> criarAvaliacao(AvaliacoesModel avaliacoesModel, String usuario) async {
    final url = "$_url/$usuario/avaliacoes.json";
    await http.post(url, body: avaliacoesModelToJson(avaliacoesModel));
    return true;
  }

  Future<bool> deletarAvaliacao(String avaliacao, String usuario) async {
    final url = "$_url/$usuario/avaliacoes/$avaliacao.json";
    await http.delete(url);
    return true;
  }

  Future<List<AvaliacoesModel>> carregarAvaliacao(String usuario) async {
    final url = "$_url/$usuario/avaliacoes.json";
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