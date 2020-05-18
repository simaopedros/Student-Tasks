import 'package:appuniversitario/src/pages/home/features/notas/blocodenotas_provider.dart';
export 'package:appuniversitario/src/pages/home/features/notas/blocodenotas_provider.dart';

import 'package:appuniversitario/src/pages/home/features/notas/bocodenotas_model.dart';
export 'package:appuniversitario/src/pages/home/features/notas/bocodenotas_model.dart';

import 'package:rxdart/rxdart.dart';

class NotasBloc {
  
  final _notasController = new BehaviorSubject<List<BlocoDeNotasModel>>();
  final _carregandoNotaController = new BehaviorSubject<bool>();

  final _blocoDeNotasProvider = new BlocoDeNotasProvider();

  Stream<List<BlocoDeNotasModel>> get notasStream => _notasController.stream;
  Stream<bool>                    get carregandoNota => _carregandoNotaController.stream;

  void carregarNotas(String usuario) async {
    _carregandoNotaController.add(true);
    _notasController.sink.add(await _blocoDeNotasProvider.carregarNotas());
    _carregandoNotaController.add(false);
  }

  void deletarNota (BlocoDeNotasModel nota, String usuario) async {
    await _blocoDeNotasProvider.deletarNota(nota);
    carregarNotas(usuario);
  }

  void criarNota (BlocoDeNotasModel nota, String usuario)async{
    await _blocoDeNotasProvider.criarNota(nota);
    carregarNotas(usuario);
  }


  dispose(){
    _notasController.close();
    _carregandoNotaController.close();
  }
}