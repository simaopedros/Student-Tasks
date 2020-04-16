import 'package:appuniversitario/src/models/materia_model.dart';
export 'package:appuniversitario/src/models/materia_model.dart';

import 'package:appuniversitario/src/providers/materias_provider.dart';
export 'package:appuniversitario/src/providers/materias_provider.dart';

import 'package:rxdart/rxdart.dart';

class MateriaBloc {
  final _materiaController = new BehaviorSubject<List<MateriaModel>>();
  final _materiaProvider = new MateriasProvider();

  Stream<List<MateriaModel>> get materiasStream => _materiaController.stream;


  void carregarMaterias(String usuario) async {
    _materiaController.sink.add(await _materiaProvider.carregarMaterias(usuario));
  }

  void criarMaterias(MateriaModel materia, String usuario) async {
    await _materiaProvider.criarMateria(materia, usuario);
    carregarMaterias(usuario);
  }

  void deletarNota(MateriaModel materia, String usuario) async {
    _materiaProvider.deletarMateria(materia, usuario);
  }

  dispose(){
    _materiaController.close();

  }

}