import 'package:appuniversitario/src/pages/estudos/estudos_bloc.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemEstudo extends StatefulWidget {
  final String usuario;
  final String diaDaSemana;

  const ItemEstudo(this.diaDaSemana, this.usuario);

  @override
  _ItemEstudoState createState() => _ItemEstudoState();
}

class _ItemEstudoState extends State<ItemEstudo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EstudosBloc estudosBloc = new EstudosBloc();
    estudosBloc.carregarEstudosSemana(widget.usuario, widget.diaDaSemana);

    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            height: 40.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                color: Colors.black87),
            child: Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsetsDirectional.only(start: 10.0),
                    child: Text(
                      widget.diaDaSemana,
                      style: TextStyle(color: Colors.white),
                    )),
                Expanded(child: Container()),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.plus,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    onPressed: () => _adicionarCompromiso(
                          widget.diaDaSemana,
                          context,
                          estudosBloc,
                        ))
              ],
            ),
          ),

          StreamBuilder(
            stream: estudosBloc.studosStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<EstudosModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("Verificando agenda"),
                );
              }
              if (snapshot.data.length == 0) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        "Clique em + para adicionar compromissos para ${widget.diaDaSemana}"),
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
                            onDismissed: (c) {
                              estudosBloc.deletarEstudo(widget.diaDaSemana,
                                  snapshot.data[indice].id, widget.usuario);
                            },
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              color: Colors.red,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 25.0,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.trashAlt,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  Expanded(child: Container())
                                ],
                              ),
                            ),
                            key: UniqueKey(),
                            child: _item(
                              snapshot.data[indice].assunto, 
                              snapshot.data[indice].horaInicio,
                              snapshot.data[indice].horaFinal))
                    ],
                  ),
                );
              }

              return Container();
            },
          ),
          //_item(),
        ],
      ),
    );
  }

  Future _adicionarCompromiso(
    String diaDaSemana,
    BuildContext context,
    EstudosBloc estudosBloc,
  ) {
    TextEditingController _controller = new TextEditingController();
    TextEditingController _controllerInicio = new TextEditingController();
    TextEditingController _controllerFim = new TextEditingController();
    EstudosModel _estudoModel = new EstudosModel();

    return showDialog(
        context: context,
        builder: (c) => Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                              child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: double.infinity,
                  height: 400.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Titulo("adicionar", "Estudo"),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: "Descição", 
                              border: OutlineInputBorder(),
                              labelText: "Descrição do estudo"
                              ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        TextField(
                          keyboardType: TextInputType.datetime,
                          controller: _controllerInicio,
                          decoration: InputDecoration(
                              hintText: "12:30", 
                              border: OutlineInputBorder(),
                              labelText: "Hora de Inicio"
                              
                              ),
                        ),
                         SizedBox(
                          height: 25.0,
                        ),
                        TextField(
                          controller: _controllerFim,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              hintText: "12:30", 
                              border: OutlineInputBorder(),
                              labelText: "Hora de Fim"
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        FlatButton(
                          onPressed: () {
                            _estudoModel.assunto = _controller.value.text;
                            _estudoModel.horaInicio = _controllerInicio.value.text;
                            _estudoModel.horaFinal = _controllerFim.value.text;

                            if (_estudoModel.assunto != "") {
                              estudosBloc.adicionarEstudo(
                                  _estudoModel, diaDaSemana, widget.usuario);
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.0)),
                            height: 50.0,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Center(
                              child: Text(
                                "Adicionar",
                                style: GoogleFonts.roboto(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget _item(String assunto, String hInicio, String hFim) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(color: Colors.black87),
              right: BorderSide(color: Colors.black87),
              bottom: BorderSide(color: Colors.black87))),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10.0,
          ),
          Text("$hInicio - $hFim"),
          SizedBox(
            width: 25.0,
          ),
          Text(assunto),
        ],
      ),
    );
  }
}
