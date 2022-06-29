import 'package:flutter/material.dart';

class AppConstants {
  static const apiKey1 = '6b79cd1c98a3886c36ed5469db42672c';
  static const urlUpComing =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey1&language=en-US&page=1';
  static const urlTheaters =
      'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey1&language=en-US&page=1';
  static const urlSearch =
      'https://api.themoviedb.org/3/search/movie?api_key=$apiKey1&language=en-US&query=Avengers&page=1&include_adult=false#';
  static const userCollection = 'users';
  static const recentSearches = 'Recent Searches';
  static const homeCarouselContainerHeight = 280.0;
  static const homeCarouselCoverHeight = 220.0;
  static const positionLeft = -13;
  static const positionTop = -8;
  static const bottomPosition = -50;
  static const movieDetailsHeight = 160.0;
  static const settingButtonWidth = 235.0;
  static const carouselWidth = 100.0;
  static const cardHeight = 420.0;
  static const filmListHeight = 350.0;
  static bool? isDark;
  static String? uId;
  static late Widget widget;
}
