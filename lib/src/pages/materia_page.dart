import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:flutter/material.dart';

class MateriaPage extends StatelessWidget {
  const MateriaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPadrao(),
      body: Container(
        child: Center(child: Text("MateriaPage")),
      ),
    );
  }
}
