import 'package:appuniversitario/src/bloc/grades_bloc.dart';
import 'package:appuniversitario/src/bloc/materias_bloc.dart';
import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/itemgrade_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GradePage extends StatefulWidget {
  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  String valorInicial;

  @override
  void initState() {
    valorInicial = "Selecione uma Materia";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GradesBloc gradesBloc = new GradesBloc();
    MateriaBloc materiaBloc = new MateriaBloc();

    gradesBloc.carregarGrades("simaopedros");
    materiaBloc.carregarMaterias("simaopedros");

    return Scaffold(
      appBar: appBarPadrao(context),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          CardStory(),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Titulo("minha", "Grade"),
                  Expanded(child: Container()),
                  IconButton(
                      icon: Icon(FontAwesomeIcons.plus),
                      onPressed: () {
                        _adicionarGrade(materiaBloc, gradesBloc);
                      })
                ],
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ItemGrade(Color.fromRGBO(57, 44, 206, 1.0))),
        ],
      ))),
    );
  }

  _adicionarGrade(MateriaBloc materiaBloc, GradesBloc gradesBloc) {
    return showDialog(
      context: context,
      child: StreamBuilder(
        stream: materiaBloc.materiasStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<MateriaModel>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                margin: EdgeInsets.all(25.0),
                child: Center(
                  child: Text("Verificando lista de materias"),
                ),
              ),
            );
          }

          if (snapshot.data.length == 0) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.all(50.0),
                height: 200.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Adicione uma materia e depois volte aqui"),
                      SizedBox(
                        height: 25.0,
                      ),
                      FlatButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "materia"),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.0)),
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Text(
                              "Adicionar Primeira Materia",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            );
          }

          if (snapshot.data.length > 0) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(10.0),
                            child: Titulo('Escolher ', 'Materia')),
                        SizedBox(
                          height: 5.0,
                        ),
                        Divider(
                          height: 2.0,
                        ),
                        for (var item = 0; item < snapshot.data.length; item++)
                          Column(
                            children: <Widget>[
                              Container(
                                child: FlatButton(
                                  child: Text(snapshot.data[item].materia),
                                  onPressed: () {
                                    setState(() {
                                      valorInicial =
                                          snapshot.data[item].materia;
                                    });
                                    Navigator.pop(context);
                                    _configurarMateria(
                                      valorInicial,
                                      Color.fromRGBO(
                                          snapshot.data[item].corr,
                                          snapshot.data[item].corg,
                                          snapshot.data[item].corb,
                                          1.0),
                                      gradesBloc,
                                    );
                                  },
                                ),
                              ),
                              Divider(
                                height: 2.0,
                                color: Colors.black12,
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  _configurarMateria(String materia, Color corMateria, GradesBloc gradesBloc) {
    print(valorInicial);
    return showDialog(
        context: context,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                    //!CONTINUAR DAQUI -- FAZER TELA PARA ADICIONAR GRADE
                    child: Text(valorInicial),
              ),
            ),
          ),
        ));
  }
}
