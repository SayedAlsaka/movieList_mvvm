import 'package:flutter/material.dart';
import 'package:mvvm_demo/models/movie_model.dart';

import '../services/api.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  late MovieModel movieModel;
  late String videoID;
  Future<void> getMovieDetails(movieID) async {
    movieModel = await MovieApi().getMovieDetails(movieID);
    notifyListeners();
  }

  Future<void> getVideoID(movieID) async {
    videoID = await MovieApi().getVideoID(movieID);
    notifyListeners();
  }
}
