import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _appBar(),
            _headerAdd()
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color.fromRGBO(57, 44, 206, 1.0),
      title: _titulo(),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.note_add,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _titulo() {
    return Row(
      children: <Widget>[
        Text(
          "Student",
          style: GoogleFonts.roboto(fontWeight: FontWeight.w300),
        ),
        Text(
          "Tasks",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _headerAdd() {
    return Container(
      height: 150.0,
      width: double.infinity,     
      color: Color.fromRGBO(57, 44, 206, 1.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(25.0),
            child: TextFormField( 
              style: TextStyle(color: Colors.black),
              initialValue: "Nova Tarefa",
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              
            ),
          ),
        ],
      ),
      
    );
  }
}
