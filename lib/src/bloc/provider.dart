import 'package:appuniversitario/src/bloc/login_bloc.dart';
import 'package:appuniversitario/src/bloc/materias_bloc.dart';
export 'package:appuniversitario/src/bloc/login_bloc.dart';


import 'package:appuniversitario/src/bloc/tarefas_bloc.dart';
import 'package:flutter/material.dart';

export 'package:appuniversitario/src/bloc/tarefas_bloc.dart';


class Provider extends InheritedWidget{
  
  final tarefaBloc = new TarefasBloc();
  final _loginBloc = new LoginBloc();
  final _materiaBloc = new MateriaBloc();

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
  
}