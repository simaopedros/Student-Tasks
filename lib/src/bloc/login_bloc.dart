import 'package:appuniversitario/src/bloc/validator.dart';
import 'package:appuniversitario/src/providers/usuario_provieder.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validator {
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();
  final _loginControler = BehaviorSubject<dynamic>();



  final _loginProvider = new AuthService();

  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get senhaStream => _senhaController.stream.transform(validarSenha);

  Stream<dynamic> get loginStream => _loginControler.stream;

  void logarAnonimo()async{
    _loginControler.sink.add(await _loginProvider.signInAnom());
  }

  void changeEmail(String email){
    _emailController.sink.add(email);
  }

  void changePassword(String senha){
    _senhaController.sink.add(senha);
  }



  dispose(){
    _emailController?.close();
    _senhaController?.close();
    _loginControler?.close();
  }
}