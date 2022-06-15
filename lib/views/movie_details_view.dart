// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/shared/components.dart';
import 'package:video_player/video_player.dart';
import '../resources/assets_manager.dart';
import '../resources/constants_manager.dart';

class MovieDetailsView extends StatefulWidget {
  String id;
  dynamic movie;
  String category;
  MovieDetailsView({Key? key, required this.movie, required this.category,required this.id})
      : super(key: key);

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}


class _MovieDetailsViewState extends State<MovieDetailsView> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  double opacity=1.0;
  @override
  void initState() {
    print(widget.id);
    _controller = VideoPlayerController.network(widget.id);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s1,
        title: Text(
          widget.movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: AppPadding.p20,
                top: AppPadding.p20,
                right: AppPadding.p20,
                bottom: AppPadding.p10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: AppSize.s5,
                ),
                Text(
                  '${widget.movie.year} ${widget.movie.contentRating} ${widget.movie.runtimeStr}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      InkWell(
                          onTap: (){
                            setState(() {
                              opacity=1.0;
                              Future.delayed(const Duration(seconds: 3)).then((value) {
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    opacity=0.0;
                                  } else {
                                    opacity=1.0;
                                  }
                                });
                              });
                            });

                          },
                          child: VideoPlayer(_controller)),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                              opacity=1.0;
                            } else {
                              _controller.play();
                              opacity=0.0;
                            }
                          });
                        },
                        child: Opacity(opacity: opacity,
                            child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow , color: Colors.white,size: 70.0,)),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppConstants.carouselHeight2 + 20,
                      width: AppConstants.carouselWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.movie.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 30,
                            child: ListView.separated(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index)=> defaultButton(
                                    background: Theme.of(context).backgroundColor,
                                    style: Theme.of(context).textTheme.subtitle1!,
                                    textColor: Theme.of(context).textTheme.bodyText1!.color!,
                                    width: 105,
                                    shape: Border.all(
                                        color: Colors.grey
                                    ),
                                    function: () {
                                    },
                                    text:widget.movie.genreList[index].value),
                                separatorBuilder: (_,context) => const SizedBox(width: 5.0,),
                                itemCount: widget.movie.genreList.length),
                          ),
                          const SizedBox(height: AppSize.s5,),
                          Text(widget.movie.plot,overflow: TextOverflow.ellipsis,maxLines: 7,),
                        ],
                      ),
                    ),
                    //Text(movie.plot),
                  ],
                ),
              ],
            ),
          ),
          myDivider(),
          if (widget.category == 'Coming soon')
            Padding(
              padding: const EdgeInsets.only(
                  bottom: AppPadding.p10,
                  left: AppPadding.p20,
                  right: AppPadding.p20,
                  top: AppPadding.p10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    'Release Date ${widget.movie.releaseState}, ${widget.movie.year}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          myDivider(),
          const SizedBox(
            height: 10.0,
          ),
          Center(
              child: defaultButton(
                  function: () {},
                  text: '+ Add to Watchlist',
                  textColor: Colors.black,
                  style: const TextStyle(color: Colors.black , fontSize: 18.0),
                  background: ColorManager.yellow,
                  width: 350)),
        ],
      ),
    );
  }
}
