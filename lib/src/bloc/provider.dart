import 'package:appuniversitario/src/bloc/tarefas_bloc.dart';
import 'package:flutter/material.dart';

export 'package:appuniversitario/src/bloc/tarefas_bloc.dart';


class Provider extends InheritedWidget{
  final tarefaBloc = new TarefasBloc();

  Provider({Key key, Widget child})
    : super (key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TarefasBloc tarefasBloc( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().tarefaBloc;
  }
  
}