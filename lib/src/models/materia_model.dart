// To parse this JSON data, do
//
//     final materiaModel = materiaModelFromJson(jsonString);

import 'dart:convert';

MateriaModel materiaModelFromJson(String str) => MateriaModel.fromJson(json.decode(str));

String materiaModelToJson(MateriaModel data) => json.encode(data.toJson());

class MateriaModel {
    String id;
    String materia;
    int corr;
    int corg;
    int corb;

    MateriaModel({
        this.id,
        this.materia,
        this.corr,
        this.corg,
        this.corb,
    });

    factory MateriaModel.fromJson(Map<String, dynamic> json) => MateriaModel(
        id: json["id"],
        materia: json["materia"],
        corr: json["corr"],
        corg: json["corg"],
        corb: json["corb"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "materia": materia,
        "corr": corr,
        "corg": corg,
        "corb": corb,
    };
}
