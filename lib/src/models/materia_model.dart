import 'dart:convert';

MateriaModel materiaModelFromJson(String str) => MateriaModel.fromJson(json.decode(str));

String materiaModelToJson(MateriaModel data) => json.encode(data.toJson());

class MateriaModel {
    String id;
    String nota;

    MateriaModel({
        this.id,
        this.nota,
    });

    factory MateriaModel.fromJson(Map<String, dynamic> json) => MateriaModel(
        id: json["id"],
        nota: json["nota"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nota": nota,
    };
}
