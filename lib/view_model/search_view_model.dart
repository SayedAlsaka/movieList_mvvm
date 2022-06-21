import 'package:flutter/material.dart';
import 'package:mvvm_demo/services/api.dart';

import '../models/search_model.dart';

class SearchViewModel extends ChangeNotifier {

List<SearchResults> resultsList=[];

Future<void> search(query) async
{
 await SearchApi().search(query);
 notifyListeners();
}
}