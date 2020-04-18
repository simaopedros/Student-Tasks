import 'dart:convert';

GradeModel gradeModelFromJson(String str) => GradeModel.fromJson(json.decode(str));

String gradeModelToJson(GradeModel data) => json.encode(data.toJson());

class GradeModel {
    String id;
    String materia;
    int corr;
    int corg;
    int corb;
    int media;
    Diasdeaula diasdeaula;
    Notas notas;

    GradeModel({
        this.id,
        this.materia,
        this.corr,
        this.corg,
        this.corb,
        this.media,
        this.diasdeaula,
        this.notas,
    });

    factory GradeModel.fromJson(Map<String, dynamic> json) => GradeModel(
        id: json["id"],
        materia: json["materia"],
        corr: json["corr"],
        corg: json["corg"],
        corb: json["corb"],
        media: json["media"],
        diasdeaula: Diasdeaula.fromJson(json["diasdeaula"]),
        notas: Notas.fromJson(json["notas"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "materia": materia,
        "corr": corr,
        "corg": corg,
        "corb": corb,
        "media": media,
        "diasdeaula": diasdeaula.toJson(),
        "notas": notas.toJson(),
    };
}

class Diasdeaula {
    Diasdeaula();

    factory Diasdeaula.fromJson(Map<String, dynamic> json) => Diasdeaula(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Notas {
    P1 p1;
    P1 t1;
    P1 p2;
    P1 t2;

    Notas({
        this.p1,
        this.t1,
        this.p2,
        this.t2,
    });

    factory Notas.fromJson(Map<String, dynamic> json) => Notas(
        p1: P1.fromJson(json["p1"]),
        t1: P1.fromJson(json["t1"]),
        p2: P1.fromJson(json["p2"]),
        t2: P1.fromJson(json["t2"]),
    );

    Map<String, dynamic> toJson() => {
        "p1": p1.toJson(),
        "t1": t1.toJson(),
        "p2": p2.toJson(),
        "t2": t2.toJson(),
    };
}

class P1 {
    int nota;
    double peso;

    P1({
        this.nota,
        this.peso,
    });

    factory P1.fromJson(Map<String, dynamic> json) => P1(
        nota: json["nota"],
        peso: json["peso"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "nota": nota,
        "peso": peso,
    };
}
