import 'package:rxdart/rxdart.dart';


import 'package:appuniversitario/src/models/estudo_model.dart';
export 'package:appuniversitario/src/models/estudo_model.dart';

import 'package:appuniversitario/src/providers/estudos_provider.dart';
export 'package:appuniversitario/src/providers/estudos_provider.dart';

class EstudosBloc {
  final _estudosController = new BehaviorSubject<List<EstudosModel>>();
  final _estudosProvider = new EstudosProvier();

  Stream<List<EstudosModel>> get studosStream => _estudosController.stream;


  void carregarEstudosSemana(String usuario, String diaDaSemana) async {
    _estudosController.sink.add(await _estudosProvider.carregarEstudosSemana( diaDaSemana));
  }

  void adicionarEstudo(EstudosModel estudo, String diaSemana, String usuario)async{
    await _estudosProvider.criarEstudo(estudo, diaSemana);
    carregarEstudosSemana(usuario, diaSemana);
  }


  void deletarEstudo(String diaSemana, String estudoId, String usuario)async{
    await _estudosProvider.deletarEstudo(diaSemana, estudoId);
    carregarEstudosSemana(usuario, diaSemana);
  }

  dispose(){
    _estudosController.close();
  }
}