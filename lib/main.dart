import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './pages/all_movies.dart';

void main() {
  runApp(MaterialApp(
    title: "Movie Browser",
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: AllMovies(),
  ));
}
