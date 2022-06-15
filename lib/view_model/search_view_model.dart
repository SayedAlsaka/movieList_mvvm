import 'package:flutter/material.dart';
import 'package:mvvm_demo/services/api.dart';

import '../models/search_model.dart';

class SearchViewModel extends ChangeNotifier {

List<Results> resultsList=[];

Future<void> search(expression) async
{
 resultsList= await SearchApi().search(expression) as List<Results>;
 notifyListeners();
}
}