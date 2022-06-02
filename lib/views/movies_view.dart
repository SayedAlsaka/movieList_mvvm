import 'package:flutter/material.dart';
import 'package:mvvm_demo/view_model/movies_view_model.dart';
import 'package:mvvm_demo/views/video_view.dart';
import 'package:provider/provider.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MoviesViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Center(child:  Text('Top 250 Movies')),),
      body: Center(
        child: FutureBuilder(
            future: provider.getTopMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () async{
                                await provider.getTopMoviesVideoId(index);
                                await provider.getTopMoviesVideoUrl(provider.videoId);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoView(id: provider.videoURL),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Image.network(
                                          provider.moviesList[index].image),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '${provider.moviesList[index].rank}. ${provider.moviesList[index].fullTitle}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'IMDb Rating ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  provider.moviesList[index]
                                                      .iMDPRating,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                            height: 10,
                          ),
                      itemCount: provider.moviesList.length),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
