
import 'dart:convert';

BlocoDeNotasModel blocoDeNotasModellFromJson(String str) => BlocoDeNotasModel.fromJson(json.decode(str));

String blocoDeNotasModelToJson(BlocoDeNotasModel data) => json.encode(data.toJson());

class BlocoDeNotasModel {
    String id;
    String nota;

    BlocoDeNotasModel({
        this.id,
        this.nota,
    });

    factory BlocoDeNotasModel.fromJson(Map<String, dynamic> json) => BlocoDeNotasModel(
        id: json["id"],
        nota: json["nota"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nota": nota,
    };
}
