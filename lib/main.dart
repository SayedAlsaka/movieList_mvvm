import 'package:flutter/material.dart';
import 'package:mvvm_demo/shared/styles/themes.dart';
import 'package:mvvm_demo/view_model/movies_view_model.dart';
import 'package:mvvm_demo/views/movies_view.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesViewModel()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const MoviesView(),
      ),
    );
  }
  
}



