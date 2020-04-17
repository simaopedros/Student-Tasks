import 'dart:ui';

import 'package:appuniversitario/src/bloc/materias_bloc.dart';
import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/itemmateria_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MateriaPage extends StatefulWidget {


  


  @override
  _MateriaPageState createState() => _MateriaPageState();
}

class _MateriaPageState extends State<MateriaPage> {
  final usuario = "simaopedros";

  
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    MateriaBloc _materiaBloc = new MateriaBloc();
    _materiaBloc.carregarMaterias(usuario);

    return Scaffold(
        appBar: appBarPadrao(context),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CardStory(),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Titulo("minhas", "Materias"),
                  Expanded(child: Container()),
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.plus,
                        size: 20.0,
                      ),
                      onPressed: () {
                        _addMateria(context, _materiaBloc, usuario);
                      })
                ],
              ),

              StreamBuilder(
                stream: _materiaBloc.materiasStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<MateriaModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Container(
                        child: Text("Voce ainda não adicionou nenhuma materia"),
                      ),
                    );
                  }

                  if (snapshot.data.length > 0) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          for (var indice = 0;
                              indice < snapshot.data.length;
                              indice++)
                            Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (c) => _materiaBloc.deletarNota(snapshot.data[indice], usuario),
                              
                                                          child: ItemMateria(snapshot.data[indice].materia,
                                  Color.fromRGBO(
                                    snapshot.data[indice].corr == 255?000:snapshot.data[indice].corr, 
                                    snapshot.data[indice].corg == 255?000:snapshot.data[indice].corg, 
                                    snapshot.data[indice].corb == 255?000:snapshot.data[indice].corb,
                                    1.0)),
                                    background: Container(
                                      color: Colors.red,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: 15.0,),
                                          Icon(FontAwesomeIcons.trashAlt, color: Colors.white,),
                                          Expanded(child: Container()),
                                          
                                          
                                        ],
                                      ),
                                    ),
                            ),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),

            ],
          ),
        )));
  }

  Future _addMateria(
      BuildContext context, MateriaBloc materiaBloc, String usuario) {
    final _materiaController = new TextEditingController();
    final _materia = new MateriaModel();

    return showDialog(
        builder: (c) {
          return AddMateria(
            materiaController: _materiaController,
            materia: _materia,
            usuario: usuario,
          );
        },
        context: context);
  }
}

class AddMateria extends StatefulWidget {
  const AddMateria({
    Key key,
    @required TextEditingController materiaController,
    @required MateriaModel materia,
    this.usuario,
  })  : _materiaController = materiaController,
        _materia = materia,
        super(key: key);

  final TextEditingController _materiaController;
  final MateriaModel _materia;
  final String usuario;

  @override
  _AddMateriaState createState() => _AddMateriaState();
}

class _AddMateriaState extends State<AddMateria> {
  Color _cor = Colors.white;
  int _corR = 255;
  int _corG = 255;
  int _corB = 255;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MateriaBloc materiaBloc = new MateriaBloc();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10.0),
          height: 120.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: _cor, borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          height: 25.0,
                          width: 25.0,
                          color: Color.fromRGBO(57, 44, 206, 1.0),
                          margin: EdgeInsets.all(5.0),
                          child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  _cor = Color.fromRGBO(57, 44, 206, 1.0);
                                  _corR = 57;
                                  _corG = 44;
                                  _corB = 206;
                                });
                              },
                              child: null)),
                      Container(
                          height: 25.0,
                          width: 25.0,
                          color: Color.fromRGBO(164, 44, 206, 1.0),
                          margin: EdgeInsets.all(5.0),
                          child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  _cor = Color.fromRGBO(164, 44, 206, 1.0);
                                  _corR = 164;
                                  _corG = 44;
                                  _corB = 206;
                                });
                              },
                              child: null)),
                      Container(
                          height: 25.0,
                          width: 25.0,
                          color: Color.fromRGBO(206, 44, 83, 1.0),
                          margin: EdgeInsets.all(5.0),
                          child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  _cor = Color.fromRGBO(206, 44, 83, 1.0);
                                  _corR = 206;
                                  _corG = 44;
                                  _corB = 83;
                                });
                              },
                              child: null)),
                      Container(
                          height: 25.0,
                          width: 25.0,
                          color: Color.fromRGBO(44, 206, 138, 1.0),
                          margin: EdgeInsets.all(5.0),
                          child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  _cor = Color.fromRGBO(44, 206, 138, 1.0);
                                  _corR = 44;
                                  _corG = 206;
                                  _corB = 138;
                                });
                              },
                              child: null)),
                      Container(
                          height: 25.0,
                          width: 25.0,
                          color: Color.fromRGBO(206, 93, 44, 1.0),
                          margin: EdgeInsets.all(5.0),
                          child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  _cor = Color.fromRGBO(206, 93, 44, 1.0);
                                  _corR = 206;
                                  _corG = 93;
                                  _corB = 44;
                                });
                              },
                              child: null)),
                      Container(
                          height: 25.0,
                          width: 25.0,
                          color: Color.fromRGBO(100, 44, 206, 1.0),
                          margin: EdgeInsets.all(5.0),
                          child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  _cor = Color.fromRGBO(100, 44, 206, 1.0);
                                  _corR = 100;
                                  _corG = 44;
                                  _corB = 206;
                                });
                              },
                              child: null)),
                      Container(
                          height: 25.0,
                          width: 25.0,
                          color: Colors.black,
                          margin: EdgeInsets.all(5.0),
                          child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  _cor = Colors.white;
                                  _corR = 255;
                                  _corG = 255;
                                  _corB = 255;
                                });
                              },
                              child: null))
                    ],
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(FontAwesomeIcons.times),
                      onPressed: () {
                        Navigator.pop(context);

                        setState(() {
                          _cor = Colors.white;
                        });
                      }),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      child: TextField(
                    controller: widget._materiaController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Portugues"),
                  )),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                      icon: Icon(FontAwesomeIcons.plusSquare),
                      onPressed: () {
                        widget._materia.corr = _corR;
                        widget._materia.corg = _corG;
                        widget._materia.corb = _corB;
                        widget._materia.materia =
                            widget._materiaController.value.text;
                        materiaBloc.criarMaterias(
                            widget._materia, 
                            widget.usuario
                        );
                        Navigator.popAndPushNamed(context, "materia");
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
