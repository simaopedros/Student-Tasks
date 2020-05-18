import 'dart:convert';

TarefaModel tarefaModelFromJson(String str) => TarefaModel.fromJson(json.decode(str));

String tarefaModelToJson(TarefaModel data) => json.encode(data.toJson());

class TarefaModel {
    String id;
    bool status;
    bool evento;
    String materia;
    String prazo;
    String tarefa;
    String descricao;
    String tipoevento;

    TarefaModel({
        this.id,
        this.status = true,
        this.evento = false,
        this.materia = '',
        this.prazo = '',
        this.tarefa = '',
        this.descricao = '',
        this.tipoevento = '',
    });

    factory TarefaModel.fromJson(Map<String, dynamic> json) => TarefaModel(
        id: json["id"],
        status: json["status"],
        evento: json["evento"],
        materia: json["materia"],
        prazo: json["prazo"],
        tarefa: json["tarefa"],
        descricao: json["descricao"],
        tipoevento: json["tipoevento"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "evento": evento,
        "materia": materia,
        "prazo": prazo,
        "tarefa": tarefa,
        "descricao": descricao,
        "tipoevento": tipoevento,
    };
}
