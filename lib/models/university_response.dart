// To parse this JSON data, do
//
//     final universityResponse = universityResponseFromMap(jsonString);

import 'dart:convert';

class UniversityResponse {
  UniversityResponse({
    this.alphaTwoCode,
    this.domains,
    this.country,
    this.stateProvince,
    this.webPages,
    this.name,
  });

  String? alphaTwoCode;
  List<String>? domains;
  String? country;
  dynamic stateProvince;
  List<String>? webPages;
  String? name;

  factory UniversityResponse.fromJson(String str) =>
      UniversityResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UniversityResponse.fromMap(Map<String, dynamic> json) =>
      UniversityResponse(
        alphaTwoCode: json["alpha_two_code"],
        domains: List<String>.from(json["domains"].map((x) => x)),
        country: json["country"],
        stateProvince:
            // ignore: unnecessary_null_in_if_null_operators
            json["state-province"] ?? null,
        webPages: List<String>.from(json["web_pages"].map((x) => x)),
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "alpha_two_code": alphaTwoCode,
        "domains": List<dynamic>.from(domains!.map((x) => x)),
        "country": country,
        // ignore: unnecessary_null_in_if_null_operators
        "state-province": stateProvince ?? null,
        "web_pages": List<dynamic>.from(webPages!.map((x) => x)),
        "name": name,
      };
}
