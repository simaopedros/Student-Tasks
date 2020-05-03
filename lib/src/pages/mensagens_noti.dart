import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:flutter/material.dart';


class MenssagemNotif extends StatelessWidget {
  const MenssagemNotif({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appBarPadrao(context),
      body: Container(child: Center(child: Text(arg),),),
    );
  }
}