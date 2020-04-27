import 'package:appuniversitario/src/bloc/notas_bloc.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBarPadrao(context) {
  
  return AppBar(
    title: Row(
      children: <Widget>[
        Text("Student", style: GoogleFonts.roboto(fontWeight: FontWeight.w300)),
        Text(
          "Tasks",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
      ],
    ),
    backgroundColor: Color.fromRGBO(56, 44, 206, 1.0),
    elevation: 0.0,
    actions: <Widget>[
      IconButton(
          onPressed: () => _adicionrTarefa(context),
          icon: Icon(
            Icons.note_add,
            color: Colors.white,
          )),
      // IconButton(
      //     onPressed: () {
      //       // _importarDados(context);
      //     },
      //     icon: Icon(
      //       FontAwesomeIcons.ad,
      //       color: Colors.white,
      //     ))
    ],
  );
}

// _importarDados(context){
//   return showDialog(    
//     context: context,
//     child: Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(child: ImportarSql())
//   )
//   );
// }

Future _adicionrTarefa(context) {
  final _notaController = new TextEditingController();
  final _notaBloc = new NotasBloc();
  final _nota = new BlocoDeNotasModel();
  print("object");
  return showDialog(
      context: context,
      builder: (c) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(125, 125, 125, 0.4),
          body: Container(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 5.0,
                        ),
                        Titulo("adicionar", "Nota"),
                        Expanded(child: Container()),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.windowClose, size: 25.0,),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(
                          width: 10.0,
                        )
                      ],
                    ),
                    Container(
                      child: Expanded(
                        child: TextField(
                          controller: _notaController,
                          style: GoogleFonts.indieFlower(fontSize: 25.0),
                          maxLines: null,
                          autofocus: true,
                          enabled: true,
                          textAlign: TextAlign.justify,
                          autocorrect: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Container()),
                        Text("Add"),
                        Container( child: IconButton(
                          icon: Icon(FontAwesomeIcons.plusSquare, color: Colors.black, size: 25.0,), 
                          onPressed: (){
                            _nota.nota = _notaController.value.text;
                            _notaBloc.criarNota(_nota, "simaopedros");
                            _notaController.text = "";
                            Navigator.pop(context);
                          }),
                        ),                        
                        SizedBox(width: 10.0,)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
