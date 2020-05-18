import 'package:appuniversitario/src/bloc/provider.dart';
import 'package:appuniversitario/src/pages/home/features/notas/blocodenotas_bloc.dart';
import 'package:appuniversitario/src/pages/home/features/tarefas/tarefa_model.dart';
import 'package:appuniversitario/src/pages/home/features/tarefas/tarefas_bloc.dart';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:appuniversitario/src/widget/appbar_widget.dart';
import 'package:appuniversitario/src/widget/cardstory_widget.dart';
import 'package:appuniversitario/src/widget/listadetarefas_widget.dart';
import 'package:appuniversitario/src/widget/menusuperior_widget.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';


class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  

    static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    testDevices: <String>["FC819F38909485567ABCC171138A71FA", "441D51944CC1BB47847FA05D37484958"],
    keywords: <String>[
      'Escola', 'Faculdade', 'Cursos', 'Enem', 'Emprego', 'Estagio', 'Empreendedorismo'],
    childDirected: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd(){
    return new BannerAd(
      adUnitId: "ca-app-pub-6361762260659022/1744802029", 
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event){
        print("Banner Event: $event");
      }
    );
  }


  InterstitialAd crearintertAd(){
    return new InterstitialAd(
      adUnitId: "ca-app-pub-6361762260659022/7207760509",       
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event){
        print("Interstitial Event: $event");
      }
    );
  }


  
  final usuarioPrefer = new PreferenciasUsuario();
  String usuario = "simaopedros";
  DateTime tempo;


  @override
  void initState() {

     FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6361762260659022/1744802029");
     _bannerAd = createBannerAd()
     ..load()
     ..show();
    tempo = DateTime.now();
    super.initState();
    
  }

  @override
  void dispose() {
    
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

     
    final notasBloc = Provider.notasBloc(context);
    notasBloc.carregarNotas(usuario);

    final tarefaBloc = Provider.tarefasBloc(context);
    tarefaBloc.carregarTarefas();
    
    
    usuarioPrefer.ultimaPagina = "home";

    return Scaffold(
        appBar: appBarPadrao(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BarraSuperior(),
              CardStory(),
              _listaTarefas(tarefaBloc),
              _blocoDeNotas(notasBloc),
              SizedBox(height: 50.0,)
            ],
          ),
        ));
  }

  Widget _listaTarefas(TarefasBloc tarefaBloc) {

    return StreamBuilder(
      stream: tarefaBloc.tarefasStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<TarefaModel>> snapshot) {            
        if (!snapshot.hasData) {
          return Center(
            child: FlatButton(onPressed: (){
              tarefaBloc.carregarTarefas();
            }, 
            child: Center(child: Text("Buscando suas tarefas..."))),
          );
        }

        if (snapshot.data.length == 0) {
          return Container(
            height: 150.0,
            width: double.infinity,
            child: Center(
              child: Text("Parabens, nenhuma tarefa pendente."),
            ),
          );
        }

        if(snapshot.data.length > 0){
          return Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Titulo("tarefas", "Pendentes"),
              ),
              for (var cont = 0; cont < snapshot.data.length; cont++)
                Tarefa(snapshot.data[cont], snapshot.data[cont].id, usuario)
            ],
          ),
        );
        }

        return Container();
      },
    );
  }

  Widget _blocoDeNotas(NotasBloc notas) {
    return StreamBuilder(
      stream: notas.notasStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<BlocoDeNotasModel>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        if (snapshot.data.length > 0) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Titulo("blocoDe", "Notas"),
                for (var nota = 0; nota < snapshot.data.length; nota++)
                  _notas(snapshot.data[nota], notas),
              ],
            ),
          );
        }
        print(snapshot.data.length.toString());
        return Container();
      },
    );
  }

  Widget _notas(BlocoDeNotasModel nota, NotasBloc notaBloc) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.all(20.0),
          child: Text(nota.nota),
          decoration: BoxDecoration(
              color: Color.fromRGBO(218, 242, 39, 1.0),
              borderRadius: BorderRadius.circular(5)),
        ),
        Positioned(
            right: -10,
            top: 0,
            child: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () async {
                  notaBloc.deletarNota(nota, usuario);                  

                 // Navigator.pushReplacementNamed(context, "home");
                }))
      ],
    );
  }
}
