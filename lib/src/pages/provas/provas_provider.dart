import 'package:appuniversitario/src/pages/provas/provas_model.dart';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AvaliacaoProvier {
  final _prefs = new PreferenciasUsuario();
  final db = Firestore.instance;
  
  
  Future<bool> criarAvaliacao(AvaliacoesModel avaliacoesModel) async {

    db.settings(persistenceEnabled: true);
    
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Avaliacoes")
        .add(avaliacoesModel.toJson());
    return true;
  }

  Future<bool> deletarAvaliacao(String avaliacao) async {

    db.settings(persistenceEnabled: true);

    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Avaliacoes")
        .document(avaliacao)
        .delete();
    return true;
  }

  Future<List<AvaliacoesModel>> carregarAvaliacao() async {

    db.settings(persistenceEnabled: true);

    QuerySnapshot resultado = await db
    .collection(_prefs.usuario)
    .document("dados")
    .collection("Avaliacoes")
    .getDocuments();

    final List<AvaliacoesModel> avaliacoes = new List();
    
    resultado.documents.forEach((avaliacao){
    AvaliacoesModel avaTemp = new AvaliacoesModel();
    avaTemp.id = avaliacao.documentID;
    avaTemp.conteudo = avaliacao.data['conteudo'];
    avaTemp.corB = avaliacao.data['corB'];
    avaTemp.corG = avaliacao.data['corG'];
    avaTemp.corR = avaliacao.data['corR'];
    avaTemp.data = avaliacao.data['data'];
    avaTemp.materia = avaliacao.data['materia'];
    avaliacoes.add(avaTemp);
    });
    return avaliacoes;
  }
}
