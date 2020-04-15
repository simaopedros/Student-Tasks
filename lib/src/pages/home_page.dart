import 'package:appuniversitario/src/bloc/tarefas_bloc.dart';
import 'package:appuniversitario/src/models/tarefa_model.dart';
import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/listadetarefas_widget.dart';
import 'package:appuniversitario/src/widget/menusuperior_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tarefaBloc = new TarefasBloc();
  
  final String usuario = "simaopedros";
  TarefaModel tarefa = new TarefaModel();

  @override
  void initState() {
    super.initState();
    // tarefaBloc.carregarTarefas(usuario);
  }

  @override
  Widget build(BuildContext context) {
    final tarefaBloc = new TarefasBloc();
    tarefaBloc.carregarTarefas(usuario);
    // final tarefaBloc = Provider.tarefasBloc(context);
    // tarefaBloc.carregarTarefas(usuario);

    return Scaffold(
        appBar: appBarPadrao(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BarraSuperior(),
              
              CardStory(),
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Titulo("tarefas", "Pendentes"),
              ),
              _listaTarefas(tarefaBloc),
              _blocoDeNotas(),
            ],
          ),
        ));
  }

  Widget _listaTarefas(TarefasBloc tarefaBloc) {
    return StreamBuilder(
      stream: tarefaBloc.tarefasStream,
      //initialData: initialData ,
      builder:(BuildContext context, AsyncSnapshot<List<TarefaModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final tarefas = snapshot.data;
        final max = tarefas.length;
        if (tarefas.length == 0) {
          return Container(
            height: 150.0,
            width: double.infinity,
            child: Center(
              child: Text("Parabens, nenhuma tarefa pendente."),
            ),
          );
        }        
        return Container(          
          child: Column(
            children: <Widget>[
              for(var cont =0; cont < max; cont ++)
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Tarefa(tarefas[cont], tarefa.id, usuario)
                    ),
                    cont == 10
                    ?FlatButton(
                      onPressed: null, 
                      child: Container(child: Icon(FontAwesomeIcons.angleDoubleDown),)
                    )
                    :Container()
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  Widget _blocoDeNotas() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Titulo("blocoDe", "Notas"),
          _notas(),
          _notas(),
          _notas(),
          _notas(),
        ],
      ),
    );
  }

  Widget _notas() {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.all(20.0),
          child: Text(
              "Isso é uma nota a ser observada em algum dia e por mais que tente ela nunca sera tao grande assim"),
          decoration: BoxDecoration(
              color: Color.fromRGBO(218, 242, 39, 1.0),
              borderRadius: BorderRadius.circular(5)),
        ),
        Positioned(
            right: -10,
            top: 0,
            child:
                IconButton(icon: Icon(Icons.delete_forever), onPressed: null))
      ],
    );
  }

}
