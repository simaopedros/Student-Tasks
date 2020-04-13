import 'dart:convert';

EventosModel eventosModelFromJson(String str) => EventosModel.fromJson(json.decode(str));

String eventosModelToJson(EventosModel data) => json.encode(data.toJson());

class EventosModel {
    String id;
    String materia;
    String prazo;
    String hora;
    String local;
    String tarefa;
    String descricao;
    String tipoevento;
    bool notifica;

    EventosModel({
        this.id,
        this.materia,
        this.prazo,
        this.hora,
        this.local,
        this.tarefa,
        this.descricao,
        this.tipoevento,
        this.notifica,
    });

    factory EventosModel.fromJson(Map<String, dynamic> json) => EventosModel(
        id: json["id"],
        materia: json["materia"],
        prazo: json["prazo"],
        hora: json["hora"],
        local: json["local"],
        tarefa: json["tarefa"],
        descricao: json["descricao"],
        tipoevento: json["tipoevento"],
        notifica: json["notifica"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "materia": materia,
        "prazo": prazo,
        "hora": hora,
        "local": local,
        "tarefa": tarefa,
        "descricao": descricao,
        "tipoevento": tipoevento,
        "notifica": notifica,
    };
}
