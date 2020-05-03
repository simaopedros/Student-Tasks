import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';

import 'package:appuniversitario/src/models/bocodenotas_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlocoDeNotasProvider {

    final _prefs = new PreferenciasUsuario();
    final db = Firestore.instance;

    Future<bool> criarNota(BlocoDeNotasModel nota) async {
      db.settings(persistenceEnabled: true);
      await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Notas")
        .add(nota.toJson());
    return true;
  }


  Future<bool> deletarNota(BlocoDeNotasModel nota) async {
    db.settings(persistenceEnabled: true);
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Notas")
        .document(nota.id)
        .delete();

    return true;
  }


  Future<List<BlocoDeNotasModel>> carregarNotas() async {
    db.settings(persistenceEnabled: true);
    QuerySnapshot resultado = await db
    .collection(_prefs.usuario)
    .document("dados")
    .collection("Notas")
    .getDocuments();

    final List<BlocoDeNotasModel> notas = new List();

    resultado.documents.forEach((nota){
      BlocoDeNotasModel notaTemp = new BlocoDeNotasModel();
      notaTemp.id = nota.documentID;
      notaTemp.nota = nota.data['nota'];
      notas.add(notaTemp);
    });

    return notas;
  }

}