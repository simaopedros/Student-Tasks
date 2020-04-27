import 'package:appuniversitario/src/models/materia_model.dart';
export 'package:appuniversitario/src/models/materia_model.dart';

import 'package:appuniversitario/src/providers/materias_provider.dart';
export 'package:appuniversitario/src/providers/materias_provider.dart';

import 'package:rxdart/rxdart.dart';

class MateriaBloc {
  final _materiaController = new BehaviorSubject<List<MateriaModel>>();
  final _materiaProvider = new MateriasProvider();

  Stream<List<MateriaModel>> get materiasStream => _materiaController.stream;


  void carregarMaterias() async {
    _materiaController.sink.add(await _materiaProvider.carregarMaterias());
  }

  void criarMaterias(MateriaModel materia) async {
    await _materiaProvider.criarMateria(materia);
    carregarMaterias();
  }

  void deletarNota(MateriaModel materia) async {
    _materiaProvider.deletarMateria(materia);
  }

  dispose(){
    _materiaController.close();

  }

}