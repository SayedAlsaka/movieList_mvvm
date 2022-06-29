import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/strings_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/view_model/search_view_model.dart';
import 'package:mvvm_demo/views/search_widget.dart';
import 'package:provider/provider.dart';
import '../models/search_model.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import '../shared/components.dart';
import '../view_model/movie_details_view_model.dart';
import 'movie_details_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<SearchResults> movies = [];
  late Future search;
  String query = '';

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchViewModel>(context, listen: false);
    var movieProvider =
        Provider.of<MovieDetailsViewModel>(context, listen: false);
    return Scaffold(
      body: Column(
        children: <Widget>[
          buildSearch(),
          if (query != '')
            FutureBuilder(
              future: search,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: Provider.of<SearchViewModel>(context)
                          .resultsList
                          .length,
                      itemBuilder: (context, index) {
                        return buildMovie(
                            Provider.of<SearchViewModel>(context)
                                .resultsList[index],
                            movieProvider,
                            searchProvider);
                      },
                    ),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: ColorManager.yellow,
                  ));
                }
              },
            ),
          if (query == '' &&
              Provider.of<SearchViewModel>(context)
                  .recentSearchHistory
                  .isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p16, right: AppPadding.p8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(AppConstants.recentSearches),
                  defaultTextButton(
                      function: () {
                        searchProvider.clearSearchHistory();
                      },
                      text: AppStrings.clear,
                      color: Colors.blue),
                ],
              ),
            ),
          if (query == '' &&
              Provider.of<SearchViewModel>(context)
                  .recentSearchHistory
                  .isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: Provider.of<SearchViewModel>(context)
                    .recentSearchHistory
                    .length,
                itemBuilder: (context, index) {
                  return buildMovie(
                      Provider.of<SearchViewModel>(context)
                          .recentSearchHistory[index],
                      movieProvider,
                      searchProvider);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: AppStrings.searchWidgetText,
        onChanged: searchMovie,
      );
  Future searchMovie(String query) async {
    await Provider.of<SearchViewModel>(context, listen: false).search(query);
    setState(() {
      this.query = query;
      movies = Provider.of<SearchViewModel>(context, listen: false).resultsList;
      search =
          Provider.of<SearchViewModel>(context, listen: false).search(query);
    });
  }

  Widget buildMovie(SearchResults movie, movieProvider, searchProvider) =>
      ListTile(
        onTap: () async {
          await movieProvider.getMovieDetails(movie.id);
          await movieProvider.getVideoID(movie.id);
          searchProvider.setSearchHistory(movie);
          navigatePush(
              context,
              MovieDetailsView(
                  movie: movieProvider.movieModel, id: movieProvider.videoID));
        },
        leading: Image.network(
          '${AppStrings.searchImagePath}${movie.posterPath}',
          fit: BoxFit.cover,
          width: AppSize.s50,
          height: AppSize.s80,
        ),
        title: Text(movie.title!),
        subtitle: Text(
          movie.releaseDate!,
          style: TextStyle(color: ColorManager.grey),
        ),
      );
}
