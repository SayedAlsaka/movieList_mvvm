import 'dart:convert';

import 'package:mvvm_demo/models/box_office_model.dart';
import 'package:mvvm_demo/models/coming_soon_model.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_demo/models/in_theaters_model.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';


class HomeApi {

   late ComingSoonModel comingSoonModel;
   late InTheatersModel inTheatersModel;
   late BoxOfficeModel boxOfficeModel;
  Future<List<ItemsC>> getComingSoonMovies() async {
    await http.get(Uri.parse(AppConstants.urlComingSoon)).then((value) {
      comingSoonModel = ComingSoonModel.fromJson(json.decode(value.body));
      print(comingSoonModel.items![0].title);
    }).catchError((error) {
      print(error.toString());
    });
    List<ItemsC> moviesList = comingSoonModel.items!;
    return moviesList;
  }

   Future<List<ItemsT>> getInTheatersMovies() async {
     await http.get(Uri.parse(AppConstants.urlInTheaters)).then((value) {
       inTheatersModel = InTheatersModel.fromJson(json.decode(value.body));
       print(inTheatersModel.items![0].title);
     }).catchError((error) {
       print(error.toString());
     });
     List<ItemsT> moviesList = inTheatersModel.items!;
     return moviesList;
   }

   Future<List<Items>> getBoxOfficeMovies() async {
     await http.get(Uri.parse(AppConstants.urlTopRatedMovies)).then((value) {
       boxOfficeModel = BoxOfficeModel.fromJson(json.decode(value.body));
       print(boxOfficeModel.items![0].title);
     }).catchError((error) {
       print(error.toString());
     });
     List<Items> moviesList = boxOfficeModel.items!;
     return moviesList;
   }



}
