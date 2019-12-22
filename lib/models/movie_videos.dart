// To parse this JSON data, do
//
//     final movieVideos = movieVideosFromJson(jsonString);

import 'dart:convert';

class MovieVideos {
    int id;
    List<Result> results;

    MovieVideos({
        this.id,
        this.results,
    });

    factory MovieVideos.fromRawJson(String str) => MovieVideos.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MovieVideos.fromJson(Map<String, dynamic> json) => MovieVideos(
        id: json["id"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String id;
    Iso6391 iso6391;
    Iso31661 iso31661;
    String key;
    String name;
    Site site;
    int size;
    String type;

    Result({
        this.id,
        this.iso6391,
        this.iso31661,
        this.key,
        this.name,
        this.site,
        this.size,
        this.type,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        iso6391: iso6391Values.map[json["iso_639_1"]],
        iso31661: iso31661Values.map[json["iso_3166_1"]],
        key: json["key"],
        name: json["name"],
        site: siteValues.map[json["site"]],
        size: json["size"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "iso_639_1": iso6391Values.reverse[iso6391],
        "iso_3166_1": iso31661Values.reverse[iso31661],
        "key": key,
        "name": name,
        "site": siteValues.reverse[site],
        "size": size,
        "type": type,
    };
}

enum Iso31661 { US }

final iso31661Values = EnumValues({
    "US": Iso31661.US
});

enum Iso6391 { EN }

final iso6391Values = EnumValues({
    "en": Iso6391.EN
});

enum Site { YOU_TUBE }

final siteValues = EnumValues({
    "YouTube": Site.YOU_TUBE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
