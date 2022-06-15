import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm_demo/services/api.dart';
import 'package:mvvm_demo/view_model/search_view_model.dart';
import 'package:mvvm_demo/views/search_widget.dart';
import 'package:provider/provider.dart';

import '../models/search_model.dart';
import '../resources/colors_manager.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Results> movies=[];
  String query = '';
  Timer? debouncer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children:<Widget>[
          buildSearch(),
          if(query !='')
            FutureBuilder(
            future: Provider.of<SearchViewModel>(context,listen: false).search(query),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done)
              {
                return Expanded(
                  child: ListView.builder(
                    itemCount: Provider.of<SearchViewModel>(context).resultsList.length,
                    itemBuilder: (context, index) {
                      return buildBook(Provider.of<SearchViewModel>(context).resultsList[index]);
                    },
                  ),
                );
              }
              else
              {
                return const Center(child: CircularProgressIndicator());
              }
            },

          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Movie or Series Name',
    onChanged: searchBook,
  );
  Future searchBook(String query) async {
    final movies = await SearchApi().search(query);

    setState(() {
      this.query = query;
      this.movies = movies!;
    });
  }
  Widget buildBook(Results movie) => ListTile(
    leading: Image.network(
      movie.image!,
      fit: BoxFit.cover,
      width: 50,
      height: 80,
    ),
    title: Text(movie.title!),
    subtitle: Text(movie.description!,style: TextStyle(color: ColorManager.grey ),),
  );
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:mvvm_demo/views/search_widget.dart';
//
// import '../models/model.dart';
// import '../services/book_api.dart';
//
// class SearchView extends StatefulWidget {
//   @override
//   SearchViewState createState() => SearchViewState();
// }
//
// class SearchViewState extends State<SearchView> {
//   List<Book> books = [];
//   String query = '';
//   Timer? debouncer;
//
//   @override
//   void initState() {
//     super.initState();
//
//     init();
//   }
//
//   @override
//   void dispose() {
//     debouncer?.cancel();
//     super.dispose();
//   }
//
//   void debounce(
//       VoidCallback callback, {
//         Duration duration = const Duration(milliseconds: 1000),
//       }) {
//     if (debouncer != null) {
//       debouncer!.cancel();
//     }
//
//     debouncer = Timer(duration, callback);
//   }
//
//   Future init() async {
//     final books = await BooksApi.getBooks(query);
//
//     setState(() => this.books = books);
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: Column(
//       children: <Widget>[
//         buildSearch(),
//         if(query !='')
//           Expanded(
//           child: ListView.builder(
//             itemCount: books.length,
//             itemBuilder: (context, index) {
//               final book = books[index];
//
//               return buildBook(book);
//             },
//           ),
//         ),
//       ],
//     ),
//   );
//
//   Widget buildSearch() => SearchWidget(
//     text: query,
//     hintText: 'Title or Author Name',
//     onChanged: searchBook,
//   );
//
//   Future searchBook(String query) async => debounce(() async {
//     final books = await BooksApi.getBooks(query);
//
//     if (!mounted) return;
//
//     setState(() {
//       this.query = query;
//       this.books = books;
//     });
//   });
//
//   Widget buildBook(Book book) => ListTile(
//     leading: Image.network(
//       book.urlImage,
//       fit: BoxFit.cover,
//       width: 50,
//       height: 50,
//     ),
//     title: Text(book.title),
//     subtitle: Text(book.author),
//   );
// }