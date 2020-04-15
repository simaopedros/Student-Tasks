import 'package:appuniversitario/src/bloc/eventos_bloc.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardStory extends StatelessWidget {
  final eventoBloc = new EventosBloc();
  final evento = new EventosModel();
  
  @override
  Widget build(BuildContext context) {

    eventoBloc.carregarEventos("simaopedros");    

    return Container(
      padding: EdgeInsets.all(10.0),
      color: Color.fromRGBO(239, 239, 239, 1),
      height: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Titulo("proximos", "Eventos"),
          SizedBox(
            height: 10.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StreamBuilder(
              stream: eventoBloc.eventosStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<EventosModel>> snapshot) {               

                if (snapshot.hasData) {
                  final dados = snapshot.data;
                  final qdtCards = dados.length;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var cont = 0; cont < qdtCards; cont++)
                        _cardStory(dados[cont]),
                    ],
                  );
                }

                // if (snapshot.data.length == 0) {
                //   return Text("Sem Eventos");
                // }


                return Container(child: Center(child: Text("Procurando eventos"),),);

                
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardStory(EventosModel evento) {
    
    
    return Container(
      margin: EdgeInsets.only(right: 10.0),
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
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(8.0),
            //   child: Container(child: Image(
            //     height: 109.0,
            //     width: 74.0,
            //     image: AssetImage("assets/evento.png"), fit: BoxFit.fitWidth,))
            // ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Text(
                    evento.tipoevento,
                    style: GoogleFonts.roboto(color: Colors.white,
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(evento.prazo,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 8.0),
                      overflow: TextOverflow.ellipsis),
                  Text(
                    evento.hora,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(
                      child: Text(
                          evento.descricao,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 10.0,
                          ),
                          overflow: TextOverflow.clip)),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
