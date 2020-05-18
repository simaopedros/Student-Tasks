
import 'package:appuniversitario/src/pages/home/features/eventos/eventos_bloc.dart';
import 'package:appuniversitario/src/pages/provas/provas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EtiquetaMateria extends StatelessWidget {
  final EventosModel _eventoModel;
  final EventosBloc eventosBloc;
  final String _usuario;
  final AvaliacaoBloc _avaliacaoBloc;
  final AvaliacoesModel _avaliacoesModel;
  const EtiquetaMateria(this._avaliacoesModel, this._avaliacaoBloc,
      this._usuario, this._eventoModel, this.eventosBloc);

  @override
  Widget build(BuildContext context) {
    _eventoModel.materia = _avaliacoesModel.materia;
    _eventoModel.prazo = _avaliacoesModel.data;
    _eventoModel.descricao = _avaliacoesModel.conteudo;
    _eventoModel.tipoevento = "Prova";
    _eventoModel.notifica = true;
    _eventoModel.local = "";
    _eventoModel.hora = "00:00";

    final List<String> _listaConteudo = _avaliacoesModel.conteudo
        .replaceAll("[", "")
        .replaceAll("]", "")
        .split(",");
    print(_listaConteudo.length);
    return Dismissible(
      key: UniqueKey(),
      secondaryBackground: Container(
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          children: <Widget>[
            Expanded(child: Container()),
            SizedBox(width: 25.0,),
            Text("Criar Evento", style:TextStyle(fontSize: 20.0, color: Colors.white),),
            SizedBox(width: 20.0,),
            Icon(
              FontAwesomeIcons.clock,
              color: Colors.white,
            ),
            SizedBox(
              width: 25.0,
            )
          ],
        ),
      ),
      background: Container(
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 25.0,
            ),
            Icon(
              FontAwesomeIcons.trash,
              size: 25.0,
              color: Colors.white,
            ),
            SizedBox(width: 20.0,),
            Text("Apagar", style:TextStyle(fontSize: 20.0, color: Colors.white),),
          ],
        ),
      ),
      child: Container(
          // margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(
                _avaliacoesModel.corR == 255 ? 000 : _avaliacoesModel.corR,
                _avaliacoesModel.corG == 255 ? 000 : _avaliacoesModel.corG,
                _avaliacoesModel.corB == 255 ? 000 : _avaliacoesModel.corB,
                1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 90,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _avaliacoesModel.materia,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        _avaliacoesModel.data,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 10.0),
                      )
                    ],
                  )),
              Expanded(child: Container()),
              Container(
                child: Column(
                  children: <Widget>[
                    Visibility(
                        visible: _listaConteudo.length > 1,
                        child: Text(
                          "Conteudo",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (var i = 0; i < _listaConteudo.length; i++)
                          Text(
                            _listaConteudo[i],
                            style: GoogleFonts.roboto(
                                fontSize: 10.0, color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
      onDismissed: (c) {        

        if(c == DismissDirection.startToEnd  ){
          _avaliacaoBloc.deletarAvaliacoes(_avaliacoesModel.id, _usuario);
        }

        if(c == DismissDirection.endToStart){
          eventosBloc.adicionarEvento(_eventoModel, _usuario);
          _avaliacaoBloc.carregarAvaliacoes(_usuario);
          eventosBloc.carregarEventos(_usuario);
        }

        print(c);
        
      },
    );
  }
}
