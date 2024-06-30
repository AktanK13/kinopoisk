import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kinopoisk_app/core/styles/app_colors.dart';
import 'package:kinopoisk_app/core/styles/app_text_style.dart';
import 'package:kinopoisk_app/features/movies/domain/entities/movie.dart';
import 'package:kinopoisk_app/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchMovies extends StatefulWidget {
  const SearchMovies({super.key});

  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  final _searchSubject = BehaviorSubject<String>();
  static const _pageSize = 10;
  final PagingController<int, MovieEntity> _pagingController =
      PagingController(firstPageKey: 1);
  final TextEditingController _controller = TextEditingController();

  void _onSearchChanged(String query) {
    _searchSubject.add(query);
  }

  Future<void> _refreshPage() async {
    _pagingController.refresh();
  }

  @override
  void initState() {
    _searchSubject
        .debounceTime(const Duration(milliseconds: 500))
        .listen((query) {
      if (query.isNotEmpty) {
        _pagingController.refresh();
      } else {
        _pagingController.itemList = [];
      }
    });
    _pagingController.addPageRequestListener((pageKey) {
      final query = _searchSubject.valueOrNull ?? '';
      context.read<MoviesBloc>().add(
          SearchMoviesEvent(query: query, page: pageKey, limit: _pageSize));
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pagingController.dispose();
    _searchSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movie'),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SearchBar(
                controller: _controller,
                onChanged: _onSearchChanged,
                leading: const Icon(Icons.search),
                trailing: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                        _onSearchChanged('');
                      });
                    },
                    icon: const Icon(Icons.close_rounded),
                    selectedIcon: const Icon(Icons.brightness_2_outlined),
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocListener<MoviesBloc, MoviesState>(
                listener: (context, state) {
                  if (state is SearchMoviesSuccess) {
                    final isLastPage = state.movies.length < _pageSize;
                    if (isLastPage) {
                      _pagingController.appendLastPage(state.movies);
                    } else {
                      final nextPageKey =
                          (_pagingController.nextPageKey ?? 1) + 1;
                      _pagingController.appendPage(state.movies, nextPageKey);
                    }
                  } else if (state is MoviesError) {
                    _pagingController.error = state.message;
                  }
                },
                child: RefreshIndicator(
                  onRefresh: _refreshPage,
                  child: PagedListView<int, MovieEntity>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<MovieEntity>(
                      firstPageProgressIndicatorBuilder: (context) {
                        return const Center(child: Text('nothing here!'));
                      },
                      itemBuilder: (context, movie, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/movieDetails',
                                arguments: movie,
                              );
                            },
                            leading: movie.posterUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: movie.posterUrl ?? '',
                                    width: 50,
                                    height: 75,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      width: 50,
                                      height: 75,
                                      color: AppColors.lightGray,
                                    ),
                                    errorWidget: (context, error, stackTrace) {
                                      return Container(
                                        height: 56,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                            color: AppColors.lightGray),
                                        child: const Icon(Icons.error),
                                      );
                                    },
                                  )
                                : const SizedBox(
                                    height: 56,
                                    width: 50,
                                    child: Icon(Icons.image_not_supported),
                                  ),
                            title: movie.name != ''
                                ? Text(
                                    movie.name,
                                    style: AppTextStyle.largeBlack,
                                  )
                                : Text(
                                    movie.alternativeName,
                                    style: AppTextStyle.largeBlack,
                                  ),
                            subtitle: movie.kpRating != 0.0
                                ? Text('kpRating: ${movie.kpRating}')
                                : Text('imdbRating: ${movie.imdbRating}'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
