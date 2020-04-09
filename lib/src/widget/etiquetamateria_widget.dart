import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EtiquetaMateria extends StatelessWidget {
  final String _materia;
  final String _data;
  final Color _cor;

  const EtiquetaMateria(this._materia, this._data, this._cor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _cor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 60.0,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_materia, style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0 ),),
                    SizedBox(height: 5.0,), 
                    Text(_data,  style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 10.0 ),)],
                )),            
            Expanded(child: Container()),
            
            Container(
              child: Column(
                children: <Widget>[
                  Text("Conteudo", style: GoogleFonts.roboto(color: Colors.white , fontWeight: FontWeight.w500),), 
                  Expanded(child: Container())
                ],),),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Gramatica", style: GoogleFonts.roboto(fontSize: 10.0, color: Colors.white),),
                  Text("Sonetos", style: GoogleFonts.roboto(fontSize: 10.0, color: Colors.white),),
                  Text("Poesias", style: GoogleFonts.roboto(fontSize: 10.0, color: Colors.white),),
                ],
              ),
            ),
            Expanded(child: Container()),
            Container(
              child: Icon(FontAwesomeIcons.chevronRight, color: Colors.white,),
            )



          ],
        ));
  }
}
