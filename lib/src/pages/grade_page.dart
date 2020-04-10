import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/itemgrade_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';

class GradePage extends StatefulWidget {
 

  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPadrao(),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          CardStory(),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Titulo("minha", "Grade")),
                  
                ],
              )),
          Container(margin: EdgeInsets.symmetric(horizontal: 5.0), child: ItemGrade(Color.fromRGBO(57, 44, 206, 1.0))),    
          Container(margin: EdgeInsets.symmetric(horizontal: 5.0), child: ItemGrade(Color.fromRGBO(164, 44, 206, 1.0))),    
          Container(margin: EdgeInsets.symmetric(horizontal: 5.0), child: ItemGrade(Color.fromRGBO(206, 44, 83, 1.0))),    
          Container(margin: EdgeInsets.symmetric(horizontal: 5.0), child: ItemGrade(Color.fromRGBO(44, 206, 138, 1.0))),    
          Container(margin: EdgeInsets.symmetric(horizontal: 5.0), child: ItemGrade(Color.fromRGBO(57, 44, 206, 1.0))),         
        ],
      ))),
    );
  }
}
