import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:
  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...
*/

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }
  

  //GET e SET usuario
  get usuario {
    return _prefs.getString('usuario') ?? '';
  }


  set usuario(String usuario){
    _prefs.setString('usuario', usuario);
  }


  get email {
    return _prefs.getString('email') ?? '';
  }


  set email(String email){
    _prefs.setString('email', email);
  }


  get senha {
    return _prefs.getString('senha');
  }
  set senha(String senha) {
    _prefs.setString("senha", senha);
  }

  get time {
    return _prefs.getInt("time");    
  }

  set time(int time){
    _prefs.setInt("time", time);
  }


  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

}

