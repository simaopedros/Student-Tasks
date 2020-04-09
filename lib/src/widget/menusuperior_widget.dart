import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget barraSuperior(context, bool addNota) {
    return Container(
      height: addNota==true?150.0:100.0,
      width: double.infinity,
      color: Color.fromRGBO(56, 44, 206, 1.0),
      child: SafeArea(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          addNota == true?Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Nova Tarefa",
                  icon: Icon(
                    Icons.add,
                    color: Color.fromRGBO(56, 44, 206, 1.0),
                  ),
                  border: InputBorder.none),
            ),
          ):Container(),
          _menuSuperios(context),
        ],
      )),
    );
  }

  Widget _menuSuperios(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
              onPressed: () => Navigator.pushNamed(context, "provas"),
              child: Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.fileSignature,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    "PROVAS",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          FlatButton(
              onPressed: () => Navigator.pushNamed(context, 'grade'),
              child: Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.thLarge,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    "GRADE",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          FlatButton(
              onPressed: () => Navigator.pushNamed(context, 'estudo'),
              child: Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.bookReader,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    "ESTUDOS",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          FlatButton(
              onPressed: () => Navigator.pushNamed(context, 'materia'),
              child: Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.book,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    "MATERIAS",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
        ],
      ),
    );
  }