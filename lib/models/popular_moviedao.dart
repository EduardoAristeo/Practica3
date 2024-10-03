import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final dio = Dio();

class PopularMoviedao {
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  PopularMoviedao({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory PopularMoviedao.fromMap(Map<String, dynamic> popularMovie){
    return PopularMoviedao(

      backdropPath: popularMovie['backdrop_path'],
      id: popularMovie['id'],
      originalLanguage: popularMovie['original_language'],
      originalTitle: popularMovie['original_title'],
      overview: popularMovie['overview'],
      popularity: popularMovie['popularity'],
      posterPath: popularMovie['poster_path'],
      releaseDate: popularMovie['release_date'],
      title: popularMovie['title'],
      voteAverage: popularMovie['vote_average'],
      voteCount: popularMovie['vote_count'],
    );
  }
}
