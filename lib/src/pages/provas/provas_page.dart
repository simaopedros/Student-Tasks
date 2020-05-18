
import 'package:appuniversitario/src/pages/home/features/eventos/eventos_bloc.dart';
import 'package:appuniversitario/src/pages/materias/materias_bloc.dart';

import 'package:appuniversitario/src/pages/provas/provas_bloc.dart';
import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/etiquetamateria_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProvaPage extends StatefulWidget {
  @override
  _ProvaPageState createState() => _ProvaPageState();
}

class _ProvaPageState extends State<ProvaPage> {
  DateTime data;
  List<String> assuntos;
  Color corMateria;
  String usuario = "simaopedros";
  String materiaSelecionada;

  MateriaBloc materiaBloc = new MateriaBloc();
  AvaliacaoBloc avaliacaoBloc = new AvaliacaoBloc();

  EventosBloc eventosBloc = new EventosBloc();
  EventosModel eventosModel = new EventosModel();

  @override
  void initState() {
    assuntos = [];
    data = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    materiaBloc.carregarMaterias();
    avaliacaoBloc.carregarAvaliacoes(usuario);

    //final usuarioPrefer = new PreferenciasUsuario();
    //usuarioPrefer.ultimaPagina = "estudo";

    return Scaffold(
        appBar: appBarPadrao(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                children: <Widget>[
                  CardStory(),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Titulo("minhas", "Avaliações"),
                              Expanded(child: Container()),
                              IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.plus,
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    _selecionaMateria();
                                  })
                            ],
                          ),
                          StreamBuilder(
                            stream: avaliacaoBloc.avaliacaoStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<AvaliacoesModel>> snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Verificando provas...");
                              }
                              if (snapshot.data.length == 0) {
                                return Text(
                                    "Voce não tem nenhuma prova agendada");
                              }

                              if (snapshot.data.length > 0) {
                                return Column(
                                  children: <Widget>[
                                    for (var i = 0;
                                        i < snapshot.data.length;
                                        i++)
                                      Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          EtiquetaMateria(
                                              snapshot.data[i],
                                              avaliacaoBloc,
                                              usuario,
                                              eventosModel,
                                              eventosBloc),
                                        ],
                                      ),
                                    //! Continuar daqui... Corrigir erro de carregamento dos assuntos...
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                            icon: Icon(
                              FontAwesomeIcons.windowClose,
                              size: 25.0,
                            ),
                            onPressed: () => Navigator.pop(context))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:
                          Text("Adicione ao menos uma materia e volte aqui!"),
                    ),
                    Expanded(
                        child: Center(
                      child: FlatButton(
                          color: Colors.blueAccent,
                          onPressed: () {
                            Navigator.pushNamed(context, "materia");
                          },
                          child: Text("Adicionar Materia")),
                    ))
                  ],
                ),
              ),
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
                      _ediatProva();
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

  _ediatProva() {
    return showDialog(
        context: context,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Titulo("adicionar", "Prova"),
                    _forumarioAvaliacao()
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _forumarioAvaliacao() {
    AvaliacoesModel avaliacoesModel = new AvaliacoesModel();
    TextEditingController assuntosController = new TextEditingController();
    TextEditingController dataController = new TextEditingController(
        text: "${data.day}/${data.month}/${data.year}");

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          TextField(
            controller: dataController,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Data da Prova",
                hintText: "16/06/2020"),
          ),
          SizedBox(
            height: 25.0,
          ),
          Text("Conteudo"),
          SizedBox(
            height: 15.0,
          ),
          TextField(
            controller: assuntosController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                  icon: Icon(FontAwesomeIcons.plus),
                  onPressed: () {
                    setState(() {
                      assuntos.add(assuntosController.value.text);
                    });
                    Navigator.pop(context);
                    _ediatProva();
                  }),
            ),
          ),
          for (var i = 0; i < assuntos.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.all(5.0),
                  child: Text(assuntos[i]),
                ),
                Divider(
                  height: 2.0,
                )
              ],
            ),
          SizedBox(
            height: 25.0,
          ),
          FlatButton(
              onPressed: () {
                avaliacoesModel.conteudo = assuntos.toString();
                avaliacoesModel.materia = materiaSelecionada;
                avaliacoesModel.data = dataController.value.text;
                avaliacoesModel.corR = corMateria.red;
                avaliacoesModel.corG = corMateria.green;
                avaliacoesModel.corB = corMateria.blue;

                avaliacaoBloc.criarAvaliacoes(avaliacoesModel, usuario);
                assuntos = [];

                Navigator.pop(context);
              },
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.blueAccent),
                child: Center(
                  child: Text(
                    "Adicionar",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
