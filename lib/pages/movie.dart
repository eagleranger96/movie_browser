import 'package:flutter/material.dart';

import '../config/services.dart';
import '../config/bloc.dart';
import '../config/page_state.dart';
import '../models/movie_videos.dart';
import './loading_page.dart';
import '../pages/error_page.dart';

class Movie extends StatefulWidget {
  final int movieId;
  final String movieName;

  Movie({this.movieId, this.movieName});

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  MovieVideos movieVideos;
  Bloc bloc;
  PageState _pageState;

  void stateFunction(MovieVideos _movieVideos) {
    Future.delayed(Duration.zero, () {
      if (_movieVideos == null) {
        setState(() {
          _pageState = PageState.Error;
        });
      } else {
        setState(() {
          movieVideos = _movieVideos;
          _pageState = PageState.Completed;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bloc = Bloc.movie(stateFunction);
    bloc.getMovie(widget.movieId);
    _pageState = PageState.Loading;
  }

  @override
  Widget build(BuildContext context) {
    if (_pageState == PageState.Loading) {
      return LoadingPage();
    } else if (_pageState == PageState.Error) {
      return ErrorPage(
        onPressed: () {
          bloc.getMovie(widget.movieId);
          _pageState = PageState.Loading;
        },
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          title: Text(widget.movieName),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: ListView.builder(
            itemCount: movieVideos.results.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  movieVideos.results[index].name,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  movieVideos.results[index].type,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  launchURL("https://www.youtube.com/watch?v=" +
                      movieVideos.results[index].key);
                },
              );
            },
          ),
        ),
      );
    }
  }
}
