
import 'dart:convert';
import 'package:appuniversitario/src/models/evento_model.dart';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:http/http.dart' as http;



class EventosProvider {
  final String _url = 'https://meusapp-931b4.firebaseio.com';
   final _prefs = new PreferenciasUsuario();

  Future<bool> criarEvento(EventosModel evento) async {

   

    final url = '$_url/${ _prefs.usuario }/eventos.json?auth=${ _prefs.token }';
    final resp = await http.post(url, body: eventosModelToJson(evento));
    final decodeData = json.decode(resp.body);
    print(decodeData);

    return true;
  }

  Future<bool> atualizarEvento(EventosModel evento) async {

    
    final url =  '$_url/${ _prefs.usuario }/eventos/${ evento.id }.json?auth=${ _prefs.token }'; 
    final resp = await http.put(url, body:  eventosModelToJson(evento));
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<bool> deletarEvento(String evento) async {

    
    final url =  '$_url/${ _prefs.usuario }/eventos/$evento.json?auth=${ _prefs.token }'; 
    final resp = await http.delete(url);
    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<List<EventosModel>> carregarEventos() async {

    
    final url = '$_url/${ _prefs.usuario }/eventos.json?auth=${ _prefs.token }';

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