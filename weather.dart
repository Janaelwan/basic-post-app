import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/cubit/States.dart';
import 'package:posts/cubit/cubit.dart';
import 'package:posts/todo.dart';

import 'Stared news.dart';

class WeatherApp extends StatelessWidget {
  WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) {
        return AppCubit()..getData();
      },
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            //  backgroundColor: cubit.weatherx?Colors.blue:Colors.black,
            body: SafeArea(
              child: cubit.dataNews == null || cubit.dataWeather == null
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(clipBehavior:Clip.antiAliasWithSaveLayer ,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  'lib/assets/Weather.jpeg',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            Text(
                                              cubit.dataWeather['location']
                                                  ['name'],
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              cubit.dataWeather['current']
                                                      ['temp_c']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 35,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              cubit.dataWeather['current']
                                                  ['condition']['text'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 35,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            cubit.color(
                                              cubit.dataWeather['current']
                                                  ['condition']['text'],
                                            ),
                                          ],
                                        ),
                                       /* Text(
                                            cubit.dataWeather['location']
                                            ['localtime'],
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),*/
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Column(
                                            children: [
                                              Text(
                                                cubit.dataNews['results'][index]
                                                    ['title'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                cubit.dataNews['results'][index]
                                                    ['content'],
                                                maxLines: 3,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Image.network(
                                                cubit.dataNews['results'][index]
                                                            ['image_url'] ==
                                                        null
                                                    ? " NO IMAGE"
                                                    : cubit.dataNews['results']
                                                        [index]['image_url'],
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Text('image not found'),
                                              ),
                                              Row(
                                                children: [
                                                  Text("Show details",
                                                      style: TextStyle(
                                                          fontSize: 26)),
                                                  IconButton(
                                                      onPressed: () {
                                                        if (cubit
                                                                .showStarNews ==
                                                            true) {
                                                          cubit.Showstarnews(
                                                              false);
                                                        } else {
                                                          cubit.Showstarnews(
                                                              true);
                                                        }
                                                        cubit.selected_index =
                                                            index;
                                                        if (cubit
                                                                .selected_index !=
                                                            -1) {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    "Selected News"),
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        cubit.dataNews['results'][cubit.selected_index]
                                                                            [
                                                                            'title'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              20,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      Text(
                                                                        cubit.dataNews['results'][cubit.selected_index]
                                                                            [
                                                                            'content'],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                      // Add more fields as needed
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      // Clear the selected index
                                                                      cubit.selected_index =
                                                                          -1;
                                                                    },
                                                                    child: Text(
                                                                        "Close"),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        }
                                                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>StarNews()));
                                                      },
                                                      icon: Icon(Icons
                                                          .arrow_circle_down))
                                                ],
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                itemCount: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            /*

              */

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                cubit.getNewsData();
                print(cubit.dataNews['result']);
              },
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
