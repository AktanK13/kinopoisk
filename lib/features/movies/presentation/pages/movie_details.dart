import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kinopoisk_app/core/styles/app_colors.dart';
import 'package:kinopoisk_app/core/styles/app_text_style.dart';
import 'package:kinopoisk_app/features/movies/domain/entities/movie.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  // final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as MovieEntity;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name != '' ? movie.name : movie.alternativeName),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              movie.posterUrl != null && movie.posterUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: movie.posterUrl ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.lightGray,
                      ),
                      errorWidget: (context, error, stackTrace) {
                        return Container(
                          decoration:
                              const BoxDecoration(color: AppColors.lightGray),
                          child: const Icon(Icons.error),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(Icons.image_not_supported),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      movie.name,
                      style: AppTextStyle.xxxLargeBlackBold,
                    ),
                    Text(
                      movie.alternativeName,
                      style: AppTextStyle.xxxLargeBlackBold,
                    ),
                    Row(
                      children: [
                        Text(
                          'IMDB: ${movie.imdbRating.toString()}',
                          style: AppTextStyle.mediumBlack,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'KP: ${movie.kpRating.toString()}',
                          style: AppTextStyle.mediumBlack,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      children: [
                        const Text(
                          'Genres:',
                          style: AppTextStyle.largeBlack,
                        ),
                        Wrap(
                          children: movie.genres
                              .map((Genre genre) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      '${genre.name},',
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(movie.year.toString()),
                    const SizedBox(height: 20),
                    Text(movie.description != ''
                        ? movie.description
                        : movie.shortDescription),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
