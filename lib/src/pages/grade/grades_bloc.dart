import 'package:appuniversitario/src/pages/grade/grade_model.dart';
export 'package:appuniversitario/src/pages/grade/grade_model.dart';

import 'package:appuniversitario/src/pages/grade/grade_provider.dart';
export 'package:appuniversitario/src/pages/grade/grade_provider.dart';


import 'package:rxdart/rxdart.dart';

class GradesBloc {

  final _gradesController = new BehaviorSubject<List<GradeModel>>();
  final _gradeProvider = new GradeProvider();

  Stream<List<GradeModel>> get gradesStream => _gradesController.stream;

  void carregarG(String user) async {
    _gradesController.sink.add(await _gradeProvider.carregarGrades());
  }

  void adicionarGrade(GradeModel grade, String usuario) async {
    await _gradeProvider.criarGrade(grade);
    carregarG(usuario);
  }


  void editarGrade(GradeModel grade, String usuario) async {
    await _gradeProvider.editarGrade(grade);
    carregarG(usuario);
  }

  void deletarGrade(String id, String usuario) async {
    await _gradeProvider.deletarGrade(id);
    carregarG(usuario);
  }

  dispose(){
    _gradesController.close();
  }
}