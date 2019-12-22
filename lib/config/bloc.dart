import '../models/movie_videos.dart';
import '../models/now_playing_movies.dart';
import '../models/popular_movies.dart';
import '../models/upcoming_movies.dart';
import './services.dart';

class Bloc {
  final void Function(
      NowPlayingMovies nowPlayingMovies,
      PopularMovies popularMovies,
      UpcomingMovies upcomingMovies) _stateFunction;

  final void Function(MovieVideos movieVideos) _movieStateFunction;

  Bloc(this._stateFunction) : _movieStateFunction = null;

  Bloc.movie(this._movieStateFunction) : _stateFunction = null;

  void getAllMovies() async {
    final NowPlayingMovies _nowPlayingMovies = await getNowPlayingMovies();
    final PopularMovies _popularMovies = await getPopularMovies();
    final UpcomingMovies _upcomingMovies = await getUpcomingMovies();
    _stateFunction(_nowPlayingMovies, _popularMovies, _upcomingMovies);
  }

  void getMovie(int movieId) async {
    final MovieVideos _movieVideos = await getMovieVideos(movieId: movieId);
    _movieStateFunction(_movieVideos);
  }
}
