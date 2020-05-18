// To parse this JSON data, do
//
//     final avaliacoesModel = avaliacoesModelFromJson(jsonString);

import 'dart:convert';

AvaliacoesModel avaliacoesModelFromJson(String str) => AvaliacoesModel.fromJson(json.decode(str));

String avaliacoesModelToJson(AvaliacoesModel data) => json.encode(data.toJson());

class AvaliacoesModel {
    String id;
    String materia;
    String data;
    int corR;
    int corG;
    int corB;
    String conteudo;

    AvaliacoesModel({
        this.id,
        this.materia,
        this.data,
        this.corR,
        this.corG,
        this.corB,
        this.conteudo,
    });

    factory AvaliacoesModel.fromJson(Map<String, dynamic> json) => AvaliacoesModel(
        id: json["id"],
        materia: json["materia"],
        data: json["data"],
        corR: json["corR"],
        corG: json["corG"],
        corB: json["corB"],
        conteudo: json["conteudo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "materia": materia,
        "data": data,
        "corR": corR,
        "corG": corG,
        "corB": corB,
        "conteudo": conteudo,
    };
}
