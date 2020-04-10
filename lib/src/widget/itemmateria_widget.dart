import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ItemMateria extends StatelessWidget {
  
  final String _nomeMateria;
  final Color _cor;

  const ItemMateria( this._nomeMateria, this._cor);

  @override
  Widget build(BuildContext context) {
    return Container(      
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(5.0),
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: _cor,
        borderRadius: BorderRadius.circular(10.0),        
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(this._nomeMateria, style: GoogleFonts.roboto(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),),
        ],
      ),
    );
  }
}