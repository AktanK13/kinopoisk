import 'package:flutter/material.dart';
import 'package:kinopoisk_app/core/styles/app_colors.dart';
import 'package:kinopoisk_app/features/movies/presentation/pages/movies.dart';
import 'package:kinopoisk_app/features/movies/presentation/pages/search_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: AppColors.red,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const MyHomePage(),

        /// Search page
        const SearchMovies()

        /// Messages page
      ][currentPageIndex],
    );
  }
}
