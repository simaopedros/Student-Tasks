import 'package:appuniversitario/src/bloc/grades_bloc.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemGrade extends StatelessWidget {
  final String usuario;
  final GradesBloc _gradesBloc;
  final GradeModel _gradeModel;
  const ItemGrade(this._gradeModel, this._gradesBloc, this.usuario);

  @override
  Widget build(BuildContext context) {
    double _b1 = (double.parse(_gradeModel.p1) *
                double.parse(_gradeModel.pesop1) +
            double.parse(_gradeModel.t1) * double.parse(_gradeModel.pesot1)) *
        double.parse(_gradeModel.pesob1);
    double _b2 = (double.parse(_gradeModel.p2) *
                double.parse(_gradeModel.pesop2) +
            double.parse(_gradeModel.t2) * double.parse(_gradeModel.pesot2)) *
        double.parse(_gradeModel.pesob2);

    double _media = _b1 + _b2;
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: UniqueKey(),
      child: FlatButton(
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromRGBO(
                _gradeModel.corR == 255 ? 000 : _gradeModel.corR,
                _gradeModel.corG == 255 ? 000 : _gradeModel.corG,
                _gradeModel.corB == 255 ? 000 : _gradeModel.corB,
                1.0),
          ),
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_gradeModel.materia,
                      style: GoogleFonts.roboto(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text(_media.toStringAsFixed(2),
                      style: GoogleFonts.roboto(
                          fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w300)),
                  SizedBox(
                    height: 15.0,
                  ),
                  Visibility(
                    visible: _gradeModel.seg,
                    child: Text("Segunda-feira",
                        style: GoogleFonts.roboto(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                  Visibility(
                    visible: _gradeModel.ter,
                    child: Text("Terça-feira",
                        style: GoogleFonts.roboto(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                  Visibility(
                    visible: _gradeModel.que,
                    child: Text("Quarta-feira",
                        style: GoogleFonts.roboto(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                  Visibility(
                    visible: _gradeModel.qui,
                    child: Text("Quinta-feira",
                        style: GoogleFonts.roboto(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                  Visibility(
                    visible: _gradeModel.sex,
                    child: Text("Sexta-feira",
                        style: GoogleFonts.roboto(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                  Visibility(
                    visible: _gradeModel.sab,
                    child: Text("Sabado",
                        style: GoogleFonts.roboto(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                  Visibility(
                    visible: _gradeModel.dom,
                    child: Text("Domingo",
                        style: GoogleFonts.roboto(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("P1: ${_gradeModel.p1}",
                      style: GoogleFonts.roboto(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                  Text("T1: ${_gradeModel.t1}",
                      style: GoogleFonts.roboto(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                  Text("P2: ${_gradeModel.p2}",
                      style: GoogleFonts.roboto(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                  Text("T2: ${_gradeModel.t2}",
                      style: GoogleFonts.roboto(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                ],
              ))
            ],
          ),
        ),
        onPressed: () {
          _editarNotas(context, _gradeModel, _gradesBloc);
        },
      ),
      onDismissed: (c) {
        _gradesBloc.deletarGrade(_gradeModel.id, usuario);
      },
      background: _fundoDismis(),
    );
  }

  Widget _fundoDismis() {
    return Container(
      color: Colors.redAccent,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 25.0,
          ),
          Icon(
            FontAwesomeIcons.trash,
            size: 30.0,
            color: Colors.white,
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  _editarNotas(
      BuildContext context, GradeModel gradeModel, GradesBloc gradesBloc) {
    TextEditingController _p1 = new TextEditingController(text: gradeModel.p1);
    TextEditingController _pesoP1 = new TextEditingController(text: gradeModel.pesop1);
    TextEditingController _p2 = new TextEditingController(text: gradeModel.p2);
    TextEditingController _pesoP2 = new TextEditingController(text: gradeModel.pesop2);

    TextEditingController _t1 = new TextEditingController(text: gradeModel.pesot1);
    TextEditingController _pesoT1 = new TextEditingController(text: gradeModel.pesot1);
    TextEditingController _t2 = new TextEditingController(text: gradeModel.t2);
    TextEditingController _pesot2 = new TextEditingController(text: gradeModel.pesot2);

    TextEditingController _pesoB1 = new TextEditingController(text: gradeModel.pesob1);
    TextEditingController _pesoB2 = new TextEditingController(text: gradeModel.pesob2);

    return showDialog(
        context: context,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
                          child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Titulo("editar", "${gradeModel.materia}"),
                    ),
                    _linhaConfgMateria(_p1, _pesoP1, "Nota P1", "${gradeModel.p1}", "Peso P1", "${gradeModel.pesop1}", context),
                    _linhaConfgMateria(_t1, _pesoT1, "Nota T1", "${gradeModel.t1}", "Peso T1", "${gradeModel.pesot1}", context),
                    _linhaConfgMateria(_p2, _pesoP2, "Nota P2", "${gradeModel.p2}", "Peso P2", "${gradeModel.pesop2}", context),
                    _linhaConfgMateria(_t2, _pesot2, "Nota T2", "${gradeModel.t2}", "Peso T2", "${gradeModel.pesot2}", context),
                    _linhaConfgMateria(_pesoB1, _pesoB2, "Peso B1", "${gradeModel.pesob1}", "Peso B2", "${gradeModel.pesob2}", context),
                    
                    SizedBox(height: 15.0,),

                    FlatButton(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: Text("Editar Grade"),
                            ),
                          ),                        
                          onPressed: () {                    
                            
                            gradeModel.p1     = _p1.value.text;
                            gradeModel.t1     = _t1.value.text;
                            gradeModel.p2     = _p2.value.text;
                            gradeModel.t2     = _t2.value.text;
                            gradeModel.pesop1 = _pesoP1.value.text;
                            gradeModel.pesot1 = _pesoT1.value.text;
                            gradeModel.pesop2 = _pesoP2.value.text;
                            gradeModel.pesot2 = _pesot2.value.text;
                            gradeModel.pesob1 = _pesoB1.value.text;
                            gradeModel.pesob2 = _pesoB2.value.text;                          

                            gradesBloc.editarGrade(gradeModel, usuario);

                            Navigator.pop(context);
                          },
                        ),
                    
                    ],
                ),
              ),
            ),
          ),
        ));
  }


   Widget _linhaConfgMateria(
      TextEditingController c1,
      TextEditingController c2,
      String textoPeso1,
      String pesoNota1,
      String textoPeso2,
      String pesoNota2,
      BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5.0,
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.black12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        controller: c1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: textoPeso1,
                            hintText: pesoNota1,
                            border: OutlineInputBorder()),
                      )),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: TextField(
                        controller: c2,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: textoPeso2,
                            hintText: pesoNota2,
                            border: OutlineInputBorder()),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
