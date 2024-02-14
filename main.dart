import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/Posts.dart';
import 'package:posts/Register.dart';
import 'package:posts/cubit/cubit.dart';
import 'package:posts/weather.dart';

import 'Login.dart';
import 'Stared news.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  bool _iconBool = false;

  IconData _iconLight = Icons.wb_sunny;
  IconData _iconDark = Icons.nights_stay;

  ThemeData _lightTheme = ThemeData(
      primarySwatch: Colors.amber,
      brightness: Brightness.light
  );
  ThemeData _darkTheme = ThemeData(
      primarySwatch: Colors.red,
      brightness: Brightness.dark
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return AppCubit()..createDatabaseProfile();
    },
      child: MaterialApp(
        home:Login(),
        theme: _iconBool? _darkTheme: _lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
