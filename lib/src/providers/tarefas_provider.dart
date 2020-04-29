import 'dart:convert';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:appuniversitario/src/providers/usuario_provieder.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';


import 'package:appuniversitario/src/models/tarefa_model.dart';

class TarefasProvider{

  FirebaseUser user;
  
  
  final String _url = 'https://meusapp-931b4.firebaseio.com';
  final _prefs = new PreferenciasUsuario();
  final loginProvider = new Usuariorovider();


  Future<bool> verificaLogado() async{
    final url = '$_url/${ _prefs.usuario }/tarefas.json?auth=${_prefs.token}';
    final resp = await http.get(url);
  
    return resp.body.contains("error");
  }
  
  Future<bool> criarTarefa(TarefaModel tarefa) async {
    final url = '$_url/${ _prefs.usuario }/tarefas.json?auth=${_prefs.token}';    
    final resp = await http.post(url, body: tarefaModelToJson(tarefa));
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<bool> atualizarTarefa(TarefaModel tarefa) async {
    
    final url = '$_url/${ _prefs.usuario }/tarefas/${ tarefa.id }.json?auth=${_prefs.token}';    
    final resp = await http.put(url, body: tarefaModelToJson(tarefa));
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }


  Future<bool> deletarTarefa(String tarefa) async {

    
    final url = '$_url/${ _prefs.usuario }/tarefas/$tarefa.json?auth=${_prefs.token}';    
    final resp = await http.delete(url);
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }


  Future<List<TarefaModel>> carregarTarefas() async {   

    final url = '$_url/${ _prefs.usuario }/tarefas.json?auth=${_prefs.token}';
    final resp = await http.get(url);    

    

    final List<TarefaModel> tarefas = new List();
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    
    if(decodeData == null) return [];

    if(decodeData.containsKey('error')){
      await loginProvider.login("${_prefs.email}", "${_prefs.senha}");
      carregarTarefas();
    }
    

    decodeData.forEach((id, tarefa){      
      final tarTemp = TarefaModel.fromJson(tarefa);
      tarTemp.id = id;
      tarefas.add(tarTemp);

    });


    return tarefas;
  }

  Future<int> apagarTarefa(String id) async{

    final url = '$_url/${ _prefs.usuario }/tarefas/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    print(json.decode(resp.body));
    return 1;
  }


  Future<TarefaModel> carregarUmaTarefa(String tarefaId) async {


    final url = '$_url/${ _prefs.usuario }/tarefas/$tarefaId.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    final tarefa = json.decode(resp.body);

    print(tarefa);
    return tarefa;
  }


}