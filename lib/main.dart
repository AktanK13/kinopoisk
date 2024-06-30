import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kinopoisk_app/core/router/router.dart';
import 'package:kinopoisk_app/core/utils/injections.dart';
import 'package:kinopoisk_app/features/movies/presentation/bloc/movies_bloc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesBloc>(
          create: (context) => getIt<MoviesBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Kinopoisk',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        initialRoute: '/',
        routes: AppRoutes.routes,
      ),
    );
  }
}
