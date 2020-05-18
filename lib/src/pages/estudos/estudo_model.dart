import 'dart:convert';

EstudosModel estudosModelFromJson(String str) => EstudosModel.fromJson(json.decode(str));

String estudosModelToJson(EstudosModel data) => json.encode(data.toJson());

class EstudosModel {
    String id;
    String horaInicio;
    String horaFinal;
    String assunto;

    EstudosModel({
        this.id,
        this.horaInicio,
        this.horaFinal,
        this.assunto,
    });

    factory EstudosModel.fromJson(Map<String, dynamic> json) => EstudosModel(
        id: json["id"],
        horaInicio: json["hora_inicio"],
        horaFinal: json["hora_final"],
        assunto: json["assunto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "hora_inicio": horaInicio,
        "hora_final": horaFinal,
        "assunto": assunto,
    };
}
