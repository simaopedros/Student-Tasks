import 'package:appuniversitario/src/models/avaliacao_model.dart';
export 'package:appuniversitario/src/models/avaliacao_model.dart';

import 'package:appuniversitario/src/providers/avaliacao_provider.dart';
export 'package:appuniversitario/src/providers/avaliacao_provider.dart';

import 'package:rxdart/rxdart.dart';

class AvaliacaoBloc {
  final _avaliacaoController = new BehaviorSubject<List<AvaliacoesModel>>();
  final _avaliacaoProvider = new AvaliacaoProvier();

  Stream<List<AvaliacoesModel>> get avaliacaoStream => _avaliacaoController.stream;

  void carregarAvaliacoes(String usuario) async {
    _avaliacaoController.sink.add( await _avaliacaoProvider.carregarAvaliacao());
  }

  void criarAvaliacoes(AvaliacoesModel avaliacao, String usuario) async {
    await _avaliacaoProvider.criarAvaliacao(avaliacao);
    carregarAvaliacoes(usuario);

  }
  void deletarAvaliacoes(String idAvaliacao, String usuario) async {
    await _avaliacaoProvider.deletarAvaliacao(idAvaliacao);
    carregarAvaliacoes(usuario);
    

  }

  dispose(){
    _avaliacaoController.close();
  }
}