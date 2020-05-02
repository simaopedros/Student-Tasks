import 'package:appuniversitario/src/models/estudo_model.dart';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EstudosProvier {
  final _prefs = new PreferenciasUsuario();
  final db = Firestore.instance;

  Future<bool> criarEstudo(EstudosModel estudo, String diaSemana) async {
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Estudos")
        .document("semana")
        .collection(diaSemana)
        .add(estudo.toJson());
    return true;
  }

  Future<bool> deletarEstudo(String diaSemana, String estudoId) async {
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Estudos")
        .document("semana")
        .collection(diaSemana)
        .document(estudoId)
        .delete();
    return true;
  }

  Future<List<EstudosModel>> carregarEstudosSemana(String diaDaSemana) async {
    QuerySnapshot resultado = await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Estudos")
        .document("semana")
        .collection(diaDaSemana)
        .getDocuments();

    final List<EstudosModel> estudos = new List();

    resultado.documents.forEach((estudo){
    EstudosModel estudoTemp = new EstudosModel();
    estudoTemp.id = estudo.documentID;
    estudoTemp.assunto = estudo.data['assunto'];
    estudoTemp.horaFinal = estudo.data['hora_final'];
    estudoTemp.horaInicio = estudo.data['hora_inicio'];
    estudos.add(estudoTemp);
    });
    return estudos;
  }
}
