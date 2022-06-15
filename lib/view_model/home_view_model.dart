
import 'package:flutter/material.dart';

import 'package:mvvm_demo/services/api.dart';

import '../models/box_office_model.dart';
import '../models/coming_soon_model.dart';
import '../models/in_theaters_model.dart';

class HomeViewModel extends ChangeNotifier
{
List<ItemsC> comingSoonList =[];
List<ItemsT> inTheaterList =[];
List<Items> boxOfficeList =[];
bool bookMark = false;

Future<void>getComingSoonMovies() async
{
  comingSoonList = await HomeApi().getComingSoonMovies();
  notifyListeners();
}
Future<void>getInTheatersMovies() async
{
  inTheaterList = await HomeApi().getInTheatersMovies();
  notifyListeners();
}
Future<void>getBoxOfficeMovies() async
{
  boxOfficeList = await HomeApi().getBoxOfficeMovies();
  notifyListeners();
}

void addToBookMark()
{
  bookMark=true;
  notifyListeners();
}



}