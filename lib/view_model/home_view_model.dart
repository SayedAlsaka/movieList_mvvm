
import 'package:flutter/material.dart';

import 'package:mvvm_demo/services/api.dart';

import '../models/coming_soon_model.dart';

class HomeViewModel extends ChangeNotifier
{
List<Items> comingSoonList =[];

Future<void>getComingSoonMovies() async
{
  comingSoonList = await HomeApi().getComingSoonMovies();
  notifyListeners();
}

}