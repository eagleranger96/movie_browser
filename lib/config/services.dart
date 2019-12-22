import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/movie_videos.dart';
import '../models/upcoming_movies.dart';
import '../models/now_playing_movies.dart';
import '../models/popular_movies.dart';

final String _apiKey = "802b2c4b88ea1183e50e6b285a27696e";

Future<NowPlayingMovies> getNowPlayingMovies({int page = 1}) async {
  try {
    final response = await http.get(
        "http://api.themoviedb.org/3/movie/now_playing?api_key=" +
            _apiKey +
            "&page=" +
            page.toString());
    return NowPlayingMovies.fromRawJson(response.body);
  } on SocketException {
    return null;
  }
}

Future<PopularMovies> getPopularMovies({int page = 1}) async {
  try {
    final response = await http.get(
        "http://api.themoviedb.org/3/movie/popular?api_key=" +
            _apiKey +
            "&page=" +
            page.toString());
    return PopularMovies.fromRawJson(response.body);
  } on Exception {
    return null;
  }
}

Future<UpcomingMovies> getUpcomingMovies({int page = 1}) async {
  try {
    final response = await http.get(
        "http://api.themoviedb.org/3/movie/upcoming?api_key=" +
            _apiKey +
            "&page=" +
            page.toString());
    return UpcomingMovies.fromRawJson(response.body);
  } on Exception {
    return null;
  }
}

Future<MovieVideos> getMovieVideos({int movieId = 1}) async {
  try {
    final response = await http.get(
        "http://api.themoviedb.org/3/movie/$movieId/videos?api_key=" + _apiKey);
    return MovieVideos.fromRawJson(response.body);
  } on Exception {
    return null;
  }
}
