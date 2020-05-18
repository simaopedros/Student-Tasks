import 'package:appuniversitario/src/bloc/provider.dart';
import 'package:appuniversitario/src/pages/home/features/eventos/eventos_bloc.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardStory extends StatefulWidget {
  @override
  _CardStoryState createState() => _CardStoryState();
}

class _CardStoryState extends State<CardStory> {
  final String usuario = "simaopedros";
  bool mostrarEventos;

  @override
  void initState() {
    mostrarEventos = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventoBloc = Provider.eventoBloc(context);
    eventoBloc.carregarEventos(usuario);

    return StreamBuilder(
      stream: eventoBloc.eventosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<EventosModel>> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox.shrink();
        }
        if (snapshot.data.length == 0) {
          return SizedBox.shrink();
        }
        if (snapshot.data.length > 0) {
          final dados = snapshot.data;
          final qdtCards = dados.length;
          mostrarEventos = true;
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: Titulo("proximos", "Eventos"),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var cont = 0; cont < qdtCards; cont++)
                        _cardStory(dados[cont], eventoBloc),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          child: Center(
            child: Text("Procurando eventos"),
          ),
        );
      },
    );
  }

  Widget _cardStory(EventosModel evento, eventoBloc) {
    return FlatButton(
      onPressed: null,
      key: UniqueKey(),
      onLongPress: () {
        eventoBloc.apagarEvento(evento.id, usuario);
      },
      child: Container(
      
        child: Container(
          height: 109.0,
          width: 74.0,
          child: Container(
              child: Stack(
            children: <Widget>[
              Container(
                height: 109.0,
                width: 74.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: LinearGradient(
                        begin: FractionalOffset(0.0, 0.5),
                        end: FractionalOffset(0.0, 1.0),
                        colors: [Colors.redAccent, Colors.black87])),
              ),
              
              Container(
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: Column(
                    
                    children: <Widget>[
                      Text(
                        evento.tipoevento,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(evento.prazo,
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 8.0),
                          overflow: TextOverflow.ellipsis),
                      Text(
                        evento.hora,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                          child: Text(evento.descricao,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 10.0,
                              ),
                              overflow: TextOverflow.clip)),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
