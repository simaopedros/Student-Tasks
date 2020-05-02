import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';

import 'package:appuniversitario/src/models/materia_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MateriasProvider {
  final _prefs = new PreferenciasUsuario();
  final db = Firestore.instance;

  Future<bool> criarMateria(MateriaModel materia) async {
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Materias")
        .add(materia.toJson());
    return true;
  }

  Future<bool> deletarMateria(MateriaModel materia) async {
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Materias")
        .document(materia.id)
        .delete();
    return true;
  }

  Future<List<MateriaModel>> carregarMaterias() async {
    QuerySnapshot resultado = await db
        .collection(_prefs.usuario)
        .document('dados')
        .collection('Materias')
        .getDocuments();

    final List<MateriaModel> materias = new List();

    resultado.documents.forEach((materia) {
      MateriaModel matTemp = new MateriaModel();
      matTemp.id = materia.documentID;
      matTemp.corb = materia.data['corb'];
      matTemp.corg = materia.data['corg'];
      matTemp.corr = materia.data['corr'];
      matTemp.materia = materia.data['materia'];
      materias.add(matTemp);
    });

    return materias;
  }
}
