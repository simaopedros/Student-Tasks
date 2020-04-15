import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/etiquetamateria_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProvaPage extends StatelessWidget {
  const ProvaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarPadrao(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(              
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0)
              ),              
              child: Column(
                children: <Widget>[
                  CardStory(),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Titulo("minhas", "Avaliações"),
                            Expanded(child: Container()),
                            IconButton(icon: Icon(FontAwesomeIcons.plus, size: 20.0,), onPressed: null)
                          ],
                        ),
                        EtiquetaMateria("Portugues", "28/07/2019", Color.fromRGBO(57, 44, 206, 1.0)),
                        EtiquetaMateria("Portugues", "28/07/2019", Color.fromRGBO(44, 206, 138, 1.0)),
                        EtiquetaMateria("Portugues", "28/07/2019", Color.fromRGBO(164, 44, 206, 1.0)),
                        EtiquetaMateria("Portugues", "28/07/2019", Color.fromRGBO(206, 93, 44, 1.0)),
                        EtiquetaMateria("Portugues", "28/07/2019", Color.fromRGBO(206, 44, 83, 1.0)),
                     
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
