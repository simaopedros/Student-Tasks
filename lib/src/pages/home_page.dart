import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/menusuperior_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarPadrao(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              barraSuperior(context, true),
              CardStory(),
              _tarefasPendentes(),
              _blocoDeNotas(),
            ],
          ),
        ));
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
        child: Text("Isso é uma nota a ser observada em algum dia e por mais que tente ela nunca sera tao grande assim"),
        decoration: BoxDecoration(
          color: Color.fromRGBO(218, 242, 39, 1.0),
          borderRadius: BorderRadius.circular(5)

        ),
      ),
      Positioned(
        right: -10,
        top: 0,
        child: IconButton(
          icon: Icon(Icons.delete_forever), 
          onPressed: null
        ))
      ],
    );
  }

  Widget _tarefasPendentes() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Titulo("tarefas", "Pendentes"),
          _listaTarefas(),
        ],
      ),
    );
  }

  Widget _listaTarefas() {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          _tarefa(),
          Divider(),
          _tarefa(),
          Divider(),
          _tarefa(),
          Divider(),
          _tarefa(),
          Divider(),
          _tarefa(),
          Divider(),
          _tarefa(),
        ],
      ),
    );
  }

  Widget _tarefa() {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Color.fromRGBO(105, 205, 105, 1.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Icon(Icons.timer),
            SizedBox(
              width: 10.0,
            ),
            Text("Criar Evento"),
            Expanded(child: Container()),
          ],
        ),
      ),
      child: ListTile(
        title: Text("Essa é uma tarefa a ser feita"),
        //leading: Icon(Icons.calendar_view_day),
        trailing: Icon(Icons.check_box_outline_blank),
      ),
    );
  }

}
