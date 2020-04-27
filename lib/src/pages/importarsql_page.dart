import 'dart:convert';
import 'dart:io';

import 'package:appuniversitario/src/bloc/grades_bloc.dart';
import 'package:appuniversitario/src/bloc/materias_bloc.dart';
import 'package:appuniversitario/src/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class ImportarSql extends StatefulWidget {  

  @override
  _ImportarSqlState createState() => _ImportarSqlState();
}

class _ImportarSqlState extends State<ImportarSql> {

  TarefaModel _tarefaModel = new TarefaModel();
  TarefasBloc _tarefasBloc = new TarefasBloc();

  GradeModel _gradeModel = new GradeModel();
  GradesBloc _gradesBloc = new GradesBloc();

  MateriaModel _materiaModel = new MateriaModel();
  MateriaBloc _materiaBloc = new MateriaBloc();

  bool tarefas;
  bool materias;


  List _toDoList = [];
  List _materiaList = [];
  
  @override

  void initState() { 
    
    _readData().then((tarefas){
      setState(() {
        _toDoList = json.decode(tarefas);
      });
    });

    _readDataMateria().then((materias){
      _materiaList = json.decode(materias);
    });


    tarefas = _toDoList.length > 0;
    materias = _materiaList.length > 0;   
    super.initState();
  }


  @override
  Widget build(BuildContext context) {



   
    
    return Container(
       child: Center(
         child: Container(
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(10.0)
           ),
           height: 150.0,
           width: double.infinity,
           margin: EdgeInsets.all(10.0),
           child: Column(
             children: <Widget>[
               Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                     child: Text("Se voce ja utiliza uma versão antiga sincronize suas tarefas"),
                   ),
                   Expanded(child: Container()),
                   IconButton(
                     icon: Icon(Icons.close), 
                     onPressed: () => Navigator.pop(context),
                  ),
                 ],
               ),
               Visibility(
                 visible: tarefas || materias,
                 child: Container(
                   child: FlatButton(
                     onPressed: (){
                       adicionarTarefas();
                       adicionarMaterias();
                     }, 
                     child: Container(child: Center(child: Text("Sincronizar"),),)
                  ),
                 ),
                 replacement: Center(child: Text("Voce não tem tarefas para sincronizar")),
          ),
             ],
           ),
         ),
       ),
    );

                            // _materiaList[cont]["materia"],
                            // _materiaList[cont]["p1"],
                            // _materiaList[cont]["t1"],
                            // _materiaList[cont]["p2"],
                            // _materiaList[cont]["t2"],
                            //  _materiaList[cont]["tarefas"]),


  }




  void adicionarMaterias() {    
    for(var i = 0; i < _materiaList.length; i++){
      List tarefas = _materiaList[i]["tarefas"];
      _materiaModel.materia = _materiaList[i]["materia"];
      _materiaModel.corr = 255;
      _materiaModel.corg = 255;
      _materiaModel.corb = 255;

      _gradeModel.materia = _materiaList[i]["materia"];
      _gradeModel.p1 = _materiaList[i]["p1"];
      _gradeModel.p2 = _materiaList[i]["p2"];
      _gradeModel.t1 = _materiaList[i]["t1"];
      _gradeModel.t2 = _materiaList[i]["t2"];
      for(var j = 0; j < tarefas.length; j++){
        _tarefaModel.materia = _materiaList[i]["materia"];
        _tarefaModel.tarefa = tarefas[j]["tarefa"];
        _tarefaModel.status = tarefas[j]["status"];
      }


      _gradesBloc.adicionarGrade(_gradeModel, "usuario");
      _materiaBloc.criarMaterias(_materiaModel);
      _tarefasBloc.adicionarTarefa(_tarefaModel, "usuario");

      setState(() {
        _materiaList.removeAt(i);
        _saveDataMateria();
        materias = false;
      });
    }
    return null;
  }

  void adicionarTarefas(){
    for(var i = 0; i < _toDoList.length; i++){
      _tarefaModel.materia = _toDoList[i]["tarefa"];
      _tarefaModel.status = _toDoList[i]["status"];
      _tarefasBloc.adicionarTarefa(_tarefaModel, "usuario");
      
      setState(() {
        _toDoList.removeAt(i);
        _saveData();
        tarefas = false;
      });
    }

    return null;
  }



  //Lista de Tarefas
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

//Lista de Tarefas Fim
//Lista de Materias
  Future<File> _getFileMateria() async {
    final directoryMateria = await getApplicationDocumentsDirectory();
    return File("${directoryMateria.path}/dataMateria.json");
  }

  Future<File> _saveDataMateria() async {
    String dataMateria = json.encode(_materiaList);
    final fileMateria = await _getFileMateria();
    return fileMateria.writeAsString(dataMateria);
  }

  Future<String> _readDataMateria() async {
    try {
      final fileMateria = await _getFileMateria();
      return fileMateria.readAsString();
    } catch (e) {
      return null;
    }
  }


}
