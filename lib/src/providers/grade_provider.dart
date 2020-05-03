import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:appuniversitario/src/models/grade_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GradeProvider {
  final _prefs = new PreferenciasUsuario();
  final db = Firestore.instance;

  Future<bool> criarGrade(GradeModel grade) async {
    db.settings(persistenceEnabled: true);
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Grade")
        .add(grade.toJson());
    return true;
  }

  Future<bool> deletarGrade(String id) async {
    db.settings(persistenceEnabled: true);
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Grade")
        .document(id)
        .delete();
    return true;
  }

  Future<bool> editarGrade(GradeModel grade) async {
    db.settings(persistenceEnabled: true);
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Grade")
        .document(grade.id)
        .updateData(grade.toJson());
    return true;
  }

  Future<List<GradeModel>> carregarGrades() async {
    db.settings(persistenceEnabled: true);
    QuerySnapshot resultado = await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Grade")
        .getDocuments();

    final List<GradeModel> grades = new List();

    resultado.documents.forEach((grade) {
      GradeModel gradeTemp = new GradeModel();
      gradeTemp.id = grade.documentID;
      gradeTemp.corB = grade.data['corB'];
      gradeTemp.corG = grade.data['corG'];
      gradeTemp.corR = grade.data['corR'];
      gradeTemp.dom = grade.data['dom'];
      gradeTemp.materia = grade.data['materia'];
      gradeTemp.media = grade.data['media'];
      gradeTemp.p1 = grade.data['p1'];
      gradeTemp.p2 = grade.data['p2'];
      gradeTemp.pesob1 = grade.data['pesob1'];
      gradeTemp.pesob2 = grade.data['pesob2'];
      gradeTemp.pesop1 = grade.data['pesop1'];
      gradeTemp.pesop2 = grade.data['pesop2'];
      gradeTemp.pesot1 = grade.data['pesot1'];
      gradeTemp.pesot2 = grade.data['pesot2'];
      gradeTemp.que = grade.data['que'];
      gradeTemp.qui = grade.data['qui'];
      gradeTemp.sab = grade.data['sab'];
      gradeTemp.seg = grade.data['seg'];
      gradeTemp.sex = grade.data['sex'];
      gradeTemp.t1 = grade.data['t1'];
      gradeTemp.t2 = grade.data['t2'];
      gradeTemp.ter = grade.data['ter'];

      grades.add(gradeTemp);
    });

    return grades;
  }
}
