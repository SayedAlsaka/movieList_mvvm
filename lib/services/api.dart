import 'dart:convert';

import 'package:mvvm_demo/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_demo/models/video_model.dart';
import 'package:mvvm_demo/models/youtube_model.dart';

import '../shared/network/end_points.dart';

class MoviesApi {
  late MovieModel movieModel;
  late YoutubeModel youtubeModel;
  late VideoModel videoModel;
  Future<List<MovieItemsModel>> getTopMovies() async {
    await http.get(Uri.parse(url)).then((value) {
      movieModel = MovieModel.fromJson(json.decode(value.body));
    }).catchError((error) {
      print(error.toString());
    });
    List<MovieItemsModel> moviesList = movieModel.movie!;
    return moviesList;
  }

  Future<String> getTopMoviesVideoId(index) async {
   await  getTopMovies();
     await http.get(Uri.parse(youtubeUrl+movieModel.movie![index].id)).then((value) {
      youtubeModel = YoutubeModel.fromJson(json.decode(value.body));
    }).catchError((error) {
    });
    String videoId = youtubeModel.videoId!;

    return videoId;
  }

  Future<String> getTopMoviesVideo(id) async {
    await http.get(Uri.parse(videoUrl+id)).then((value) {
      videoModel = VideoModel.fromJson(json.decode(value.body));
    }).catchError((error) {
    });
    String videoURL = videoModel.videos![0].url!;

    return videoURL;
  }
}
