import 'package:flutter/material.dart';
import 'package:kinopoisk_app/features/movies/presentation/pages/movie_details.dart';
import 'package:kinopoisk_app/shared/pages/home_page.dart';

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => const HomePage(),
    '/movieDetails': (context) => const MovieDetails(),
  };
}
