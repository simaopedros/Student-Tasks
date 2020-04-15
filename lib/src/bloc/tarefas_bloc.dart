import 'package:appuniversitario/src/models/tarefa_model.dart';
export 'package:appuniversitario/src/models/tarefa_model.dart';

import 'package:appuniversitario/src/providers/tarefas_provider.dart';
export 'package:appuniversitario/src/providers/tarefas_provider.dart';

import 'package:rxdart/rxdart.dart';

class TarefasBloc {
    final _tarefasControler     = new BehaviorSubject<List<TarefaModel>>();
    final _carregandoControler  = new BehaviorSubject<bool>();
    final _umaTarefaController  = new BehaviorSubject<TarefaModel>();
    final _tarefasProvider      = new TarefasProvider();

    Stream<List<TarefaModel>> get tarefasStream => _tarefasControler.stream;
    Stream<TarefaModel>       get umaTarefaStream => _umaTarefaController.stream;
    Stream<bool>              get carregando => _carregandoControler.stream;

    void carregarTarefas(String usuario) async {
      _tarefasControler.sink.add(await _tarefasProvider.carregarTarefas(usuario));
    }

    void carregarUmaTarefa(String usuario, String tarefaId) async {
      _umaTarefaController.sink.add(await _tarefasProvider.carregarUmaTarefa(usuario, tarefaId));
    }
    

    void adicionarTarefa(TarefaModel tarefa, String usuario) async {
      _carregandoControler.sink.add(true);
      await _tarefasProvider.criarTarefa(tarefa, usuario);
      _carregandoControler.sink.add(false);
      carregarTarefas(usuario);
    }

    void atualizarTarefa(TarefaModel tarefa, String usuario) async {
      _carregandoControler.sink.add(true);
      await _tarefasProvider.atualizarTarefa(tarefa, usuario);
      _carregandoControler.sink.add(false);
      carregarTarefas(usuario);
    }

    void apagarTarefa(String id, String usuario) async {
      await _tarefasProvider.apagarTarefa(id, usuario);
      carregarTarefas(usuario);
  
    }


    dispose(){
      _tarefasControler.close();
      _carregandoControler.close();
      _umaTarefaController.close();
    }

}