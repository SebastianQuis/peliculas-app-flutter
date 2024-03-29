// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas/models/models.dart';

class SearchResponse {
    SearchResponse({
        this.page,
        required this.results,
        this.totalPages,
        this.totalResults,
    });

    int? page;
    List<Movie> results;
    int? totalPages;
    int? totalResults;

    factory SearchResponse.fromJson(String str) => SearchResponse.fromMap(json.decode(str));

    factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: json['results'] != null
          ? List<Movie>.from(json['results'].map((x) => Movie.fromMap(x))).toList()
          : [],
        totalPages: json["total_pages"] == null? null : json["total_pages"],
        totalResults: json["total_results"] == null? null : json["total_results"],
    );

}