import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/models/theaters_model.dart';
import 'package:mvvm_demo/services/api.dart';
import 'package:mvvm_demo/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../models/up_coming_model.dart';
import '../resources/constants_manager.dart';

class HomeViewModel extends ChangeNotifier {
  List<Movies> upComingList = [];
  List<MoviesResults> theaterList = [];
  List<MovieModel> watchList = [];
  bool bookMark = false;

  Future<void> getUpComingMovies() async {
    upComingList = await HomeApi().getUpComingMovies();
    notifyListeners();
  }

  Future<void> getTheatersMovies() async {
    theaterList = await HomeApi().getTheatersMovies();
    notifyListeners();
  }

  void addToBookMark() {}

  void removeFromBookMark() {}

  Future<void> updateBookMarkUser({
    required bookMarks,
    required id,
    required context,
  }) async {
    List<dynamic> x = [];
    x.add(bookMarks);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'bookMarks': FieldValue.arrayUnion(x)}).then((value) {
      Provider.of<ProfileViewModel>(context, listen: false).getUserData();
      bookMark = true;
    }).catchError((error) {});
    notifyListeners();
  }

  Future<void> removeBookMarkUser({
    required bookMarks,
    required id,
    required context,
  }) async {
    var data = await FirebaseFirestore.instance
        .collection(AppConstants.userCollection)
        .doc(id)
        .get();
    data.data()!['bookMarks'].forEach((item) {
      if (item == bookMarks) {
        List<dynamic> x = [];
        x.add(item);
        FirebaseFirestore.instance
            .collection(AppConstants.userCollection)
            .doc(id)
            .update({'bookMarks': FieldValue.arrayRemove(x)}).then((value) {
          Provider.of<ProfileViewModel>(context, listen: false).getUserData();
          bookMark = false;
        }).catchError((error) {});
      }
    });
    notifyListeners();
  }
}
