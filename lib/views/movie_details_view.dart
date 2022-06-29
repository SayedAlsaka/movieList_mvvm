// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';
import 'package:mvvm_demo/resources/strings_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/shared/components.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../resources/constants_manager.dart';
import '../view_model/home_view_model.dart';
import '../view_model/profile_view_model.dart';

class MovieDetailsView extends StatefulWidget {
  String id;
  dynamic movie;
  String? category;
  MovieDetailsView({Key? key, required this.movie, category, required this.id})
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
    var profileProvider = Provider.of<ProfileViewModel>(context, listen: false);
    var homeProvider = Provider.of<HomeViewModel>(context, listen: false);
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
                            '${AppStrings.imagePath}${widget.movie.posterPath}',
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppSize.s30,
                            child: ListView.separated(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => OutlinedButton(
                                      onPressed: () {},
                                      child: Text(
                                        widget.movie.genres[index].name,
                                        style: TextStyle(
                                            color: ColorManager.black),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: Colors.grey[500]!),
                                        textStyle:
                                            const TextStyle(color: Colors.red),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                      ),
                                    ),
                                separatorBuilder: (_, context) =>
                                    const SizedBox(
                                      width: AppSize.s5,
                                    ),
                                itemCount: widget.movie.genres.length),
                          ),
                          const SizedBox(
                            height: AppSize.s5,
                          ),
                          Text(
                            widget.movie.overview,
                            overflow: TextOverflow.ellipsis,
                            maxLines: AppSize.s7.toInt(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          myDivider(),
          if (widget.category == AppStrings.comingSoon)
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
                    widget.category!,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '${AppStrings.releaseDate} ${widget.movie.releaseDate}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          myDivider(),
          const SizedBox(
            height: AppSize.s10,
          ),
          if (Provider.of<ProfileViewModel>(context)
                  .model
                  .bookMarks!
                  .contains(widget.movie.id) ==
              false)
            Center(
                child: defaultButton(
                    function: () async {
                      await profileProvider.getUserData();
                      await homeProvider.updateBookMarkUser(
                          bookMarks: widget.movie.id!,
                          id: Provider.of<ProfileViewModel>(context,
                                  listen: false)
                              .model
                              .id,
                          context: context);
                    },
                    text: AppStrings.addToWatchlist,
                    textColor: Colors.black,
                    style: const TextStyle(
                        color: Colors.black, fontSize: AppSize.s18),
                    background: ColorManager.yellow,
                    width: AppConstants.filmListHeight)),
          if (Provider.of<ProfileViewModel>(context)
                  .model
                  .bookMarks!
                  .contains(widget.movie.id) ==
              true)
            Center(
                child: defaultButton(
                    function: () {},
                    text: AppStrings.addedToWatchlist,
                    textColor: Colors.black,
                    style: TextStyle(
                        color: ColorManager.white, fontSize: AppSize.s18),
                    background: ColorManager.grey,
                    width: AppConstants.filmListHeight)),
        ],
      ),
    );
  }
}
