


import 'package:appuniversitario/src/models/grade_model.dart';
import 'package:appuniversitario/src/providers/grade_provider.dart';
import 'package:rxdart/rxdart.dart';

class GradesBloc {

  final _gradesController = new BehaviorSubject<List<GradeModel>>();
  final _gradeProvider = new GradeProvider();

  Stream<List<GradeModel>> get gradesStream => _gradesController.stream;

  void carregarGrades(String usuario) async {
    _gradesController.sink.add(await _gradeProvider.carregarGrade(usuario));
  }

  void adicionarGrade(GradeModel grade, String usuario) async {
    await _gradeProvider.criarGrade(grade, usuario);
    carregarGrades(usuario);
  }


  dispose(){
    _gradesController.close();
  }
}