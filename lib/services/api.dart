import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvvm_demo/models/movie_model.dart';
import 'package:mvvm_demo/models/search_model.dart';
import 'package:mvvm_demo/models/theaters_model.dart';
import 'package:mvvm_demo/models/up_coming_model.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';

import '../models/video_model.dart';

class HomeApi {
  late UpComingModel upComingModel;
  late TheatersModel theatersModel;

  Future<List<Movies>> getUpComingMovies() async {
    await http.get(Uri.parse(AppConstants.urlUpComing)).then((value) {
      upComingModel = UpComingModel.fromJson(json.decode(value.body));
    }).catchError((error) {});
    List<Movies>? moviesList = upComingModel.results!;
    return moviesList;
  }

  Future<List<MoviesResults>> getTheatersMovies() async {
    await http.get(Uri.parse(AppConstants.urlTheaters)).then((value) {
      theatersModel = TheatersModel.fromJson(json.decode(value.body));
    }).catchError((error) {});
    List<MoviesResults> moviesList = theatersModel.results!;
    return moviesList;
  }

}

class SearchApi {
  late SearchModel searchModel;

  Future<List<SearchResults>> search(query) async {
    await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=${AppConstants.apiKey1}&language=en-US&query=$query&page=1&include_adult=false#')).then((value) {
      searchModel = SearchModel.fromJson(json.decode(value.body));
      for(int i=0; i<searchModel.results!.length; i++)
        {
          print(searchModel.results![i].title);
        }
    }).catchError((error) {
      print(error.toString());
    });
    List<SearchResults> movies = searchModel.results!;
    return movies;
  }
}

class MovieApi {
  late MovieModel movieModel;
  late VideoModel videoModel;
  Future<MovieModel> getMovieDetails(movieID) async {
    await http
        .get(Uri.parse(
            'https://api.themoviedb.org/3/movie/$movieID?api_key=${AppConstants.apiKey1}&language=en-US'))
        .then((value) {
      movieModel = MovieModel.fromJson(json.decode(value.body));
    }).catchError((error) {});
    MovieModel moviesList = movieModel;
    return moviesList;
  }

  Future<String> getVideoID(movieID) async {
    await http
        .get(Uri.parse(
            'https://api.themoviedb.org/3/movie/$movieID/videos?api_key=${AppConstants.apiKey1}&language=en-US'))
        .then((value) {
      videoModel = VideoModel.fromJson(json.decode(value.body));
    }).catchError((error) {});
    String videoID = videoModel.results![0].key!;
    return videoID;
  }
}
