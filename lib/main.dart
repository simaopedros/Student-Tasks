import 'package:appuniversitario/src/bloc/provider.dart';
import 'package:appuniversitario/src/pages/cadastrar_page.dart';
import 'package:appuniversitario/src/pages/estudo_page.dart';
import 'package:appuniversitario/src/pages/grade_page.dart';
import 'package:appuniversitario/src/pages/home_page.dart';
import 'package:appuniversitario/src/pages/login_page.dart';
import 'package:appuniversitario/src/pages/materia_page.dart';
import 'package:appuniversitario/src/pages/provas_page.dart';
import 'package:appuniversitario/src/pages/testes.dart';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:flutter/material.dart';

void main()async{ 
  
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  

  final inicialPage = PreferenciasUsuario();
  final tarefasBloc = TarefasBloc();
  

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'StudentsTasks',
        initialRoute: inicialPage.ultimaPagina,        
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'cadastrar': (BuildContext context) => CadastrarPage(),
          'home': (BuildContext context) => HomePage(),
          'provas': (BuildContext context) => ProvaPage(),
          'grade': (BuildContext context) => GradePage(),
          'materia': (BuildContext context) => MateriaPage(),
          'estudo': (BuildContext context) => EstudoPage(),
          'teste' : (BuildContext context) => TesteApp(),
          
        },
      ),
    );
  }
}
