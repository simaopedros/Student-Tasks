import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ViewMateria extends StatefulWidget {
  ViewMateria({this.indice});
  final int indice;
  @override
  _ViewMateriaState createState() => _ViewMateriaState(indiceMateria: indice);
}

class _ViewMateriaState extends State<ViewMateria> {
  _ViewMateriaState({this.indiceMateria});
  final int indiceMateria;

  final _addMateriaControler = TextEditingController();
  final _p1Controler = TextEditingController();
  final _t1Controler = TextEditingController();
  final _p2Controler = TextEditingController();
  final _t2Controler = TextEditingController();

  List _materiaList = [];

  Map<String, dynamic> _lastRemovedTodoMateria;
  int _lastRemovedTodoMateriaPos;

  @override
  void initState() {
    super.initState();
    _readDataMateria().then((dataMateria) {
      setState(() {
        _materiaList = json.decode(dataMateria);
      });
    });
  }

  void _addTodoMateria() {
    setState(() {
      Map<String, dynamic> newTodoMateria = Map();
      newTodoMateria["tarefa"] = _addMateriaControler.text;
      _addMateriaControler.text = "";
      newTodoMateria["status"] = false;
      _materiaList[indiceMateria]["tarefas"].add(newTodoMateria);
      _saveDataMateria();
    });
  }

