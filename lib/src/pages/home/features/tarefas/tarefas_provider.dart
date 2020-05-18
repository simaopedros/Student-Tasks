import 'package:appuniversitario/src/pages/home/features/tarefas/tarefa_model.dart';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TarefasProvider {
  final db = Firestore.instance; 
  final user = FirebaseAuth.instance.currentUser();

  final _prefs = new PreferenciasUsuario();

  Future<bool> criarTarefa(TarefaModel tarefa) async {    
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Tarefas")
        .add(tarefa.toJson());
    carregarTarefas();
    return true;
  }

  Future<bool> atualizarTarefa(TarefaModel tarefa) async {
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Tarefas")
        .document(tarefa.id)
        .updateData(tarefa.toJson());
    return true;
  }

  Future<bool> deletarTarefa(TarefaModel tarefaModel)async{
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Tarefas")
        .document(tarefaModel.id)
        .delete();
    return true;
  }

  Future<List<TarefaModel>> carregarTarefas() async {
    
    QuerySnapshot resultado = await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Tarefas").orderBy("status", descending: true)
        .getDocuments();
    final List<TarefaModel> tarefas = new List();

    resultado.documents.forEach((tarefa) {
      TarefaModel tarTemp = new TarefaModel();
      tarTemp.id = tarefa.documentID;
      tarTemp.tarefa = tarefa.data['tarefa'];
      tarTemp.status = tarefa.data['status'];
      tarefas.add(tarTemp);
    });
    return tarefas;
  }
}
