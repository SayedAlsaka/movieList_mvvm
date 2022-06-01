import 'package:flutter/cupertino.dart';
import 'package:mvvm_demo/services/api.dart';

class VideoViewModel extends ChangeNotifier {
  late String _videoURL;
  Future<void> getTopMoviesVideoUrl(id) async {
    _videoURL = await MoviesApi().getTopMoviesVideo(id);
    notifyListeners();
  }

  String get videoURL => _videoURL;
}
