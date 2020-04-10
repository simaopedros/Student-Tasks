import 'dart:convert';

TarefaModel tarefaModelFromJson(String str) => TarefaModel.fromJson(json.decode(str));

String tarefaModelToJson(TarefaModel data) => json.encode(data.toJson());

class TarefaModel {
    int id;
    bool status;
    bool evento;
    String materia;
    String prazo;
    String tarefa;

    TarefaModel({
        this.id,
        this.status,
        this.evento,
        this.materia,
        this.prazo,
        this.tarefa,
    });

    factory TarefaModel.fromJson(Map<String, dynamic> json) => TarefaModel(
        id      : json["id"],
        status  : json["status"],
        evento  : json["evento"],
        materia : json["materia"],
        prazo   : json["prazo"],
        tarefa  : json["tarefa"],
    );

    Map<String, dynamic> toJson() => {
        "id"      : id,
        "status"  : status,
        "evento"  : evento,
        "materia" : materia,
        "prazo"   : prazo,
        "tarefa"  : tarefa,
    };
}
