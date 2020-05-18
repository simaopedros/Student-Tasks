import 'package:appuniversitario/src/pages/home/features/eventos/evento_model.dart';

import 'package:appuniversitario/src/pages/home/features/eventos/eventos_provider.dart';
export 'package:appuniversitario/src/pages/home/features/eventos/eventos_provider.dart';

export 'package:appuniversitario/src/pages/home/features/eventos/evento_model.dart';




import 'package:rxdart/rxdart.dart';

class EventosBloc {
  
  final _eventosController = new BehaviorSubject<List<EventosModel>>();
  final _carregandoController = new BehaviorSubject<bool>();

  final _eventosProvider = new EventosProvider();

  Stream<List<EventosModel>> get eventosStream => _eventosController.stream;
  Stream<bool> get carregando => _carregandoController.stream;

  void carregarEventos(String usuario) async {
    _eventosController.sink.add(await _eventosProvider.carregarEventos());
  }

  void adicionarEvento(EventosModel evento, String usuario) async {
    _carregandoController.sink.add(true);
    await _eventosProvider.criarEvento(evento);
    _carregandoController.sink.add(false);
    carregarEventos(usuario);
  }

  void atualizarEvento(EventosModel evento, String usuario) async {
    _carregandoController.sink.add(true);
    await _eventosProvider.atualizarEvento(evento);
    _carregandoController.sink.add(false);
    carregarEventos(usuario);
  }

  void apagarEvento(String id, String usuario) async {
    await _eventosProvider.deletarEvento(id);
    carregarEventos(usuario);
  }


  dispose(){
    _eventosController.close();
    _carregandoController.close();
  }

}