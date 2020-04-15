import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/itemestudo_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';

class EstudoPage extends StatelessWidget {
  const EstudoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPadrao(context),
      body: SafeArea(child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              CardStory(),
              Container(padding: EdgeInsets.all(10.0), child: Titulo("meus", "Estudos")),
              ItemEstudo(),
              ItemEstudo(),
              ItemEstudo(),
              ItemEstudo(),
              ItemEstudo(),
              ItemEstudo(),
              ItemEstudo(),
            ],
          ),
        ),
      ))
    );
  }
}
