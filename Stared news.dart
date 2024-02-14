import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/Data.dart';
import 'package:posts/cubit/States.dart';
import 'package:posts/cubit/cubit.dart';
import 'package:posts/newPage.dart';
import 'package:posts/profile.dart';
import 'package:posts/todo.dart';
import 'package:posts/weather.dart';

class MainPage extends StatelessWidget {
   MainPage({Key? key}) : super(key: key);
   final List<Widget> _pages = [
     //NewsPage(),
     WeatherApp(),
     NotePage(),
     ToDoApp(),


   ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return AppCubit();

    },
    child:BlocConsumer<AppCubit,AppStates>(listener:(context, state) {

    } ,builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);
      return Scaffold(
        body:_pages[cubit.currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (int index) {
            cubit.indexOfPage(index);
          },
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_outlined),
              label: 'Latest news',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_outlined),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined),
              label: 'To do',
            ),

          ],
        ),
      );

    },),



    );
  }
}
