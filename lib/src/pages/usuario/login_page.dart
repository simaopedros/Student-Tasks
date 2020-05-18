import 'package:appuniversitario/src/bloc/provider.dart';
import 'package:appuniversitario/src/pages/usuario/login_bloc.dart';
import 'package:appuniversitario/src/pages/usuario/usuario_provieder.dart';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final loginProvider = new Usuariorovider();
final usuarioPrefer = new PreferenciasUsuario();


TextEditingController email =
    new TextEditingController(text: usuarioPrefer.email);
TextEditingController senha =
    new TextEditingController(text: usuarioPrefer.senha);

class _LoginPageState extends State<LoginPage> {

  
  String page = usuarioPrefer.ultimaPagina;
  String usuarioLOgar;

  bool olho;
  @override
  void initState() {
    olho = true;
    usuarioLOgar = usuarioPrefer.usuario;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final bloc = Provider.loginBloc(context);
    final _zise = MediaQuery.of(context).size;

    


    return Scaffold(
        body: Stack(
      children: <Widget>[
        
        Container(
          color: Color.fromRGBO(56, 44, 206, 1.0),
        ),
        
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Student",
                    style: GoogleFonts.roboto(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white)),
                Text(
                  "Tasks",
                  style: GoogleFonts.roboto(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 90.0),
              width: _zise.width * 0.8,
              // height: _zise.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      height: 150.0,
                      width: _zise.width * 0.8,
                      child: Image(
                        image: AssetImage("assets/181.png"),
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: Titulo("fazer", "Login")),
                  _criarEmail(bloc),
                  SizedBox(
                    height: 10.0,
                  ),
                  _criarSenha(bloc),
                  SizedBox(
                    height: 20.0,
                  ),
                  FlatButton(
                      onPressed: () async {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.value.text, 
                          password: senha.value.text).timeout(Duration(days: 365)).then((resp){
                            usuarioPrefer.usuario = resp.user.uid;
                            Toast.show("Logado como " +resp.user.email, context, duration: 5);
                          }).catchError((err){
                            Toast.show(err.toString(), context, duration: 10);
                          });
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(child: Container()),
                            Container(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Center(
                                  child: Text(
                                "entrar",
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 25.0),
                              )),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(56, 44, 206, 1.0),
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                      )),

                  FlatButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, "cadastrar"),
                      child: Text("Criar Estudante")),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  Widget _criarEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            controller: email,
            decoration: InputDecoration(
                prefixIcon: Icon(FontAwesomeIcons.at),
                hintText: "exempo@email.com.br",
                labelText: "Email",
                errorText: snapshot.error,
                border: OutlineInputBorder()),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _criarSenha(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.senhaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            obscureText: olho,
            controller: senha,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: olho == false
                      ? Icon(FontAwesomeIcons.eyeSlash)
                      : Icon(FontAwesomeIcons.eye),
                  onPressed: () {
                    olho = !olho;
                    setState(() {
                      print(olho);
                    });
                  },
                ),
                prefixIcon: Icon(FontAwesomeIcons.unlock),
                hintText: "Ex: 125@a148",
                labelText: "Senha",
                errorText: snapshot.error,
                border: OutlineInputBorder()),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }
}
