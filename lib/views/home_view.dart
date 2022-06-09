import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';
import 'package:mvvm_demo/resources/strings_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/shared/components.dart';
import 'package:mvvm_demo/view_model/app_view_model.dart';
import 'package:mvvm_demo/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import '../resources/assets_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeViewModel>(context,listen:false);
    var appProvider = Provider.of<AppViewModel>(context,listen: false);
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
                // movie trailer
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
                cardMovie(
                    context: context,
                    title: AppStrings.comingSoon,
                    movieImage: ImageAssets.filmLogo,
                    movieName: 'Jurassic World: Dominion',
                    movieYear: '2022 PG-13',
                    ),
                cardMovie(
                    context: context,
                    title: AppStrings.inTheaters,
                    movieImage: ImageAssets.filmLogo,
                    movieName: 'Top Gun: Maverick',
                    movieYear: '2022 PG-13'),
                boxOfficeCard(
                    context: context,
                    title: AppStrings.boxOffice,
                    movieNumber: '1',
                    movieName: 'Top Gun: Maverick',
                    moviePrice: '86'),

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
