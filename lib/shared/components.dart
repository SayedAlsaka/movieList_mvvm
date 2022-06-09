import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';

import '../resources/assets_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

void navigatePush(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget defaultTextButton({
  @required Function()? function,
  @required String? text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text!.toUpperCase(),
        style: TextStyle(
          color: ColorManager.yellow,
          fontFamily: 'Tajawal',
          fontWeight: FontWeight.bold,
        ),
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.grey,
  Color textColor = Colors.black,
  ShapeBorder? shape,
  required Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      color: background,
      child: MaterialButton(
        onPressed: function,
        shape: shape,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 18.0,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  required String label,
  required IconData picon,
  bool isPassword = false,
  Function? onChange,
  IconData? sicon,
  Function()? suffixPressed,
  Function()? onTab,
  Function? onSubmit,
  required BuildContext context,
}) =>
    TextFormField(
      cursorColor: Theme.of(context).cursorColor,
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.yellow, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.yellow, width: 1.0),
        ),
        labelStyle: TextStyle(color: ColorManager.yellow),
        prefixIcon: Icon(
          picon,
          color: ColorManager.yellow,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.yellow, width: 1.0),
        ),
        suffixIcon: sicon != null
            ? IconButton(
                icon: Icon(sicon, color: Theme.of(context).iconTheme.color),
                onPressed: suffixPressed,
              )
            : null,
      ),
      validator: validate,
      onFieldSubmitted: onSubmit as void Function(String)?,
      onTap: onTab,
      onChanged: onChange as void Function(String)?,
    );

Widget cardMovie(
        {required context,
        required title,
        required movieImage,
        required movieName,
        required movieYear,
        }) =>
    Card(
      elevation: AppSize.s10,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.cardHeight,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: AppSize.s20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        AppStrings.seeAll,
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: AppConstants.filmListHeight,
              padding: const EdgeInsets.all(AppPadding.p10),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, _) => const SizedBox(
                  width: 0,
                ),
                itemBuilder: (context, index) => Card(
                  elevation: AppSize.s5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  child: Container(
                    width:
                        (MediaQuery.of(context).size.width / AppSize.s2) - 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSize.s10),
                            topRight: Radius.circular(AppSize.s10))),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(AppSize.s10),
                                    topRight: Radius.circular(AppSize.s10)),
                                image: DecorationImage(
                                    // image: NetworkImage(
                                    //     provider.comingSoonList[index].image!),
                                    image: AssetImage(movieImage),
                                    fit: BoxFit.fill),
                              ),
                              width: (MediaQuery.of(context).size.width /
                                      AppSize.s2) -
                                  50,
                              height: 220,
                            ),
                            Positioned(
                              left: -12,
                              top: -3,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(AppSize.s20),
                                  ),
                                  image: DecorationImage(
                                      image:
                                          AssetImage(ImageAssets.bookmarkLogo),
                                      fit: BoxFit.fill),
                                ),
                                width: 60,
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: AppSize.s5,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: AppSize.s5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Text(provider.comingSoonList[index].title!),
                                Text(
                                  movieName,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Row(
                                  children: [
                                    //Text('${provider.comingSoonList[index].year} ${provider.comingSoonList[index].contentRating}',style: TextStyle(color: Colors.grey[700]),),
                                    Text(
                                      movieYear,
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: 6,
              ),
            ),
          ],
        ),
      ),
    );

Widget boxOfficeCard({
  required context,
  required title,
  required movieNumber,
  required movieName,
  required moviePrice,
}) =>
    Card(
      elevation: AppSize.s10,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.cardHeight,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: AppSize.s20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.boxOffice,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        AppStrings.seeAll,
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: AppConstants.filmListHeight,
              padding: const EdgeInsets.all(AppPadding.p10),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, _) => const SizedBox(
                  height: AppSize.s10,
                ),
                itemBuilder: (context, index) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(movieNumber,
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.bookmark_add,
                              size: 40,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movieName,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                 Text(
                                  '\$$moviePrice',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.check_box_outlined),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                itemCount: 6,
              ),
            ),
          ],
        ),
      ),
    );
