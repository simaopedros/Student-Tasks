import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Titulo extends StatelessWidget {
  
  final String _firstTitulo;
  final String _secondTitulo;

  Titulo(this._firstTitulo, this._secondTitulo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          _firstTitulo,
          style:
              GoogleFonts.roboto(fontWeight: FontWeight.w300, fontSize: 20.0),
        ),
        Text(
          _secondTitulo,
          style:
              GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20.0),
        )
      ],
    );
  }
  
}