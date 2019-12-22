import 'package:flutter/material.dart';

import '../config/bloc.dart';
import '../config/page_state.dart';
import '../models/movie_videos.dart';
import './error_page.dart';
import './loading_page.dart';

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
      return Scaffold(
        appBar: AppBar(
          title: Text("Movie Browser"),
        ),
        body: Center(
          child: Text("Some Error Occurred"),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.movieName),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.orange),
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: ListView.builder(
            itemCount: movieVideos.results.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movieVideos.results[index].name,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                    movieVideos.results[index].type,
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                  )
                ],
              );
            },
          ),
        ),
      );
    }
  }
}
