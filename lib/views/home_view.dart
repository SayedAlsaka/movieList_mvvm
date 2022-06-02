import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/view_model/movies_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Top 250 Movies')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 10,
            child: SizedBox(
              width: double.infinity,
              height: 420,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Coming soon',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'SEE ALL',
                            ))
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: provider.getComingSoonMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            width: double.infinity,
                            height: 350,
                            padding: const EdgeInsets.all(10),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, _) => const SizedBox(
                                width: 0,
                              ),
                              itemBuilder: (context, index) => Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  width: (MediaQuery.of(context).size.width / 2) - 50,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration:  BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                          color: Colors.red,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  provider.comingSoonList[index].image!),
                                              fit: BoxFit.fill),
                                        ),
                                        width:
                                        (MediaQuery.of(context).size.width / 2) - 50,
                                        height: 220,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: const [
                                                Icon(
                                                  Icons.star,
                                                  size: 18.0,
                                                  color: Colors.orange,
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text('6.3'),
                                              ],
                                            ),
                                            const SizedBox(height: 10.0,),
                                             Text(provider.comingSoonList[index].title!),
                                            const SizedBox(height: 10.0,),
                                            Text(provider.comingSoonList[index].year!,style: TextStyle(color: Colors.grey[700]),),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              itemCount: provider.comingSoonList.length,
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
