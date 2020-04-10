import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/itemmateria_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MateriaPage extends StatelessWidget {
  const MateriaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPadrao(),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CardStory(),
            Row(
              children: <Widget>[
                SizedBox(width: 10.0,),
                Titulo("minhas", "Materias"),
                Expanded(child: Container()),
                IconButton(icon: Icon(FontAwesomeIcons.plus, size: 20.0,), onPressed: null)
              ],
            ),
            ItemMateria("Portugues", Color.fromRGBO(57, 44, 206, 1.0)),
            ItemMateria("Matematica", Color.fromRGBO(44, 206, 138, 1.0) ),
            ItemMateria("Quimica", Color.fromRGBO(164, 44, 206, 1.0)),
            ItemMateria("Fisica",Color.fromRGBO(206, 93, 44, 1.0) ),
            ItemMateria("Historia",Color.fromRGBO(206, 44, 83, 1.0) ),
          ],
        ),
      ))
    );
  }
}
