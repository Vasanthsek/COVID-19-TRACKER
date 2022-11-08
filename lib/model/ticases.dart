// To parse this JSON data, do
//
//     final ticases = ticasesFromJson(jsonString);

import 'dart:convert';

Ticases ticasesFromJson(String str) => Ticases.fromJson(json.decode(str));

String ticasesToJson(Ticases data) => json.encode(data.toJson());

class Ticases {
    Ticases({
       required this.total,
       required this.confirmedCasesIndian,
       required this.confirmedCasesForeign,
       required this.discharged,
      required  this.deaths,
      required  this.confirmedButLocationUnidentified,
    });

    int total;
    int confirmedCasesIndian;
    int confirmedCasesForeign;
    int discharged;
    int deaths;
    int confirmedButLocationUnidentified;

    factory Ticases.fromJson(Map<String, dynamic> json) => Ticases(
        total: json["total"],
        confirmedCasesIndian: json["confirmedCasesIndian"],
        confirmedCasesForeign: json["confirmedCasesForeign"],
        discharged: json["discharged"],
        deaths: json["deaths"],
        confirmedButLocationUnidentified: json["confirmedButLocationUnidentified"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "confirmedCasesIndian": confirmedCasesIndian,
        "confirmedCasesForeign": confirmedCasesForeign,
        "discharged": discharged,
        "deaths": deaths,
        "confirmedButLocationUnidentified": confirmedButLocationUnidentified,
    };
}
