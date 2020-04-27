import 'package:flutter/material.dart';

import 'package:appuniversitario/src/bloc/tarefas_bloc.dart';
import 'package:appuniversitario/src/models/tarefa_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class BarraSuperior extends StatefulWidget {  

  @override
  _BarraSuperiorState createState() => _BarraSuperiorState();
}
class _BarraSuperiorState extends State<BarraSuperior> {

  TextEditingController _controller;
  TarefaModel tarefas = new TarefaModel();

  

  @override
  void initState() { 
    super.initState();    
   _controller = new TextEditingController();
     
  }

  @override
  Widget build(BuildContext context) {

   
   TarefasBloc tarefasBloc = new TarefasBloc();

    

    return Container(
      // width: double.infinity,
      color: Color.fromRGBO(56, 44, 206, 1.0),
      child: SafeArea(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              autofocus: false,
              controller: _controller,
              decoration: InputDecoration(
                  hintText: "Nova Tarefa",                  
                  icon: Container(
                    width: 34.0,
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      onPressed: (){
                        setState(() {
                          _addTarefa(tarefasBloc, _controller.value.text);
                        });
                        
                      },
                      child: Icon(
                        Icons.add,
                        color: Color.fromRGBO(56, 44, 206, 1.0),
                      ),
                    ),
                  ),
                  border: InputBorder.none),
            ),
          ),
          _menuSuperios(context),
        ],
      )),
    );
  }

  void _addTarefa(TarefasBloc tarefasBloc, String tarefa) {

    print(tarefa);
    tarefas.tarefa = tarefa;
    //tarefasBloc.adicionarTarefa(tarefas, "simaopedros");  
  
    setState(() {      
      _controller.text = "";
      tarefasBloc.adicionarTarefa(tarefas, "simaopedros");  
    });
    
    Navigator.pushReplacementNamed(context, "home");
  }
}

Widget _menuSuperios(BuildContext context) {
  return Container(    
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width*0.20,
          child: FlatButton(
              onPressed: () => Navigator.pushNamed(context, "provas"),
              child: Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.fileSignature,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "PROVAS",
                    style: TextStyle(color: Colors.white, fontSize: 8.0),
                  )
                ],
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.20,
          child: FlatButton(
              onPressed: () => Navigator.pushNamed(context, 'grade'),
              child: Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.thLarge,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "GRADE",
                    style: TextStyle(color: Colors.white, fontSize: 8.0),
                  )
                ],
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.20,
          child: FlatButton(
              onPressed: () => Navigator.pushNamed(context, 'estudo'),
              child: Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.bookReader,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "ESTUDOS",
                    style: TextStyle(color: Colors.white, fontSize: 8.0),
                  )
                ],
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.20,
          child: FlatButton(
              onPressed: () => Navigator.pushNamed(context, 'materia'),
              child: Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.book,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "MATERIAS",
                    style: TextStyle(color: Colors.white, fontSize: 8.0, ),
                  )
                ],
              )),
        ),
      ],
    ),
  );
}
