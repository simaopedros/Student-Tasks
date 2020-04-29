import 'package:appuniversitario/src/bloc/grades_bloc.dart';
import 'package:appuniversitario/src/bloc/materias_bloc.dart';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
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

  

  MateriaBloc materiaBloc = new MateriaBloc();
  GradesBloc gradesBloc = new GradesBloc();

  String usuario = "simaopedros";
  List<bool> item;
  List<String> materias;
  List<String> diasDaSeman;
  String materiaSelecionada;
  Color corMateria;

  @override
  void initState() {
    item = [false, false, false, false, false, false, false];
    materias = [];
    diasDaSeman = [
      "Segunda-feira",
      "Terça-feira",
      "Quarta-feira",
      "Quinta-feira",
      "Sexta-feira",
      "Sabado",
      "Domingo"
    ];
    materiaSelecionada = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final usuarioPrefer = new PreferenciasUsuario();
    usuarioPrefer.ultimaPagina = "grade";


    materiaBloc.carregarMaterias();
    gradesBloc.carregarG(usuario);

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
                        _selecionaMateria();
                      })
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: StreamBuilder(
              stream: gradesBloc.gradesStream,
              builder:
                  (BuildContext context, AsyncSnapshot<List<GradeModel>> s) {
                if (!s.hasData) {
                  print(s.data.toString());
                  return Container(
                    child: Text("Verificando grade..."),
                  );
                }

                if (s.data.length == 0) {
                  return Container(
                    child: Text("Adicione uma grade"),
                  );
                }

                if (s.data.length > 0) {
                  return Column(
                    children: <Widget>[
                      for(var i = 0; i < s.data.length; i++)
                        ItemGrade(s.data[i], gradesBloc, usuario)
                    ],
                  );
                }

                return Container();
              },
            ),
          ),

          //
        ],
      ))),
    );
  }

  _selecionaMateria() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      child: StreamBuilder(
        stream: materiaBloc.materiasStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<MateriaModel>> snapshot) {
          if (!snapshot.hasData) {
            return _aviso(0, snapshot);
          }

          if (snapshot.data.length == 0) {
            return _aviso(1, snapshot);
          }

          if (snapshot.data.length > 0) {
            return _aviso(2, snapshot);
          }

          return Container();
        },
      ),
    );
  }

  _aviso(int aviso, AsyncSnapshot<List<MateriaModel>> snapshot) {
    print("object");
    switch (aviso) {
      case 0:
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              height: 150.0,
              width: 250.0,
              child: Text("Verificando materias..."),
            ),
          ),
        );
        break;

      case 1:
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              height: 200.0,
              width: 250.0,
              child: _avisoSemMateria(),
            ),
          ),
        );
        break;

      case 2:
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.all(8.0),
              // height: 200.0,
              width: 200.0,
              child: _escolherMateria(snapshot),
            ),
          ),
        );

        break;

      default:
    }
  }

  _escolherMateria(AsyncSnapshot<List<MateriaModel>> snapshot) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Titulo("selecionar", "Materia"),
          for (var item = 0; item < snapshot.data.length; item++)
            Column(
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      setState(() {
                        materiaSelecionada = snapshot.data[item].materia;
                        corMateria = Color.fromRGBO(
                            snapshot.data[item].corr,
                            snapshot.data[item].corg,
                            snapshot.data[item].corb,
                            1.0);
                      });
                      Navigator.pop(context);
                      _edtarMateria();
                    },
                    child: Text(snapshot.data[item].materia)),
                Divider(
                  height: 2.0,
                )
              ],
            )
        ],
      ),
    );
  }

  _edtarMateria() {
    TextEditingController _p1Controller =
        new TextEditingController(text: "0.0");
    TextEditingController _pesoP1Controller =
        new TextEditingController(text: "0.0");
    TextEditingController _p2Controller =
        new TextEditingController(text: "0.0");
    TextEditingController _pesoP2Controller =
        new TextEditingController(text: "0.0");

    TextEditingController _t1Controller =
        new TextEditingController(text: "0.0");
    TextEditingController _pesoT1Controller =
        new TextEditingController(text: "0.0");
    TextEditingController _t2Controller =
        new TextEditingController(text: "0.0");
    TextEditingController _pesot2Controller =
        new TextEditingController(text: "0.0");

    TextEditingController _pesoB1Controller =
        new TextEditingController(text: "0.0");
    TextEditingController _pesoB2Controller =
        new TextEditingController(text: "0.0");

    return showDialog(
        context: context,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                padding: EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Titulo("editar", materiaSelecionada),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text("Selecione os dias de aula"),
                      SizedBox(
                        height: 15.0,
                      ),
                      for (var i = 0; i < diasDaSeman.length; i++) //----
                        Row(
                          children: <Widget>[
                            Checkbox(
                                key: UniqueKey(),
                                value: item[i],
                                onChanged: (c) {
                                  setState(() {
                                    item[i] = c;
                                  });
                                  Navigator.pop(context);
                                  _edtarMateria();
                                }),
                            Text(diasDaSeman[i])
                          ],
                        ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text("Configuração de notas"),
                      SizedBox(
                        height: 15.0,
                      ),
                      _linhaConfgMateria(_p1Controller, _pesoP1Controller,
                          "Nota P1", "6.0", "Peso da nota", "0.6"),
                      _linhaConfgMateria(_t1Controller, _pesoT1Controller,
                          "Nota T1", "6.0", "Peso da nota", "0.6"),
                      _linhaConfgMateria(_p2Controller, _pesoP2Controller,
                          "Nota P2", "6.0", "Peso da nota", "0.6"),
                      _linhaConfgMateria(_t2Controller, _pesot2Controller,
                          "Nota T2", "6.0", "Peso da nota", "0.4"),
                      _linhaConfgMateria(_pesoB1Controller, _pesoB2Controller,
                          "1ª Bim", "Peso", "2ª Bim", "Peso"),
                      SizedBox(
                        height: 15.0,
                      ),
                      FlatButton(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                            child: Text("Adicionar Grade"),
                          ),
                        ),
                        onPressed: () {
                          GradeModel gradeModel = new GradeModel();

                          gradeModel.materia  = materiaSelecionada;
                          gradeModel.p1       = _p1Controller.value.text;
                          gradeModel.t1       = _t1Controller.value.text;
                          gradeModel.p2       = _p2Controller.value.text;
                          gradeModel.t2       = _t2Controller.value.text;
                          gradeModel.pesop1   = _pesoP1Controller.value.text;
                          gradeModel.pesot1   = _pesoT1Controller.value.text;
                          gradeModel.pesop2   = _pesoP2Controller.value.text;
                          gradeModel.pesot2   = _pesot2Controller.value.text;
                          gradeModel.pesob1   = _pesoB1Controller.value.text;
                          gradeModel.pesob2   = _pesoB2Controller.value.text;

                          gradeModel.seg = item[0];
                          gradeModel.ter = item[1];
                          gradeModel.que = item[2];
                          gradeModel.qui = item[3];
                          gradeModel.sex = item[4];
                          gradeModel.sab = item[5];
                          gradeModel.dom = item[6];

                          gradeModel.corR = corMateria.red;
                          gradeModel.corG = corMateria.green;
                          gradeModel.corB = corMateria.blue;

                          gradesBloc.adicionarGrade(gradeModel, usuario);

                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  _avisoSemMateria() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              SizedBox(
                width: 5.0,
              ),
              Titulo("nenhuma", "Materia"),
              Expanded(child: Container()),
              IconButton(
                icon: Icon(FontAwesomeIcons.windowClose, size: 25.0,), 
                onPressed: () => Navigator.pop(context))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("Adicione ao menos uma materia e volte aqui!"),
          ),
          Expanded(
              child: Center(
            child: FlatButton(
                color: Colors.blueAccent,
                onPressed: (){                 
                  Navigator.pushNamed(context, "materia");
                },
                child: Text("Adicionar Materia")),
          ))
        ],
      ),
    );
  }

  Widget _linhaConfgMateria(
      TextEditingController c1,
      TextEditingController c2,
      String textoPeso1,
      String pesoNota1,
      String textoPeso2,
      String pesoNota2) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5.0,
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.black12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        controller: c1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: textoPeso1,
                            hintText: pesoNota1,
                            border: OutlineInputBorder()),
                      )),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: TextField(
                        controller: c2,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: textoPeso2,
                            hintText: pesoNota2,
                            border: OutlineInputBorder()),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
