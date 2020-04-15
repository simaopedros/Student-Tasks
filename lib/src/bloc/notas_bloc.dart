


import 'package:appuniversitario/src/models/bocodenotas_model.dart';
export 'package:appuniversitario/src/models/bocodenotas_model.dart';

import 'package:appuniversitario/src/providers/blocodenotas_provider.dart';
export 'package:appuniversitario/src/providers/blocodenotas_provider.dart';

import 'package:rxdart/rxdart.dart';

class NotasBloc {
  final _notasController = new BehaviorSubject<List<BlocoDeNotasModel>>();
  final _carregandoNotaController = new BehaviorSubject<bool>();

  final _blocoDeNotasProvider = new BlocoDeNotasProvider();

  Stream<List<BlocoDeNotasModel>> get notasStream => _notasController.stream;
  Stream<bool>                    get carregandoNota => _carregandoNotaController.stream;

  void carregarNotas(String usuario) async {
    _carregandoNotaController.add(true);
    _notasController.sink.add(await _blocoDeNotasProvider.carregarNotas(usuario));
    _carregandoNotaController.add(false);
  }

  void deletarNota (BlocoDeNotasModel nota, String usuario){
    _blocoDeNotasProvider.deletarNota(nota, usuario);
  }

  void criarNota (BlocoDeNotasModel nota, String usuario){
    _blocoDeNotasProvider.criarNota(nota, usuario);
  }


  dispose(){
    _notasController.close();
    _carregandoNotaController.close();
  }
}