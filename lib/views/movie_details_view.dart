// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/shared/components.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../resources/constants_manager.dart';
import '../view_model/profile_view_model.dart';

class MovieDetailsView extends StatefulWidget {
  String id;
  dynamic movie;
  String category;
  MovieDetailsView(
      {Key? key, required this.movie, required this.category, required this.id})
      : super(key: key);

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(initialVideoId: widget.id);
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileViewModel>(context,listen: false);
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
                  widget.movie.releaseDate,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppConstants.homeCarouselCoverHeight,
            child: YoutubePlayerBuilder(
              builder: (context, player) => ListView(
                children: [
                  player,
                ],
              ),
              player: YoutubePlayer(
                controller: _controller,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppConstants.movieDetailsHeight,
                      width: AppConstants.carouselWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://image.tmdb.org/t/p/w780${widget.movie.posterPath}',
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
                                itemBuilder: (context, index) => defaultButton(
                                    background:
                                        Theme.of(context).backgroundColor,
                                    style:
                                        Theme.of(context).textTheme.subtitle1!,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!,
                                    width: 105,
                                    shape: Border.all(color: Colors.grey),
                                    function: () {},
                                    text: widget.movie.genres[index].name),
                                separatorBuilder: (_, context) =>
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                itemCount: widget.movie.genres.length),
                          ),
                          const SizedBox(
                            height: AppSize.s5,
                          ),
                          Text(
                            widget.movie.overview,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                          ),
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
                    'Release Date ${widget.movie.releaseDate}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          myDivider(),
          const SizedBox(
            height: AppSize.s10,
          ),
        if(profileProvider.model.bookMarks!.contains(widget.movie.id) == false)
          Center(
              child: defaultButton(
                  function: () {},
                  text: '+ Add to Watchlist',
                  textColor: Colors.black,
                  style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  background: ColorManager.yellow,
                  width: 350)),
        ],
      ),
    );
  }
}
