import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/models/user_model.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';
import 'package:mvvm_demo/shared/network/local/cash_helper.dart';

import '../models/movie_model.dart';
import '../services/api.dart';

class ProfileViewModel extends ChangeNotifier {
  late UserModel model ;
  late MovieModel movieModel;
   List<MovieModel> watchList = [];
  Future<void>getWatchList(moviesID) async
  {
    watchList = [];
    for(int i=0; i<moviesID.length; i++) {
      movieModel = await MovieApi().getMovieDetails(moviesID[i]);
      watchList.add(movieModel);
    }
    notifyListeners();
  }
  Future<void> getUserData() async {
    AppConstants.uId = CashHelper.getData(key: 'uId');
    await FirebaseFirestore.instance
        .collection(AppConstants.userCollection)
        .doc(AppConstants.uId)
        .get()
        .then((value) {
      model = UserModel.fromJson(value.data()!);
      notifyListeners();
    }).catchError((error) {
    });
  }
}
