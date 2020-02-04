import 'dart:convert';
import 'dart:io';
import 'package:appuniversitario/Pages/viewMateria.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoControler = TextEditingController();
  final _addMateriaControler = TextEditingController();
  List _toDoList = [];
  List _materiaList = [];
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });

    _readDataMateria().then((dataMateria) {
      setState(() {
        _materiaList = json.decode(dataMateria);
      });
    });
  }

  void _addTodo() {
    setState(() {
      Map<String, dynamic> newTodo = Map();
      newTodo["tarefa"] = _todoControler.text;
      _todoControler.text = "";
      newTodo["status"] = false;
      newTodo["materia"] = "Geral";
      _toDoList.add(newTodo);

      _saveData();
    });
  }

  void _addMateria() {
    setState(() {
      Map<String, dynamic> newMateria = Map();
      newMateria["materia"] = _addMateriaControler.text;
      newMateria["p1"] = "0.0";
      newMateria["t1"] = "0.0";
      newMateria["p2"] = "0.0";
      newMateria["t2"] = "0.0";
      newMateria["tarefas"] = [];
      _addMateriaControler.text = "";
      _materiaList.add(newMateria);
      _saveDataMateria();
    });
  }

  addMateriaDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Adicionar Materia"),
            content: TextField(
              controller: _addMateriaControler,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Enviar"),
                onPressed: () {
                  if (_addMateriaControler.text.isNotEmpty) {
                    setState(() {
                      _addMateria();
                      _saveDataMateria();
                      Navigator.of(context)
                          .pop(_addMateriaControler.text.toString());
                    });
                  }
                },
              ),
            ],
          );
        });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _toDoList.sort((a, b) {
        if (a["status"] && !b["status"])
          return 1;
        else if (!a["status"] && b["status"])
          return -1;
        else
          return 0;
      });

      _saveData();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(
          "Student Tasks",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5.0),
              color: Colors.lightBlueAccent,
              alignment: Alignment.centerLeft,
              //Adicionar nova Materia
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    for (var cont = 0; cont < _materiaList.length; cont++)
                      FlatButton(
                        padding: EdgeInsets.all(0.0),
                        child: cardMateria(
                            _materiaList[cont]["materia"],
                            _materiaList[cont]["p1"],
                            _materiaList[cont]["t1"],
                            _materiaList[cont]["p2"],
                            _materiaList[cont]["t2"],
                            _materiaList[cont]["tarefas"]),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewMateria(indice: cont)));
                        },
                        onLongPress: () {
                          setState(() {
                            _materiaList.removeAt(cont);
                            _saveDataMateria();
                          });
                        },
                      ),
                    FlatButton(
                      onPressed: () {
                        addMateriaDialog(context);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          height: 150.0,
                          width: 100.0,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 50.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), //Adicionar nova Materia
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
                        controller: _todoControler,
                        decoration: InputDecoration(
                            labelText: "NovaTarefa",
                            labelStyle: TextStyle(color: Colors.blueGrey)),
                      ),
                    ),
                    RaisedButton(
                        focusElevation: 0,
                        color: Colors.transparent,
                        child: Icon(Icons.add),
                        elevation: 0.0,
                        onPressed: () {
                          if (_todoControler.text.isNotEmpty) {
                            _addTodo();
                          }
                        })
                  ],
                ),
              ),
            ), //Adicionar Tarefas
            Container(
              child: Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: _toDoList.length,
                    itemBuilder: buildItem,
                  ),
                ),
              ),
            ),
            //Visualizar tarefas..
          ],
        ),
      ),
    );
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

//Lista de Materias Fim
  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
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
      child: CheckboxListTile(
        checkColor: Colors.black87,
        title: Text(_toDoList[index]["tarefa"]),
        value: _toDoList[index]["status"],
        secondary: CircleAvatar(
          child: Icon(_toDoList[index]["status"]
              ? Icons.check_circle_outline
              : Icons.error_outline),
        ),
        onChanged: (c) {
          setState(() {
            _toDoList[index]["status"] = c;
            _saveData();
            _refresh();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);
          _saveData();

          final snack = SnackBar(
            content: Text("Tarefa ${_lastRemoved["tarefa"]} removida!"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _toDoList.insert(_lastRemovedPos, _lastRemoved);
                  _saveData();
                });
              },
            ),
            duration: Duration(seconds: 3),
          );
          Scaffold.of(context).removeCurrentSnackBar(); // ADICIONE ESTE COMANDO
          Scaffold.of(context).showSnackBar(snack);
        });
      },
    );
  }

  Widget cardMateria(materia, p1, t1, p2, t2, List tarefas) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 150.0,
              width: 100.0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      materia,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    Container(
                      height: 100.0,
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Column(
                        children: <Widget>[
                          //Media 01
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("P1:"),
                              Text(p1),
                            ],
                          ),
                          //Media 02
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("T1:"),
                              Text(t1),
                            ],
                          ),
                          //Media 03
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("P2:"),
                              Text(p2),
                            ],
                          ),
                          //Media 04
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("T2:"),
                              Text(t2),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      tarefas.length != null
                          ? tarefas.length.toString() + " Tarefas"
                          : "Nenhuma Tarefa",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
