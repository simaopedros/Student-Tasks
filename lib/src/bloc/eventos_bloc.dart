import 'package:appuniversitario/src/models/evento_model.dart';

import 'package:appuniversitario/src/providers/eventos_provider.dart';
export 'package:appuniversitario/src/providers/eventos_provider.dart';

import 'package:rxdart/rxdart.dart';

class EventosBloc {
  final _eventosController = new BehaviorSubject<List<EventosModel>>();
  final _carregandoController = new BehaviorSubject<bool>();

  final _eventosProvider = new EventosProvider();

  Stream<List<EventosModel>> get eventosStream => _eventosController.stream;
  Stream<bool> get carregando => _carregandoController.stream;

  void carregarEventos(String usuario) async {
    _eventosController.sink.add(await _eventosProvider.carregarEventos(usuario));
  }

  void adicionarEvento(EventosModel evento, String usuario) async {
    _carregandoController.sink.add(true);
    await _eventosProvider.criarEvento(evento, usuario);
    _carregandoController.sink.add(false);
    carregarEventos(usuario);
  }

  void atualizarEvento(EventosModel evento, String usuario) async {
    _carregandoController.sink.add(true);
    await _eventosProvider.atualizarEvento(evento, usuario);
    _carregandoController.sink.add(false);
    carregarEventos(usuario);
  }

  void apagarEvento(String id, String usuario) async {
    await _eventosProvider.deletarEvento(id, usuario);
    carregarEventos(usuario);
  }


  dispose(){
    _eventosController.close();
    _carregandoController.close();
  }

}