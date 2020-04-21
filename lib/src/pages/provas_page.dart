import 'package:appuniversitario/src/bloc/avaliacoes_bloc.dart';
import 'package:appuniversitario/src/bloc/materias_bloc.dart';
import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/etiquetamateria_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProvaPage extends StatefulWidget {
  

  @override
  _ProvaPageState createState() => _ProvaPageState();
}

class _ProvaPageState extends State<ProvaPage> {
  Color corMateria;
  String usuario = "simaopedros";
  String materiaSelecionada;
  MateriaBloc materiaBloc = new MateriaBloc();
  AvaliacaoBloc avaliacaoBloc = new AvaliacaoBloc();

  @override
  Widget build(BuildContext context) {

    materiaBloc.carregarMaterias(usuario);
    avaliacaoBloc.carregarAvaliacoes(usuario);

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
                            IconButton(icon: Icon(FontAwesomeIcons.plus, size: 20.0,), onPressed: (){_selecionaMateria();})
                          ],
                        ),
                        EtiquetaMateria("Portugues", "28/07/2019", Color.fromRGBO(57, 44, 206, 1.0)),
                        // EtiquetaMateria("Portugues", "28/07/2019", Color.fromRGBO(44, 206, 138, 1.0)),
                        // EtiquetaMateria("Portugues", "28/07/2019", Color.fromRGBO(164, 44, 206, 1.0)),
                        // EtiquetaMateria("Portugues", "28/07/2019", Color.fromRGBO(206, 93, 44, 1.0)),
                        // EtiquetaMateria("Portugues", "28/07/2019", Color.fromRGBO(206, 44, 83, 1.0)),
                     
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _selecionaMateria() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      child: StreamBuilder(
        stream: materiaBloc.materiasStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<MateriaModel>> snapshot) {
          if (!snapshot.hasData) {
            return _aviso(0, snapshot);
          }

          if (snapshot.data.length == 0) {
            return _aviso(1, snapshot);
          }

          if (snapshot.data.length > 0) {
            return _aviso(2, snapshot);
          }

          return Container();
        },
      ),
    );
  }

  _aviso(int aviso, AsyncSnapshot<List<MateriaModel>> snapshot) {
    
    switch (aviso) {
      case 0:
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              height: 150.0,
              width: 250.0,
              child: Text("Verificando materias..."),
            ),
          ),
        );
        break;

      case 1:
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              height: 200.0,
              width: 250.0,
              child: Text("Data 01"),
            ),
          ),
        );
        break;

      case 2:
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.all(8.0),
              // height: 200.0,
              width: 200.0,
              child: _escolherMateria(snapshot),
            ),
          ),
        );

        break;

      default:
    }
  }

  _escolherMateria(AsyncSnapshot<List<MateriaModel>> snapshot) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Titulo("selecionar", "Materia"),
          for (var item = 0; item < snapshot.data.length; item++)
            Column(
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      setState(() {
                        materiaSelecionada = snapshot.data[item].materia;
                        corMateria = Color.fromRGBO(
                            snapshot.data[item].corr,
                            snapshot.data[item].corg,
                            snapshot.data[item].corb,
                            1.0);
                      });
                      Navigator.pop(context);
                      _ediatProva();
                    },
                    child: Text(snapshot.data[item].materia)),
                Divider(
                  height: 2.0,
                )
              ],
            )
        ],
      ),
    );
  }


  _ediatProva(){
    return showDialog(
      context: context,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width*0.8,            
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Titulo("adicionar", "Prova")

                  //!  CONTINUAR DAQUI - FORMULARIO DE ADICAO DE PROVAS
                ],
              ),
            ),
          ),
        ),
      )
    );
  }


}
