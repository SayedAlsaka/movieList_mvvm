import 'dart:convert';
import 'package:mvvm_demo/models/box_office_model.dart';
import 'package:mvvm_demo/models/coming_soon_model.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_demo/models/in_theaters_model.dart';
import 'package:mvvm_demo/models/search_model.dart';
import 'package:mvvm_demo/models/trailer.dart';
import 'package:mvvm_demo/models/youtube_trailer.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';

class HomeApi {
  late ComingSoonModel comingSoonModel;
  late InTheatersModel inTheatersModel;
  late BoxOfficeModel boxOfficeModel;
  late YoutubeTrailer youtubeTrailer;
  late Trailer trailer;
  Future<List<ItemsC>> getComingSoonMovies() async {
    await http.get(Uri.parse(AppConstants.urlComingSoon)).then((value) {
      comingSoonModel = ComingSoonModel.fromJson(json.decode(value.body));
    }).catchError((error) {

    });
    List<ItemsC> moviesList = comingSoonModel.items!;
    return moviesList;
  }

  Future<List<ItemsT>> getInTheatersMovies() async {
    await http.get(Uri.parse(AppConstants.urlInTheaters)).then((value) {
      inTheatersModel = InTheatersModel.fromJson(json.decode(value.body));

    }).catchError((error) {

    });
    List<ItemsT> moviesList = inTheatersModel.items!;
    return moviesList;
  }

  Future<List<Items>> getBoxOfficeMovies() async {
    await http.get(Uri.parse(AppConstants.urlTopRatedMovies)).then((value) {
      boxOfficeModel = BoxOfficeModel.fromJson(json.decode(value.body));

    }).catchError((error) {

    });
    List<Items> moviesList = boxOfficeModel.items!;
    return moviesList;
  }

  Future<String?> getVideoId(movieID) async {
    await http.get(Uri.parse(AppConstants.urlVideoId + movieID)).then((value) {
      youtubeTrailer = YoutubeTrailer.fromJson(json.decode(value.body));
    }).catchError((error) {

    });
    return youtubeTrailer.videoId;
  }

  Future<String?> getVideoUrl(movieID) async {
    await getVideoId(movieID);
    await http
        .get(Uri.parse(AppConstants.urlVideoUrl + youtubeTrailer.videoId!))
        .then((value) {
      trailer = Trailer.fromJson(json.decode(value.body));
    }).catchError((error) {

    });
    return trailer.videos![1].url;
  }
}

class SearchApi {
  SearchModel? searchModel;
   List<Results> movies =[];
   Future<List<Results>?> search(String query) async {
   await http.get(Uri.parse(AppConstants.urlSearch+query)).then((value) {
     searchModel = SearchModel.fromJson(json.decode(value.body));
       for (int i=0; i<searchModel!.results!.length; i++)
       {
         if(searchModel!.results![i].image !='') {
           movies.add(searchModel!.results![i]);
         }
       }
       movies = movies.where((element) => element.title!.toLowerCase().contains(query.toLowerCase())).toList();

   }).catchError((error){

   });
   return movies;
  }
}
