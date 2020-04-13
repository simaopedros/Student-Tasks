import 'package:appuniversitario/src/bloc/tarefas_bloc.dart';
import 'package:appuniversitario/src/models/tarefa_model.dart';
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
    tarefaBloc.carregarTarefas("simaopedros");
    // final tarefasProvider = new TarefasProvider();
    return GestureDetector(
      onLongPress: () {},
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
        onDismissed: (c){
          _deletarTarefa(widget.tarefa.id, "simaopedros", tarefaBloc);
        },
      )
    ),
    );
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
}
