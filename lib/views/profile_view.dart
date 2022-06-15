import 'package:flutter/material.dart';
import 'package:mvvm_demo/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileViewModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future:provider.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 190,
                        child: Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Container(
                                height: 150.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      Provider.of<ProfileViewModel>(context).model.image!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -70,
                                child: CircleAvatar(
                                  backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  radius: 64.0,
                                  child: CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: NetworkImage(
                                      Provider.of<ProfileViewModel>(context).model.image!,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        Provider.of<ProfileViewModel>(context).model.name!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),

                      Text(
                        '(${Provider.of<ProfileViewModel>(context).model.bio})',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.yellow,
                    ));
              }
            },
          ),
        ),
      ),
    );
  }
}