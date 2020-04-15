import 'package:flutter/material.dart';
import 'package:appuniversitario/src/bloc/notas_bloc.dart';
import 'package:appuniversitario/src/bloc/tarefas_bloc.dart';
import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/listadetarefas_widget.dart';
import 'package:appuniversitario/src/widget/menusuperior_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String usuario = "simaopedros";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TarefasBloc tarefaBloc = new TarefasBloc();
    NotasBloc notasBloc = new NotasBloc();

    tarefaBloc.carregarTarefas(usuario);
    notasBloc.carregarNotas(usuario);

    return Scaffold(
        appBar: appBarPadrao(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BarraSuperior(),
              CardStory(),
              _listaTarefas(tarefaBloc),
              _blocoDeNotas(notasBloc),
            ],
          ),
        ));
  }

  Widget _listaTarefas(TarefasBloc tarefaBloc) {

    return StreamBuilder(
      stream: tarefaBloc.tarefasStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<TarefaModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data.length == 0) {
          return Container(
            height: 150.0,
            width: double.infinity,
            child: Center(
              child: Text("Parabens, nenhuma tarefa pendente."),
            ),
          );
        }

        if(snapshot.data.length > 0){
          return Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Titulo("tarefas", "Pendentes"),
              ),
              for (var cont = 0; cont < snapshot.data.length; cont++)
                Tarefa(snapshot.data[cont], snapshot.data[cont].id, usuario)
            ],
          ),
        );
        }

        return Container();
      },
    );
  }

  Widget _blocoDeNotas(NotasBloc notas) {
    return StreamBuilder(
      stream: notas.notasStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<BlocoDeNotasModel>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        if (snapshot.data.length > 0) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Titulo("blocoDe", "Notas"),
                for (var nota = 0; nota < snapshot.data.length; nota++)
                  _notas(snapshot.data[nota], notas),
              ],
            ),
          );
        }
        print(snapshot.data.length.toString());
        return Container();
      },
    );
  }

  Widget _notas(BlocoDeNotasModel nota, NotasBloc notaBloc) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.all(20.0),
          child: Text(nota.nota),
          decoration: BoxDecoration(
              color: Color.fromRGBO(218, 242, 39, 1.0),
              borderRadius: BorderRadius.circular(5)),
        ),
        Positioned(
            right: -10,
            top: 0,
            child: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  notaBloc.deletarNota(nota, usuario);
                  Navigator.pushReplacementNamed(context, "home");
                }))
      ],
    );
  }
}
