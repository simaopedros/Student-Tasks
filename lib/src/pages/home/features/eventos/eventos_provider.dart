
import 'package:appuniversitario/src/pages/home/features/eventos/evento_model.dart';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventosProvider {
  final _prefs = new PreferenciasUsuario();
  final db = Firestore.instance;

  Future<bool> criarEvento(EventosModel evento) async {
    db.settings(persistenceEnabled: true);
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Eventos")
        .add(evento.toJson());
    return true;
  }

  Future<bool> atualizarEvento(EventosModel evento) async {
    db.settings(persistenceEnabled: true);
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Eventos")
        .document(evento.id)
        .updateData(evento.toJson());
    return true;
  }

  Future<bool> deletarEvento(String evento) async {
    db.settings(persistenceEnabled: true);
    await db
        .collection(_prefs.usuario)
        .document("dados")
        .collection("Eventos")
        .document(evento)
        .delete();

    return true;
  }

  Future<List<EventosModel>> carregarEventos() async {
    db.settings(persistenceEnabled: true);
    QuerySnapshot resultado = await db
    .collection(_prefs.usuario)
    .document("dados")
    .collection("Eventos")
    .getDocuments();

    final List<EventosModel> eventos = new List();

    resultado.documents.forEach((evento){
      EventosModel eventTemp = new EventosModel();
      eventTemp.id = evento.documentID;
      eventTemp.descricao = evento.data['descricao'];
      eventTemp.hora = evento.data['hora'];
      eventTemp.local = evento.data['local'];
      eventTemp.materia = evento.data['materia'];
      eventTemp.notifica = evento.data['notifica'];
      eventTemp.prazo = evento.data['prazo'];
      eventTemp.tarefa = evento.data['tarefa'];
      eventTemp.tipoevento = evento.data['tipoevento'];
      
      eventos.add(eventTemp);

    });

    return eventos
    ;
  }
}
