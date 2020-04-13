
import 'dart:convert';
import 'package:appuniversitario/src/models/evento_model.dart';
import 'package:http/http.dart' as http;



class EventosProvider {
  final String _url = 'https://meusapp-931b4.firebaseio.com';


  Future<bool> criarEvento(EventosModel evento, String usuario) async {
    final url = '$_url/$usuario/eventos.json';
    final resp = await http.post(url, body: eventosModelToJson(evento));
    final decodeData = json.decode(resp.body);
    print(decodeData);

    return true;
  }

  Future<bool> atualizarEvento(EventosModel evento, String usuario) async {
    final url =  '$_url/$usuario/eventos/${ evento.id }.json'; 
    final resp = await http.put(url, body:  eventosModelToJson(evento));
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<bool> deletarEvento(String evento, String usuario) async {
    final url =  '$_url/$usuario/eventos/$evento.json'; 
    final resp = await http.delete(url);
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<List<EventosModel>> carregarEventos(String usuario) async {
    final url = '$_url/$usuario/eventos.json';

    final resp = await http.get(url);
    final List<EventosModel> eventos = new List();

    final Map<String, dynamic> decodeData = json.decode(resp.body);

    if(decodeData == null) return [];

    decodeData.forEach((id, evento){
      final eventTemp = EventosModel.fromJson(evento);
      eventTemp.id = id;
      eventos.add(eventTemp);
    });

    return eventos;
  }



}