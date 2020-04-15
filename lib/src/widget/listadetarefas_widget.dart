import 'package:appuniversitario/src/bloc/eventos_bloc.dart';
import 'package:appuniversitario/src/bloc/tarefas_bloc.dart';
import 'package:appuniversitario/src/models/evento_model.dart';
import 'package:appuniversitario/src/models/tarefa_model.dart';
import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Tarefa extends StatefulWidget {
  final TarefaModel tarefa;
  final String id;
  final String usuario;

  const Tarefa(this.tarefa, this.id, this.usuario);

  @override
  _TarefaState createState() => _TarefaState();
}

class _TarefaState extends State<Tarefa> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tarefaBloc = new TarefasBloc();
    final eventoModel = new EventosModel();
    tarefaBloc.carregarTarefas("simaopedros");
    // final tarefasProvider = new TarefasProvider();
    return GestureDetector(
      onLongPress: () =>
          _abrirTarefas(widget.usuario, widget.id, widget.tarefa, eventoModel),
      child: Hero(
        tag: widget.tarefa.id,
        child: Container(
            child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.red,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  FontAwesomeIcons.trash,
                  color: Colors.white,
                  size: 15.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Deletar",
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          child: ListTile(
            title: Text(
              widget.tarefa.tarefa,
              style: GoogleFonts.roboto(
                  decoration: widget.tarefa.status == false
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            //leading: Icon(Icons.calendar_view_day),
            trailing: IconButton(
                icon: Icon(widget.tarefa.status == true
                    ? Icons.check_box_outline_blank
                    : Icons.check_box),
                onPressed: () {
                  setState(() {
                    _aterarStatus(widget.tarefa, "simaopedros", tarefaBloc);
                  });
                }),
          ),
          onDismissed: (c) {
            _deletarTarefa(widget.tarefa.id, "simaopedros", tarefaBloc);
          },
        )),
      ),
    );
  }

  _abrirTarefas(
      String usuario, String id, TarefaModel tar, EventosModel eventosModel) {
    final idController = id;
    final materiaController = new TextEditingController(text: tar.materia);
    final prazoController = new TextEditingController(text: tar.prazo);
    final horaController = new TextEditingController();
    final localController = new TextEditingController();
    final tarefaController = new TextEditingController(text: tar.tarefa);
    final descricaoController = new TextEditingController(text: tar.descricao);
    final tipoEventoController = new TextEditingController();
    bool notificaController = true;


    final tarefa = new TarefasBloc();    
    final evento = new EventosBloc();

    tarefa.carregarUmaTarefa(usuario, id);
  
    return showDialog(
        context: context,
        builder: (cont) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Hero(
                tag: tar.id,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Titulo("criar", "Evento"),
                          Expanded(child: Container()),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.times), 
                            onPressed: () => Navigator.pop(context)
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Tarefa:",
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        enabled: false,                        
                        controller: tarefaController,
                        decoration: InputDecoration(
                            hintText: tar.tarefa, border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 10.0),

                      SwitchListTile(                        
                        value: notificaController,
                        onChanged: (valor){
                          setState(() {
                            notificaController = valor;
                          });
                        },
                        title: Text("Habilitar notificação"),
                      ),
                                            Text(
                        "Descrição:",
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        controller: descricaoController,
                        decoration: InputDecoration(
                          hintText: tar.descricao,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      
                      SizedBox(height: 10.0),


                      Text(
                        "Data do evento:",
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        controller: prazoController,
                        decoration: InputDecoration(
                      hintText: tar.prazo,
                      helperText: "Formato: DD/MM/AAAA",
                      border: OutlineInputBorder(),
                        ),
                      ),

                      SizedBox(height: 10.0),

                      Text(
                        "Horario:",
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        controller: horaController,
                        decoration: InputDecoration(
                      hintText: tar.prazo,
                      helperText: "Formato: 16:30",
                      border: OutlineInputBorder(),
                        ),
                      ),
                      
                      SizedBox(height: 10.0),
                      Text(
                        "Local do evento:",
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        controller: localController,
                        decoration: InputDecoration(
                          hintText: eventosModel.local,
                          helperText: "EX: Sorocaba - SP",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Tipo de evento:",
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        controller: tipoEventoController,
                        decoration: InputDecoration(
                          hintText: eventosModel.tipoevento,
                          helperText: "Ex: Formatura, Meetup",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      FlatButton(
                          onPressed: (){
                            eventosModel.id          = idController;
                            eventosModel.materia     = materiaController.value.text;
                            eventosModel.prazo       = prazoController.value.text;
                            eventosModel.hora        = horaController.value.text;
                            eventosModel.local       = localController.value.text;
                            eventosModel.tarefa      = tarefaController.value.text;
                            eventosModel.descricao   = descricaoController.value.text;
                            eventosModel.tipoevento  = tipoEventoController.value.text;
                            eventosModel.notifica    = notificaController;
                            
                            evento.adicionarEvento(eventosModel, usuario);
                            evento.carregarEventos(usuario);
                            
                            Navigator.pushReplacementNamed(context, "home");
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(56, 44, 206, 1.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                              height: 50.0,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Center(
                                  child: Text(
                                "Criar Evento",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.0),
                              ))))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
    }
  }

  void _aterarStatus(TarefaModel tar, usuario, TarefasBloc tarefasBloc) {
    if (tar.id != null) {
      tar.status = tar.status == false ? true : false;
      tarefasBloc.atualizarTarefa(tar, usuario);
    }
  }

  void _deletarTarefa(String tar, String usuario, TarefasBloc tarefasBloc) {
    tarefasBloc.apagarTarefa(tar, usuario);
    tarefasBloc.carregarTarefas(usuario);
    //Navigator.pushReplacementNamed(context, "home");
  }

