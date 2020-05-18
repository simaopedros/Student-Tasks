import 'package:appuniversitario/src/bloc/provider.dart';
import 'package:appuniversitario/src/pages/estudos/estudo_page.dart';
import 'package:appuniversitario/src/pages/grade/grade_page.dart';
import 'package:appuniversitario/src/pages/home/features/tarefas/tarefas_bloc.dart';
import 'package:appuniversitario/src/pages/home/home_page.dart';
import 'package:appuniversitario/src/pages/materias/materia_page.dart';
import 'package:appuniversitario/src/pages/mensagens_noti.dart';
import 'package:appuniversitario/src/pages/provas/provas_page.dart';
import 'package:appuniversitario/src/pages/testes.dart';
import 'package:appuniversitario/src/pages/usuario/cadastrar_page.dart';
import 'package:appuniversitario/src/pages/usuario/login_page.dart';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:appuniversitario/src/providers/push_notificao_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async{ 
  
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  

  runApp(MyApp());  
}
class MyApp extends StatefulWidget {

  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatoKey = new GlobalKey<NavigatorState>();
  final inicialPage = PreferenciasUsuario();

  final tarefasBloc = TarefasBloc();

  @override
  void initState() {
    
    super.initState();
    final push =new PushNotificacaoProvider();
    push.initNotificacoes();
    push.menssagens.listen((data){      
      navigatoKey.currentState.pushNamed("notif", arguments: data);
      // Navigator.pushNamed(context, "notif");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatoKey,
        title: 'StudentsTasks',
        initialRoute: 'selectDisplay',        
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'cadastrar': (BuildContext context) => CadastrarPage(),
          'home': (BuildContext context) => HomePage(),
          'provas': (BuildContext context) => ProvaPage(),
          'grade': (BuildContext context) => GradePage(),
          'materia': (BuildContext context) => MateriaPage(),
          'estudo': (BuildContext context) => EstudoPage(),
          'teste' : (BuildContext context) => TesteApp(),
          'selectDisplay' : (BuildContext contex) => _selectDisplay(),
          'notif' : (BuildContext context) => MenssagemNotif(),
        },
      ),
    );
  }

}

Widget _selectDisplay(){
  
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged ,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){        
        return Scaffold(
          backgroundColor: Color.fromRGBO(56, 44, 206, 1.0),
          body: Center(child: Text("Carregando...", style: TextStyle(color: Colors.white),)),
        );
      }else{
        if(snapshot.hasData){
          return HomePage();
        }else{
          return LoginPage();
        }
      }
    },
  );
}