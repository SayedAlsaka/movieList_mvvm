import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';
import 'package:mvvm_demo/resources/values_manager.dart';
import 'package:mvvm_demo/shared/components.dart';

import '../resources/assets_manager.dart';
import '../resources/constants_manager.dart';

class MovieDetailsView extends StatelessWidget {
  MovieDetailsView({Key? key}) : super(key: key);
  List<String> images = [
    ImageAssets.filmLogo,
    ImageAssets.filmLogo,
    ImageAssets.filmLogo,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s1,
        title: const Text('movie title'),
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
                  'Lightyear',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: AppSize.s5,
                ),
                Text(
                  '2022 PG-13 1h 42m',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: AppConstants.carouselHeight3,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: AppSize.s5.toInt()),
              viewportFraction: AppSize.s1,
              aspectRatio: AppSize.s2,
              enlargeCenterPage: true,
            ),
            items: images
                .map((item) => Container(
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
                    ))
                .toList(),
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
                          image: AssetImage(
                            ImageAssets.filmLogo,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Text(
                          'Steven Grant discovers he\'s been granted the powers of an Egyptian moon god. But he soon finds out that these newfound powers can be both a blessing and a curse to his troubled life'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          myDivider(),
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
                  'Coming soon',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  'Release Date June 17,2022(United States)',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          myDivider(),
          const SizedBox(height: 10.0,),
          Center(child: defaultButton(function: (){}, text: '+ Add to Watchlist' , background: ColorManager.yellow,width: 350)),

        ],
      ),
    );
  }
}
