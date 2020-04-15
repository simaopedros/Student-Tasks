import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:appuniversitario/src/models/tarefa_model.dart';

class TarefasProvider{

  final String _url = 'https://meusapp-931b4.firebaseio.com';


  Future<bool> criarTarefa(TarefaModel tarefa, String usuario) async {
    final url = '$_url/$usuario/tarefas.json';    
    final resp = await http.post(url, body: tarefaModelToJson(tarefa));
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<bool> atualizarTarefa(TarefaModel tarefa, String usuario) async {
    final url = '$_url/$usuario/tarefas/${ tarefa.id }.json';    
    final resp = await http.put(url, body: tarefaModelToJson(tarefa));
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }


  Future<bool> deletarTarefa(String tarefa, String usuario) async {
    final url = '$_url/$usuario/tarefas/$tarefa.json';    
    final resp = await http.delete(url);
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }


  Future<List<TarefaModel>> carregarTarefas(String usuario) async {
    final url = '$_url/$usuario/tarefas.json';

    final resp = await http.get(url);
    final List<TarefaModel> tarefas = new List();
    final Map<String, dynamic> decodeData = json.decode(resp.body);
     
    if(decodeData == null) return [];

    decodeData.forEach((id, tarefa){
      
      final tarTemp = TarefaModel.fromJson(tarefa);
      tarTemp.id = id;
      tarefas.add(tarTemp);

    });


    return tarefas;
  }

  Future<int> apagarTarefa(String id, String usuario) async{
    final url = '$_url/$usuario/tarefas/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));
    return 1;
  }


  Future<TarefaModel> carregarUmaTarefa(String usuario, String tarefaId) async {

    final url = '$_url/$usuario/tarefas/$tarefaId.json';
    final resp = await http.get(url);
    final tarefa = json.decode(resp.body);

    print(tarefa);
    return tarefa;
  }


}