  Future<Null> _refreshTodoMateria()async{
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _materiaList[indiceMateria]["tarefas"].sort((a, b){
        if(a["status"] && !b["status"])
          return 1;
        else if (!a["status"] && b["status"])
          return -1;
        else 
          return 0;
      });
      _saveDataMateria();
    });
    return null;
  }

  void salvarNota() {
    setState(() {
      _materiaList[indiceMateria]["p1"] = _p1Controler.text.isEmpty ? _materiaList[indiceMateria]["p1"] : _p1Controler.text;
      _materiaList[indiceMateria]["t1"] = _t1Controler.text.isEmpty ? _materiaList[indiceMateria]["t1"] : _t1Controler.text;
      _materiaList[indiceMateria]["p2"] = _p2Controler.text.isEmpty ? _materiaList[indiceMateria]["p2"] : _p2Controler.text;
      _materiaList[indiceMateria]["t2"] = _t2Controler.text.isEmpty ? _materiaList[indiceMateria]["t2"] : _t2Controler.text;
      _saveDataMateria();
      Navigator.pop(context, true);
    });
  }

  void mudaStatus() {
    setState(() {
      _materiaList[indiceMateria]["tarefas"]["status"] =
          _materiaList[indiceMateria]["tarefas"]["status"] ? false : true;
      _saveDataMateria();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(_materiaList[indiceMateria]["materia"]),
        leading: IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () {
              setState(() {
                Navigator.pop(context, true);
              });
              
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                editMateria(indiceMateria);
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Card(
              color: Colors.white,
              elevation: .0,
              child: Container(
                padding: EdgeInsets.all(15.0),
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("1º Prova:"),
                        ),
                        Text(_materiaList[indiceMateria]["p1"]),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("1º Trabalho:"),
                        ),
                        Text(_materiaList[indiceMateria]["t1"]),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("2º Prova:"),
                        ),
                        Text(_materiaList[indiceMateria]["p2"]),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("2º Trabalho:"),
                        ),
                        Text(_materiaList[indiceMateria]["t2"]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.lightBlueAccent,
            child: Card(
              elevation: 5.0,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _addMateriaControler,
                      decoration: InputDecoration(
                          labelText: "Nova Tarefa para essa materia",
                          labelStyle: TextStyle(color: Colors.blueGrey)),
                    ),
                  ),
                  RaisedButton(
                    focusElevation: 0,
                    color: Colors.transparent,
                    child: Icon(Icons.add),
                    elevation: 0.0,
                    onPressed: _addTodoMateria,
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: RefreshIndicator(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 1.0),
                    itemCount: _materiaList[indiceMateria]["tarefas"].length,
                    itemBuilder: (c, i) {
                      List tarefas = _materiaList[indiceMateria]["tarefas"];
                      return Dismissible(
                          key: Key(
                              DateTime.now().millisecondsSinceEpoch.toString()),
                          background: Container(
                            color: Colors.red,
                            child: Align(
                              alignment: Alignment(-0.9, 0.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          direction: DismissDirection.startToEnd,

                          onDismissed: (d) {
                            setState(() {
                              _lastRemovedTodoMateria = Map.from(_materiaList[indiceMateria]["tarefas"][i]);
                              _lastRemovedTodoMateriaPos = i;
                              _materiaList[indiceMateria]["tarefas"].removeAt(i);
                              _saveDataMateria();

                              final snackTodoMateriaRemovida = SnackBar(
                                content: Text("Tarefa ${_lastRemovedTodoMateria["tarefa"]} removida!"),
                                action: SnackBarAction(
                                  label: "Desfazer", 
                                  onPressed: (){
                                    setState(() {
                                      _materiaList[indiceMateria]["tarefas"].insert(_lastRemovedTodoMateriaPos,_lastRemovedTodoMateria);
                                      _saveDataMateria();
                                    });
                                  },
                                ),
                                duration: Duration(seconds: 3),
                                ); 
                                Scaffold.of(c).removeCurrentSnackBar(); // ADICIONE ESTE COMANDO
                                Scaffold.of(c).showSnackBar(snackTodoMateriaRemovida);
                            });
                          },

                          child: Container(
                            padding: EdgeInsets.only(top: 1.0),
                            color: Colors.white,
                            child: Container(
                                height: 55.0,
                                child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      _materiaList[indiceMateria]["tarefas"][i]["status"]
                                          ? _materiaList[indiceMateria]["tarefas"][i]["status"] = false
                                          : _materiaList[indiceMateria]["tarefas"][i]["status"] = true;
                                      _saveDataMateria();
                                      _refreshTodoMateria();
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Icon(
                                        tarefas[i]["status"]
                                            ? Icons.check_circle_outline
                                            : Icons.error_outline,
                                        size: 30.0,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                          child: Text(
                                        tarefas[i]["tarefa"],
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      )),
                                      Icon(
                                        tarefas[i]["status"]
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        size: 30.0,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                    ],
                                  ),
                                )),
                          ));
                    },
                  ),
                  onRefresh: _refreshTodoMateria
                  ),
            ),
          ),
        ],
      ),
    );
  }

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

  editMateria(indice) {
    return showDialog(
        context: context,
        builder: (contex) {
          return Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  //Titulo e Icone para fechar - Inicio
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              _materiaList[indiceMateria]["materia"],
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.close), onPressed: (){
                          Navigator.pop(context, true);
                        }),
                      ],
                    ),
                  ),
                  //Titulo e Icone para fechar - Fim
                  SizedBox(
                    height: 25.0,
                  ),
                  //1ª Prova Inicio
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 5.0,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "1ª Prova",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _p1Controler,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: _materiaList[indiceMateria]["p1"],
                              ),

                              // ,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //1ª Prova Fim
                  //1ª Trabalho Inicio
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 5.0,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "1º Trabalho",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _t1Controler,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: _materiaList[indiceMateria]["t1"],
                              ),

                              // ,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //1ª Trabalho Fim
                  //2ª Prova Inicio
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 5.0,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "2ª Prova",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _p2Controler,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: _materiaList[indiceMateria]["p2"],
                              ),

                              // ,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //2ª Prova Fim
                  //2ª Trabalho Inicio
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 5.0,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "2º Trabalho",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _t2Controler,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: _materiaList[indiceMateria]["t2"],
                              ),

                              // ,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 3, child: SizedBox()),
                        Expanded(
                          flex: 2,
                          child: FlatButton(
                            onPressed: salvarNota,
                            child: Card(
                              elevation: 5.0,
                              child: Container(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
                                height: 50.0,
                                color: Colors.green,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.save,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      "Atualizar",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //2ª Trabalho Fim
                ],
              ),
            ),
          );
        });
  }
}
