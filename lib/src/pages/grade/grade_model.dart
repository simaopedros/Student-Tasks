// To parse this JSON data, do
//
//     final gradeModel = gradeModelFromJson(jsonString);

import 'dart:convert';

GradeModel gradeModelFromJson(String str) => GradeModel.fromJson(json.decode(str));

String gradeModelToJson(GradeModel data) => json.encode(data.toJson());

class GradeModel {
    String id;
    String materia;
    String media;
    String p1;
    String p2;
    String t1;
    String t2;
    bool seg;
    bool ter;
    bool que;
    bool qui;
    bool sex;
    bool sab;
    bool dom;
    String pesop1;
    String pesop2;
    String pesot1;
    String pesot2;
    String pesob1;
    String pesob2;
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
        media: json["media"],
        p1: json["p1"],
        p2: json["p2"],
        t1: json["t1"],
        t2: json["t2"],
        seg: json["seg"],
        ter: json["ter"],
        que: json["que"],
        qui: json["qui"],
        sex: json["sex"],
        sab: json["sab"],
        dom: json["dom"],
        pesop1: json["pesop1"],
        pesop2: json["pesop2"],
        pesot1: json["pesot1"],
        pesot2: json["pesot2"],
        pesob1: json["pesob1"],
        pesob2: json["pesob2"],
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
