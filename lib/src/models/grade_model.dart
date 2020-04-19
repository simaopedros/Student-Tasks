// To parse this JSON data, do
//
//     final gradeModel = gradeModelFromJson(jsonString);

import 'dart:convert';

GradeModel gradeModelFromJson(String str) => GradeModel.fromJson(json.decode(str));

String gradeModelToJson(GradeModel data) => json.encode(data.toJson());

class GradeModel {
    String id;
    String materia;
    double media;
    double p1;
    double p2;
    double t1;
    double t2;
    bool seg;
    bool ter;
    bool que;
    bool qui;
    bool sex;
    bool sab;
    bool dom;
    double pesop1;
    double pesop2;
    double pesot1;
    double pesot2;
    double pesob1;
    double pesob2;
    int corR;
    int corG;
    int corB;

    GradeModel({
        this.id,
        this.materia,
        this.media,
        this.p1,
        this.p2,
        this.t1,
        this.t2,
        this.seg,
        this.ter,
        this.que,
        this.qui,
        this.sex,
        this.sab,
        this.dom,
        this.pesop1,
        this.pesop2,
        this.pesot1,
        this.pesot2,
        this.pesob1,
        this.pesob2,
        this.corR,
        this.corG,
        this.corB,
    });

    factory GradeModel.fromJson(Map<String, dynamic> json) => GradeModel(
        id: json["id"],
        materia: json["materia"],
        media: json["media"].toDouble(),
        p1: json["p1"].toDouble(),
        p2: json["p2"].toDouble(),
        t1: json["t1"].toDouble(),
        t2: json["t2"].toDouble(),
        seg: json["seg"],
        ter: json["ter"],
        que: json["que"],
        qui: json["qui"],
        sex: json["sex"],
        sab: json["sab"],
        dom: json["dom"],
        pesop1: json["pesop1"].toDouble(),
        pesop2: json["pesop2"].toDouble(),
        pesot1: json["pesot1"].toDouble(),
        pesot2: json["pesot2"].toDouble(),
        pesob1: json["pesob1"].toDouble(),
        pesob2: json["pesob2"].toDouble(),
        corR: json["corR"],
        corG: json["corG"],
        corB: json["corB"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "materia": materia,
        "media": media,
        "p1": p1,
        "p2": p2,
        "t1": t1,
        "t2": t2,
        "seg": seg,
        "ter": ter,
        "que": que,
        "qui": qui,
        "sex": sex,
        "sab": sab,
        "dom": dom,
        "pesop1": pesop1,
        "pesop2": pesop2,
        "pesot1": pesot1,
        "pesot2": pesot2,
        "pesob1": pesob1,
        "pesob2": pesob2,
        "corR": corR,
        "corG": corG,
        "corB": corB,
    };
}
