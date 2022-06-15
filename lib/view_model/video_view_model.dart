import 'package:flutter/material.dart';
import 'package:mvvm_demo/services/api.dart';

class VideoViewModel extends ChangeNotifier
{
   late String videoID;
   late String videoUrl;
  Future<void> getVideoId(movieID) async
  {
     videoID= (await HomeApi().getVideoId(movieID))!;
     notifyListeners();
  }
   Future<void> getVideoUrl(movieID) async
   {
     videoUrl= (await HomeApi().getVideoUrl(movieID))!;
     notifyListeners();
   }

}