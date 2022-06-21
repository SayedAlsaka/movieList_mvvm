import 'package:flutter/material.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';
import 'package:mvvm_demo/view_model/movie_details_view_model.dart';
import 'package:mvvm_demo/views/movie_details_view.dart';
import 'package:provider/provider.dart';
import '../resources/assets_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import '../view_model/profile_view_model.dart';

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
  TextStyle style = const TextStyle(
    color: Colors.blue,
    fontSize: 18.0,
  ),
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
          style: style,
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
        required cardTitle,
        required List movies,
        required profileProvider,
        required homeProvider}) =>
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
                    cardTitle,
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
                    child: InkWell(
                      onTap: () async {
                        await Provider.of<MovieDetailsViewModel>(context,
                                listen: false)
                            .getVideoID(movies[index].id);
                        await Provider.of<MovieDetailsViewModel>(context,
                                listen: false)
                            .getMovieDetails(movies[index].id);
                        navigatePush(
                            context,
                            MovieDetailsView(
                              movie: Provider.of<MovieDetailsViewModel>(context,
                                      listen: false)
                                  .movieModel,
                              category: cardTitle,
                              id: Provider.of<MovieDetailsViewModel>(context,
                                      listen: false)
                                  .videoID,
                            ));
                      },
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
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w780${movies[index].posterPath}'),
                                      fit: BoxFit.fill),
                                ),
                                width: (MediaQuery.of(context).size.width /
                                        AppSize.s2) -
                                    50,
                                height: 220,
                              ),
                              if (profileProvider.model.bookMarks.isEmpty)
                                Positioned(
                                  left: -13,
                                  top: -8,
                                  child: InkWell(
                                    onTap: () async {
                                      homeProvider.addToBookMark();
                                      await profileProvider.getUserData();
                                      await homeProvider.updateBookMarkUser(
                                          bookMarks: movies[index].id!,
                                          id: Provider.of<ProfileViewModel>(
                                              context,
                                              listen: false)
                                              .model
                                              .id,
                                          context: context);
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          Icons.bookmark_rounded,
                                          color: ColorManager.grey,
                                          size: 60,
                                        ),
                                        Icon(Icons.add,
                                            color: ColorManager.black),
                                      ],
                                    ),
                                  ),
                                ),
                                if (Provider.of<ProfileViewModel>(context).model.bookMarks!.isNotEmpty && Provider.of<ProfileViewModel>(context).model.bookMarks!.contains(movies[index].id) == false)
                                  Positioned(
                                    left: -13,
                                    top: -8,
                                    child: InkWell(
                                      onTap: () async {
                                        homeProvider.addToBookMark();
                                        await profileProvider.getUserData();
                                        await homeProvider.updateBookMarkUser(
                                            bookMarks: movies[index].id!,
                                            id: Provider.of<ProfileViewModel>(
                                                    context,
                                                    listen: false)
                                                .model
                                                .id,
                                            context: context);
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.bookmark_rounded,
                                            color: ColorManager.grey,
                                            size: 60,
                                          ),
                                          Icon(Icons.add,
                                              color: ColorManager.black),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (Provider.of<ProfileViewModel>(context).model.bookMarks!.isNotEmpty &&Provider.of<ProfileViewModel>(context).model.bookMarks!.contains(movies[index].id) == true)
                                  Positioned(
                                    left: -13,
                                    top: -8,
                                    child: InkWell(
                                      onTap: () async {
                                        homeProvider.removeFromBookMark();
                                        await profileProvider.getUserData();
                                        await homeProvider.removeBookMarkUser(
                                            bookMarks: movies[index].id!,
                                            id: Provider.of<ProfileViewModel>(
                                                    context,
                                                    listen: false)
                                                .model
                                                .id,
                                            context: context);
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.bookmark_rounded,
                                            color: ColorManager.yellow,
                                            size: 60,
                                          ),
                                          Icon(Icons.done,
                                              color: ColorManager.black),
                                        ],
                                      ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    movies[index].title!,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  if (movies[index].voteAverage != 0)
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: ColorManager.yellow,
                                          size: AppSize.s20,
                                        ),
                                        const SizedBox(
                                          width: AppSize.s5,
                                        ),
                                        Text(
                                          '${movies[index].voteAverage}',
                                        ),
                                      ],
                                    ),
                                  Text(
                                    movies[index].releaseDate!,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                itemCount: movies.length,
              ),
            ),
          ],
        ),
      ),
    );

Widget boxOfficeCard({
  required context,
  required cardTitle,
  required List movies,
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
                itemBuilder: (context, index) => Row(
                  children: [
                    Text(movies[index].rank!,
                        style: Theme.of(context).textTheme.bodyText1),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSize.s20),
                          ),
                          image: DecorationImage(
                              image: AssetImage(ImageAssets.bookmarkLogo),
                              fit: BoxFit.fill),
                        ),
                        width: 60,
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(movies[index].title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(
                              movies[index].gross!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(Icons.airplane_ticket),
                  ],
                ),
                itemCount: movies.length,
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[400],
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

SnackBar snackBar({
  required String msg,
  required ToastStates state,
}) =>
    SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: chooseToastColor(state),
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'Tajawal', fontSize: 18.0, color: Colors.white),
        ));

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = ColorManager.grey;
      break;
    case ToastStates.WARNING:
      color = ColorManager.yellow;
      break;
    case ToastStates.ERROR:
      color = ColorManager.error;
      break;
  }
  return color;
}

Widget bookMarkLogoAdd ({
  required profileProvider,
  required provider,
  required item,
  required context,
}) => Positioned(
  left: -13,
  top: -8,
  child: InkWell(
    onTap: () async {
      await profileProvider
          .getUserData();
      await provider
          .updateBookMarkUser(
          bookMarks:
          item.id!,
          id: Provider.of<
              ProfileViewModel>(
              context,
              listen:
              false)
              .model
              .id,
          context: context);
    },
    child: Stack(
      alignment:
      Alignment.center,
      children: [
        Icon(
          Icons
              .bookmark_rounded,
          color:
          ColorManager.grey,
          size: 60,
        ),
        Icon(Icons.add,
            color: ColorManager
                .black),
      ],
    ),
  ),
);
Widget bookMarkLogoRemove({
  required profileProvider,
  required provider,
  required item,
  required context,
}) => Positioned(
  left: -13,
  top: -8,
  child: InkWell(
    onTap: () async {
      await profileProvider
          .getUserData();
      await provider
          .removeBookMarkUser(
          bookMarks:
          item.id!,
          id: Provider.of<
              ProfileViewModel>(
              context,
              listen:
              false)
              .model
              .id,
          context: context);
    },
    child: Stack(
      alignment:
      Alignment.center,
      children: [
        Icon(
          Icons
              .bookmark_rounded,
          color:
          ColorManager.yellow,
          size: 60,
        ),
        Icon(Icons.done,
            color: ColorManager
                .black),
      ],
    ),
  ),
);
