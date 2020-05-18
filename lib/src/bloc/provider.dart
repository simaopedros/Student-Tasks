import 'package:appuniversitario/src/pages/home/features/eventos/eventos_bloc.dart';
import 'package:appuniversitario/src/pages/home/features/notas/blocodenotas_bloc.dart';
import 'package:appuniversitario/src/pages/home/features/tarefas/tarefas_bloc.dart';
import 'package:appuniversitario/src/pages/materias/materias_bloc.dart';
import 'package:appuniversitario/src/pages/usuario/login_bloc.dart';
import 'package:flutter/material.dart';



class Provider extends InheritedWidget{
  
  final tarefaBloc = new TarefasBloc();
  final _loginBloc = new LoginBloc();
  final _materiaBloc = new MateriaBloc();
  final _notasBloc = new NotasBloc();
  final _eventoBloc = new EventosBloc();


  Provider({Key key, Widget child})
    : super (key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TarefasBloc tarefasBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().tarefaBloc;
  }

  static LoginBloc loginBloc( BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }

  static MateriaBloc materiaBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._materiaBloc;
  }
  
  static NotasBloc notasBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._notasBloc;
  }

  static EventosBloc eventoBloc(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._eventoBloc;
  }


}