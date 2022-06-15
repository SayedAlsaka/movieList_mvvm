import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';
import 'package:mvvm_demo/resources/constants_manager.dart';
import 'package:mvvm_demo/resources/strings_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/shared/components.dart';
import 'package:mvvm_demo/view_model/app_view_model.dart';
import 'package:mvvm_demo/view_model/home_view_model.dart';
import 'package:mvvm_demo/view_model/video_view_model.dart';
import 'package:mvvm_demo/views/movie_details_view.dart';
import 'package:mvvm_demo/views/video_view.dart';
import 'package:provider/provider.dart';
import '../resources/assets_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeViewModel>(context, listen: false);
    var videoProvider= Provider.of<VideoViewModel>(context, listen: false);
    var appProvider = Provider.of<AppViewModel>(context, listen: false);
    print(provider.bookMark);
    List<String> images = [
      ImageAssets.filmLogo,
      ImageAssets.filmLogo,
      ImageAssets.filmLogo,
    ];
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: (){
            return Future.delayed(const Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 //movie trailer
                 //  CarouselSlider(
                 //    options: CarouselOptions(
                 //      height: AppConstants.carouselHeight1,
                 //      autoPlay: true,
                 //      autoPlayInterval: Duration(seconds: AppSize.s5.toInt()),
                 //      viewportFraction: AppSize.s1,
                 //      aspectRatio: AppSize.s2,
                 //      enlargeCenterPage: true,
                 //    ),
                 //    items: images//Provider.of<HomeViewModel>(context).comingSoonList
                 //        .map((item) => Align(
                 //      alignment: AlignmentDirectional.topCenter,
                 //      child: Stack(
                 //        clipBehavior: Clip.none,
                 //        alignment: AlignmentDirectional.bottomStart,
                 //        children: [
                 //          InkWell(
                 //            onTap: (){
                 //              // navigatePush(context, MovieDetailsView());
                 //              navigatePush(context, VideoView(id: "https://rr4---sn-4g5ednse.googlevideo.com/videoplayback?expire=1655140173&ei=7RqnYsHQEa-N6dsPkfmx-A8&ip=159.69.59.244&id=o-AOvcEnrqOVylhF7fmiBIyD-TfhutJKhDz5Xmuh0iOXo6&itag=18&source=youtube&requiressl=yes&mh=1C&mm=31%2C26&mn=sn-4g5ednse%2Csn-h0jeenle&ms=au%2Conr&mv=m&mvi=4&pl=24&initcwndbps=177500&vprv=1&mime=video%2Fmp4&gir=yes&clen=5016748&ratebypass=yes&dur=83.150&lmt=1416917420476214&mt=1655118306&fvip=5&fexp=24001373%2C24007246%2C24208264&c=ANDROID&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIgcs1ecuFIAK-Iyg3t2zsMOgIgWvEUrEQPVsKGyk-Zy0ACIQCwjpEwRw-l36qOsJ_N9dQ-hDljBYx0ad5h7YvCLc1wtQ%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRAIgDc4UPUCfaqQH5HjyZ7cFW-GEjKsJQRnhp0x5KcIRB6ECIDr1dwgZVK9l4TxZaHRLGzIpsjfaztbK_WA0dpfW_x9u&title=Inception+-+Official+Trailer+[HD]"));
                 //            },
                 //            child: Stack(
                 //              alignment: Alignment.center,
                 //              children: [
                 //                Container(
                 //                  height: 218.0,
                 //                  width: double.infinity,
                 //                  decoration: BoxDecoration(
                 //                    image: DecorationImage(
                 //                      image: AssetImage(
                 //                        item,
                 //                      ),
                 //                      fit: BoxFit.fill,
                 //                    ),
                 //                    borderRadius: const BorderRadius.only(
                 //                      topLeft: Radius.circular(AppSize.s4),
                 //                      topRight: Radius.circular(AppSize.s4),
                 //                    ),
                 //                  ),
                 //                ),
                 //                Container(
                 //                  decoration: const BoxDecoration(
                 //                    image: DecorationImage(
                 //                        image: AssetImage(
                 //                            ImageAssets.playVideoLogo),
                 //                        fit: BoxFit.fill),
                 //                  ),
                 //                  width: 100,
                 //                  height: 100,
                 //                ),
                 //              ],
                 //            ),
                 //          ),
                 //
                 //        if(Provider.of<HomeViewModel>(context).bookMark == false)
                 //          Positioned(
                 //            bottom:
                 //            AppConstants.bottomPosition.toDouble(),
                 //            left: AppSize.s20,
                 //            child: Stack(
                 //              children: [
                 //                Container(
                 //                  height: AppConstants.carouselHeight2,
                 //                  width: AppConstants.carouselWidth,
                 //                  decoration: BoxDecoration(
                 //                    image: DecorationImage(
                 //                      image: AssetImage(
                 //                        item,
                 //                      ),
                 //                      fit: BoxFit.cover,
                 //                    ),
                 //                  ),
                 //                ),
                 //                Positioned(
                 //                  left: -12,
                 //                  top: -5,
                 //                  child: InkWell(
                 //                    onTap: (){
                 //                      print('saka');
                 //                    },
                 //                    child: Container(
                 //                      decoration: const BoxDecoration(
                 //                        borderRadius: BorderRadius.only(
                 //                          topLeft:
                 //                          Radius.circular(AppSize.s20),
                 //                        ),
                 //                        image: DecorationImage(
                 //                            image: AssetImage(
                 //                                ImageAssets.bookmarkLogo),
                 //                            fit: BoxFit.fill),
                 //                      ),
                 //                      width: 60,
                 //                      height: 50,
                 //                    ),
                 //                  ),
                 //                ),
                 //              ],
                 //            ),
                 //          ),
                 //        if(Provider.of<HomeViewModel>(context).bookMark == true)
                 //          Positioned(
                 //            bottom:
                 //            AppConstants.bottomPosition.toDouble(),
                 //            left: AppSize.s20,
                 //            child: Stack(
                 //              children: [
                 //                Container(
                 //                  height: AppConstants.carouselHeight2,
                 //                  width: AppConstants.carouselWidth,
                 //                  decoration: BoxDecoration(
                 //                    image: DecorationImage(
                 //                      image: AssetImage(
                 //                        item,
                 //                      ),
                 //                      fit: BoxFit.cover,
                 //                    ),
                 //                  ),
                 //                ),
                 //                Positioned(
                 //                  left: -12,
                 //                  top: -5,
                 //                  child: InkWell(
                 //                    onTap: (){
                 //                    },
                 //                    child: Container(
                 //                      decoration: const BoxDecoration(
                 //                        color: Colors.grey,
                 //                        borderRadius: BorderRadius.only(
                 //                          topLeft:
                 //                          Radius.circular(AppSize.s20),
                 //                        ),
                 //                        image: DecorationImage(
                 //                            image: AssetImage(
                 //                                ImageAssets.bookmarkDoneLogo),
                 //                            fit: BoxFit.fill,
                 //                        ),
                 //                      ),
                 //                      width: 60,
                 //                      height: 50,
                 //                    ),
                 //                  ),
                 //                ),
                 //              ],
                 //            ),
                 //          ),
                 //
                 //        ],
                 //      ),
                 //    ))
                 //        .toList(),
                 //  ),
                  FutureBuilder(
                    future: provider.getComingSoonMovies(),
                      builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.done)
                        {
                          return CarouselSlider(
                            options: CarouselOptions(
                              height: AppConstants.carouselHeight1,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: AppSize.s5.toInt()),
                              viewportFraction: AppSize.s1,
                              aspectRatio: AppSize.s2,
                              enlargeCenterPage: true,
                            ),
                            items: Provider.of<HomeViewModel>(context).comingSoonList
                                .map((item) => Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  InkWell(
                                    onTap: ()async{
                                        await videoProvider.getVideoUrl(item.id);
                                        navigatePush(context, MovieDetailsView(movie: item, category: 'Coming soon', id: Provider.of<VideoViewModel>(context,listen: false).videoUrl));
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 218.0,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                item.image!,
                                              ),
                                              fit: BoxFit.fill,
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
                                              image: NetworkImage(
                                                item.image!,
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
                          );
                        }
                      else
                        {
                          return SizedBox(
                            height: AppConstants.carouselHeight1,
                            child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorManager.yellow,
                                )),
                          );
                        }

                      },

                  ),
                  FutureBuilder(
                   future: provider.getComingSoonMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return cardMovie(
                          context: context,
                          cardTitle: AppStrings.comingSoon,
                          movies:
                              Provider.of<HomeViewModel>(context).comingSoonList,
                        );
                      } else {
                        return SizedBox(
                          height: AppConstants.carouselHeight1,
                          child: Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.yellow,
                              )),
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: provider.getInTheatersMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return cardMovie(
                          context: context,
                          cardTitle: AppStrings.inTheaters,
                          movies:
                              Provider.of<HomeViewModel>(context).inTheaterList,
                        );
                      } else {
                        return SizedBox(
                          height: AppConstants.carouselHeight1,
                          child: Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.yellow,
                              )),
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: provider.getBoxOfficeMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return   boxOfficeCard(
                            context: context,
                            cardTitle: AppStrings.boxOffice,
                            movies: Provider.of<HomeViewModel>(context).boxOfficeList
                        );
                      } else {
                        return SizedBox(
                          height: AppConstants.carouselHeight1,
                          child: Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.yellow,
                              )),
                        );
                      }
                    },
                  ),

                  const SizedBox(
                    height: 10.0,
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
