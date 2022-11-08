// To parse this JSON data, do
//
//     final tcases = tcasesFromJson(jsonString);

import 'dart:convert';

Tcases tcasesFromJson(String str) => Tcases.fromJson(json.decode(str));

String tcasesToJson(Tcases data) => json.encode(data.toJson());

class Tcases {
    Tcases({
       required this.cases,
       required this.deaths,
       required this.recovered,
    });

    int cases;
    int deaths;
    int recovered;

    factory Tcases.fromJson(Map<String, dynamic> json) => Tcases(
        cases: json["cases"],
        deaths: json["deaths"],
        recovered: json["recovered"],
    );

    Map<String, dynamic> toJson() => {
        "cases": cases,
        "deaths": deaths,
        "recovered": recovered,
    };
}
