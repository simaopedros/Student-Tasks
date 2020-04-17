import 'dart:convert';
import 'package:appuniversitario/src/models/estudo_model.dart';
import 'package:http/http.dart' as http;

class EstudosProvier {
  final String _url = 'https://meusapp-931b4.firebaseio.com';


  Future<bool> criarEstudo(EstudosModel estudo, String diaSemana, String usuario) async {
    final url = "$_url/$usuario/estudos/$diaSemana.json";
    final resp = await http.post(url, body: estudosModelToJson(estudo));
    print(resp);
    return true;
  }

  Future<bool> deletarEstudo(String diaSemana, String estudoId, String usuario) async {
    final url = "$_url/$usuario/estudos/$diaSemana/$estudoId.json";
    final resp = await http.delete(url);
    print(resp);

    return true;

  }

  Future<List<EstudosModel>> carregarEstudosSemana(String usuario, String diaDaSemana) async {
    final url = "$_url/$usuario/estudos/$diaDaSemana.json";

    final resp = await http.get(url);
    final List<EstudosModel> estudos = new List();
    final Map<String, dynamic> decodeDiaSemana = json.decode(resp.body);

    if(decodeDiaSemana == null) return [];

    decodeDiaSemana.forEach((id, estudo){
      
      final estTemp = EstudosModel.fromJson(estudo);
      estTemp.id = id;
      estudos.add(estTemp);
    });

    return estudos;

  }

}