
import 'dart:convert';

import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:http/http.dart' as http;



import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in anom

  Future signInAnom() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user != null ? user.uid : null;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in email senha


  //reg email e pass

  //sign out
}

class Usuariorovider {
   final FirebaseAuth _auth = FirebaseAuth.instance;

  final String _firebaseToken = "AIzaSyAp1v5jJnikwdXwqGEGZ7yFxBC52-a4JtA";
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async{

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      IdTokenResult idTokenResult = await user.getIdToken();
      print(idTokenResult);
      return{ "ok" :true, 'token' : idTokenResult, 'usuario' : user.uid};
    }catch(e){
      print(e.toString());
      return{ "ok" :false, 'message' : e['error']['message']};
    }

    //<-------------------------------------->

    // final authData = {
    //   'email' : email,
    //   'password' : password,
    //   'returnSecureToken' : true
    // };

    // final resp = await http.post(
    //   'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
    //   body: json.encode(authData)
    // );

    // Map<String, dynamic> decodeResp = json.decode(resp.body);
    // print(decodeResp);
    // if(decodeResp.containsKey("idToken")){
    //   _prefs.token = decodeResp['idToken'];
    //   _prefs.usuario = decodeResp['localId'];
    //   _prefs.email = email;
    //   _prefs.senha = password;
    //   return{ "ok" :true, 'token' : decodeResp['idToken'], 'usuario' : decodeResp['localId']};
    //   //Salver Token e email no storage
    // }else{
    //   return{ "ok" :false, 'message' : decodeResp['error']['message']};
    // }
    
  }

  Future<Map<String, dynamic>> novoUsuario(String email, String password) async{
    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    
    if(decodeResp.containsKey("idToken")){
      _prefs.token = decodeResp['idToken'];
      _prefs.usuario = decodeResp['localId'];
      _prefs.email = email;
      _prefs.senha = password;
      return{ "ok" :true, 'token' : decodeResp['idToken'], 'usuario' : decodeResp['localId']};
      //Salver Token e email no storage
    }else{
      return{ "ok" :false, 'message' : decodeResp['error']['message']};
    }


  }


}