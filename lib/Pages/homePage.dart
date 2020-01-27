import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:appuniversitario/Components/homePageComponents.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState(); 
}
 
class _HomeState extends State<Home> {

  List _toDoMaterias = [];
  @override
  Widget build(BuildContext context) {
    return AppBody();
  }

  Future<File> _getFile() async{
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async{
    String data = json.encode(_toDoMaterias);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async{
    try{
      final file = await _getFile();
      return file.readAsString();
    }catch (e){
      return null;
    }
  }
  
}





Widget AppBody() {
  return Scaffold(
    backgroundColor: Colors.blueGrey,
    appBar: AppBar(
      title: Text(
        "Estud.io",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          tooltip: 'Notificacaoes',
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.event),
          tooltip: "Configuracao",
          onPressed: () {},
        ),
      ],
      backgroundColor: Colors.blueGrey,
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Column(
        children: <Widget>[            
        SizedBox(height: 5.0,),
        ListMaterias(),
        ListAgenda(),
        //ListRepublicas(),
        ],
      ),
      
    ),
  );
}

