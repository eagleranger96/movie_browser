import 'package:flutter/material.dart';

import '../pages/error_page.dart';
import '../pages/loading_page.dart';
import '../config/bloc.dart';
import '../models/now_playing_movies.dart';
import '../models/popular_movies.dart';
import '../models/upcoming_movies.dart';
import '../config/page_state.dart';
import './movie.dart';

class AllMovies extends StatefulWidget {
  @override
  _AllMoviesState createState() => _AllMoviesState();
}

class _AllMoviesState extends State<AllMovies> {
  NowPlayingMovies nowPlayingMovies;
  PopularMovies popularMovies;
  UpcomingMovies upcomingMovies;
  Bloc bloc;
  PageState _pageState;

  void stateFunction(
    NowPlayingMovies _nowPlayingMovies,
    PopularMovies _popularMovies,
    UpcomingMovies _upcomingMovies,
  ) {
    Future.delayed(Duration.zero, () {
      if (_nowPlayingMovies == null ||
          _popularMovies == null ||
          _upcomingMovies == null) {
        setState(() {
          _pageState = PageState.Error;
        });
      } else {
        setState(() {
          nowPlayingMovies = _nowPlayingMovies;
          popularMovies = _popularMovies;
          upcomingMovies = _upcomingMovies;
          _pageState = PageState.Completed;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bloc = Bloc(stateFunction);
    bloc.getAllMovies();
    _pageState = PageState.Loading;
  }

  @override
  Widget build(BuildContext context) {
    if (_pageState == PageState.Loading) {
      return LoadingPage();
    } else if (_pageState == PageState.Error) {
      return ErrorPage(
        onPressed: () {
          setState(() {
            bloc.getAllMovies();
            _pageState = PageState.Loading;
          });
        },
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          title: Text("Movie Browser"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: ListView(
            children: <Widget>[
              Text(
                "Now Playing",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 250.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: nowPlayingMovies.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Movie(
                                movieId: nowPlayingMovies.results[index].id,
                                movieName:
                                    nowPlayingMovies.results[index].title,
                              );
                            },
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 200.0,
                            child: Card(
                              elevation: 4.0,
                              child: Image.network(
                                "http://image.tmdb.org/t/p/w200/" +
                                    nowPlayingMovies.results[index].posterPath,
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            padding: EdgeInsets.symmetric(horizontal: 7.0),
                            child: Text(
                              nowPlayingMovies.results[index].title,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Text(
                "Popular Movies",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                ),
                itemCount: popularMovies.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Movie(
                              movieId: popularMovies.results[index].id,
                              movieName: popularMovies.results[index].title,
                            );
                          },
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          elevation: 4.0,
                          child: Image.network(
                            "http://image.tmdb.org/t/p/w200/" +
                                popularMovies.results[index].posterPath,
                          ),
                        ),
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 7.0),
                          child: Text(
                            popularMovies.results[index].title,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Text(
                "Upcoming Movies",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 250.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: upcomingMovies.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Movie(
                                movieId: upcomingMovies.results[index].id,
                                movieName: upcomingMovies.results[index].title,
                              );
                            },
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 200.0,
                            child: Card(
                              elevation: 4.0,
                              child: Image.network(
                                "http://image.tmdb.org/t/p/w200/" +
                                    upcomingMovies.results[index].posterPath,
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            padding: EdgeInsets.symmetric(horizontal: 7.0),
                            child: Text(
                              upcomingMovies.results[index].title,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
