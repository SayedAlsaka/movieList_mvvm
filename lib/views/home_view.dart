import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';
import 'package:mvvm_demo/resources/strings_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/shared/components.dart';
import 'package:mvvm_demo/view_model/home_view_model.dart';
import 'package:mvvm_demo/view_model/movie_details_view_model.dart';
import 'package:mvvm_demo/view_model/profile_view_model.dart';
import 'package:mvvm_demo/views/movie_details_view.dart';
import 'package:provider/provider.dart';
import '../resources/assets_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeViewModel>(context, listen: false);
    var movieProvider =
        Provider.of<MovieDetailsViewModel>(context, listen: false);
    var profileProvider = Provider.of<ProfileViewModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            provider.getUpComingMovies();
            provider.getTheatersMovies();
            return Future.delayed(const Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: provider.getUpComingMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: AppConstants.homeCarouselContainerHeight,
                            autoPlay: true,
                            autoPlayInterval:
                                Duration(seconds: AppSize.s5.toInt()),
                            viewportFraction: AppSize.s1,
                            aspectRatio: AppSize.s2,
                            enlargeCenterPage: true,
                          ),
                          items: Provider.of<HomeViewModel>(context)
                              .upComingList
                              .map((item) => Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await movieProvider
                                                .getMovieDetails(item.id);
                                            await movieProvider
                                                .getVideoID(item.id);
                                            navigatePush(
                                                context,
                                                MovieDetailsView(
                                                    movie: movieProvider
                                                        .movieModel,
                                                    category:
                                                        AppStrings.comingSoon,
                                                    id: movieProvider.videoID));
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                height: AppConstants
                                                    .homeCarouselCoverHeight,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      'https://image.tmdb.org/t/p/w780${item.backdropPath}',
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        AppSize.s4),
                                                    topRight: Radius.circular(
                                                        AppSize.s4),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          ImageAssets
                                                              .playVideoLogo),
                                                      fit: BoxFit.fill),
                                                ),
                                                width: AppSize.s100,
                                                height: AppSize.s100,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: AppConstants.bottomPosition
                                              .toDouble(),
                                          left: AppSize.s20,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: AppConstants
                                                    .movieDetailsHeight,
                                                width:
                                                    AppConstants.carouselWidth,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      'https://image.tmdb.org/t/p/w780${item.posterPath}',
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              if (profileProvider
                                                  .model.bookMarks!.isEmpty)
                                                bookMarkLogoAdd(
                                                    profileProvider:
                                                        profileProvider,
                                                    provider: provider,
                                                    item: item,
                                                    context: context),
                                              if (Provider.of<ProfileViewModel>(
                                                          context)
                                                      .model
                                                      .bookMarks!
                                                      .isNotEmpty &&
                                                  Provider.of<ProfileViewModel>(
                                                              context)
                                                          .model
                                                          .bookMarks!
                                                          .contains(item.id) ==
                                                      false)
                                                bookMarkLogoAdd(
                                                    profileProvider:
                                                        profileProvider,
                                                    provider: provider,
                                                    item: item,
                                                    context: context),
                                              if (Provider.of<ProfileViewModel>(
                                                          context)
                                                      .model
                                                      .bookMarks!
                                                      .isNotEmpty &&
                                                  Provider.of<ProfileViewModel>(
                                                              context)
                                                          .model
                                                          .bookMarks!
                                                          .contains(item.id) ==
                                                      true)
                                                bookMarkLogoRemove(
                                                    profileProvider:
                                                        profileProvider,
                                                    provider: provider,
                                                    item: item,
                                                    context: context),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        );
                      } else {
                        return SizedBox(
                          child: Center(
                              child: CircularProgressIndicator(
                            color: ColorManager.yellow,
                          )),
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: provider.getUpComingMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return cardMovie(
                          homeProvider: provider,
                          profileProvider: profileProvider,
                          context: context,
                          cardTitle: AppStrings.comingSoon,
                          movies:
                              Provider.of<HomeViewModel>(context).upComingList,
                        );
                      } else {
                        return SizedBox(
                          height: AppConstants.cardHeight,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: ColorManager.yellow,
                          )),
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: provider.getTheatersMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return cardMovie(
                          homeProvider: provider,
                          profileProvider: profileProvider,
                          context: context,
                          cardTitle: AppStrings.inTheaters,
                          movies:
                              Provider.of<HomeViewModel>(context).theaterList,
                        );
                      } else {
                        return SizedBox(
                          child: Center(
                              child: CircularProgressIndicator(
                            color: ColorManager.yellow,
                          )),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
