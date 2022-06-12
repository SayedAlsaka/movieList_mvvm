import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';
import 'package:mvvm_demo/resources/strings_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/shared/components.dart';
import 'package:mvvm_demo/view_model/app_view_model.dart';
import 'package:mvvm_demo/view_model/home_view_model.dart';
import 'package:mvvm_demo/views/movie_details_view.dart';
import 'package:mvvm_demo/views/video_view.dart';
import 'package:provider/provider.dart';
import '../resources/assets_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeViewModel>(context, listen: false);
    var appProvider = Provider.of<AppViewModel>(context, listen: false);
    List<String> images = [
      ImageAssets.filmLogo,
      ImageAssets.filmLogo,
      ImageAssets.filmLogo,
    ];
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //movie trailer
                CarouselSlider(
                  options: CarouselOptions(
                    height: AppConstants.carouselHeight1,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: AppSize.s5.toInt()),
                    viewportFraction: AppSize.s1,
                    aspectRatio: AppSize.s2,
                    enlargeCenterPage: true,
                  ),
                  items: images
                      .map((item) => Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                InkWell(
                                  onTap: (){
                                    navigatePush(context, MovieDetailsView());
                                    //navigatePush(context, VideoView(id: 'https://imdb-api.com/APIYouTube?apiKey=k_2eqt4crl&v=https://www.youtube.com/watch?v=8hP9D6kZseM'));
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 218.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              item,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(AppSize.s4),
                                            topRight: Radius.circular(AppSize.s4),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          // borderRadius: BorderRadius.only(
                                          //   topLeft:
                                          //   Radius.circular(AppSize.s20),
                                          // ),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  ImageAssets.playVideoLogo),
                                              fit: BoxFit.fill),
                                        ),
                                        width: 100,
                                        height: 100,
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom:
                                      AppConstants.bottomPosition.toDouble(),
                                  left: AppSize.s20,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: AppConstants.carouselHeight2,
                                        width: AppConstants.carouselWidth,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              item,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: -12,
                                        top: -5,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(AppSize.s20),
                                            ),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    ImageAssets.bookmarkLogo),
                                                fit: BoxFit.fill),
                                          ),
                                          width: 60,
                                          height: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                // FutureBuilder(
                //   future: provider.getComingSoonMovies(),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.done) {
                //       return cardMovie(
                //         context: context,
                //         cardTitle: AppStrings.comingSoon,
                //         movies:
                //             Provider.of<HomeViewModel>(context).comingSoonList,
                //       );
                //     } else {
                //       return Center(
                //           child: CircularProgressIndicator(
                //         color: ColorManager.yellow,
                //       ));
                //     }
                //   },
                // ),
                // FutureBuilder(
                //   future: provider.getInTheatersMovies(),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.done) {
                //       return cardMovie(
                //         context: context,
                //         cardTitle: AppStrings.inTheaters,
                //         movies:
                //             Provider.of<HomeViewModel>(context).inTheaterList,
                //       );
                //     } else {
                //       return Center(
                //           child: CircularProgressIndicator(
                //         color: ColorManager.yellow,
                //       ));
                //     }
                //   },
                // ),
                // FutureBuilder(
                //   future: provider.getBoxOfficeMovies(),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.done) {
                //       return   boxOfficeCard(
                //           context: context,
                //           cardTitle: AppStrings.boxOffice,
                //           movies: Provider.of<HomeViewModel>(context).boxOfficeList
                //       );
                //     } else {
                //       return Center(
                //           child: CircularProgressIndicator(
                //             color: ColorManager.yellow,
                //           ));
                //     }
                //   },
                // ),

                const SizedBox(
                  height: 10.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
