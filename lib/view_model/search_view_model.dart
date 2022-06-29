import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';
import 'package:mvvm_demo/services/api.dart';
import 'package:mvvm_demo/shared/network/local/cash_helper.dart';
import '../models/search_model.dart';

class SearchViewModel extends ChangeNotifier {
  List<SearchResults> resultsList = [];
  List<SearchResults> recentSearchHistory = [];
  Future<void> search(query) async {
    resultsList = await SearchApi().search(query);
    notifyListeners();
  }

  void setSearchHistory(movie) {
    getSearchHistory();
    if (recentSearchHistory.isEmpty) {
      recentSearchHistory = [];
    }
    bool? isExist = false;
    if (recentSearchHistory.isEmpty) {
      recentSearchHistory.add(movie);
      notifyListeners();
    } else {
      for (int i = 0; i < recentSearchHistory.length; i++) {
        if (movie.id == recentSearchHistory[i].id) {
          isExist = true;
        }
      }
      if (isExist == false) {
        recentSearchHistory.add(movie);
        notifyListeners();
      }
    }
    saveSearchHistory(recentSearchHistory);
    notifyListeners();
  }

  void saveSearchHistory(recentSearchHistory) {
    String recentSearchMovies = encode(recentSearchHistory);
    CashHelper.saveData(
        key: AppConstants.recentSearches, value: recentSearchMovies);
    notifyListeners();
  }

  List<SearchResults>? getSearchHistory() {
    var a = CashHelper.getData(key: AppConstants.recentSearches);
    if (a != null) {
      recentSearchHistory = decode(a);
      return recentSearchHistory;
    }
    notifyListeners();
    return null;
  }

  void clearSearchHistory() {
    CashHelper.removeData(key: AppConstants.recentSearches).then((value) {
      recentSearchHistory.clear();
      notifyListeners();
    });
  }

  String encode(List<SearchResults> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>((movie) => SearchResults.toMap(movie))
            .toList(),
      );

  List<SearchResults> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<SearchResults>((item) => SearchResults.fromJson(item))
          .toList();
}
