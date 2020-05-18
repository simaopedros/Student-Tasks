import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/itemestudo_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';

class EstudoPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    // final usuarioPrefer = new PreferenciasUsuario();
    // usuarioPrefer.ultimaPagina = "estudo";

    final _prefs = new PreferenciasUsuario();
    final String usuario = _prefs.usuario; 

    final List diasSemana = [
      "Segunda-feira",
      "Terça-feira",
      "Quarta-Feira",
      "Quinta-Feira",
      "Sexta-Feira",
      "Sabado",
      "Domingo"
    ];

    return Scaffold(
      appBar: appBarPadrao(context),
      body: SafeArea(child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              CardStory(),
              Container(padding: EdgeInsets.all(10.0), child: Titulo("meus", "Estudos")),
              for(var dia = 0; dia < diasSemana.length; dia++)              
                ItemEstudo(diasSemana[dia], usuario),
              SizedBox(height: 50.0,),
            ],
          ),
        ),
      ))
    );
  }
}
