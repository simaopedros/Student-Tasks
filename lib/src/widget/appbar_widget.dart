import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBarPadrao(){
  return AppBar(
      title: Row(
        children: <Widget>[
          Text("Student",
              style: GoogleFonts.roboto(fontWeight: FontWeight.w300)),
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
            onPressed: () {},
            icon: Icon(
              Icons.note_add,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ))
      ],
    );
}

