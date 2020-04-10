import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ItemGrade extends StatelessWidget {

  final Color _cor;

  const ItemGrade(this._cor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),     
      height: 131.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: _cor,
        
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(        
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Portugues", style: GoogleFonts.roboto(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold)),
                Text("Media: 7.0", style: GoogleFonts.roboto(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.w300)),
                SizedBox(height: 15.0,),
                Text("Segunda-feira", style: GoogleFonts.roboto(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w500)),
                Text("Terça-Feira", style: GoogleFonts.roboto(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w500)),
                Text("Sexta-Feira", style: GoogleFonts.roboto(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w500))
              ],
            )
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("P1: 6.0", style: GoogleFonts.roboto(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w500)),
                Text("T1: 7.0", style: GoogleFonts.roboto(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w500)),
                Text("P2: 6.0", style: GoogleFonts.roboto(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w500)),
                Text("T2: 7.0", style: GoogleFonts.roboto(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w500)),
              ],
            )
          )
          
        ],
      ),
    );
  }
}