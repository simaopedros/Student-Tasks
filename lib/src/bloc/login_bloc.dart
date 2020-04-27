

import 'package:appuniversitario/src/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validator {
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get senhaStream => _senhaController.stream.transform(validarSenha);

  void changeEmail(String email){
    _emailController.sink.add(email);
  }

  void changePassword(String senha){
    _senhaController.sink.add(senha);
  }



  dispose(){
    _emailController?.close();
    _senhaController?.close();
  }
}