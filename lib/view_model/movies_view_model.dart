
import 'package:flutter/material.dart';
import 'package:mvvm_demo/models/movie_model.dart';
import 'package:mvvm_demo/services/api.dart';

class MoviesViewModel extends ChangeNotifier
{
List<MovieItemsModel> _moviesList =[];
late String _videoId ;


Future<void>getTopMovies() async
{
  _moviesList = await MoviesApi().getTopMovies();
  notifyListeners();
}


Future<void>getTopMoviesVideoId(index) async
{
  _videoId = await MoviesApi().getTopMoviesVideoId(index);
  notifyListeners();
}


  String get videoId => _videoId;

  List<MovieItemsModel> get moviesList => _moviesList;
}