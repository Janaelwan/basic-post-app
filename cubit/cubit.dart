import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/Data.dart';
import 'package:posts/cubit/States.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(initialState());
  Dio dio = Dio();
  var dataWeather;
  Weather? weather;
  bool weatherx = false;

  void getData() async {
    Response response = await dio
        .get(
            "http://api.weatherapi.com/v1/current.json?key=e3a6705d6d6d42f2907225815233008&q=Egypt&aqi=no")
        .then((value) {
      return value;
    });

    dataWeather = response.data;
    weather = Weather(
        dataWeather['location']['name'],
        dataWeather['current']['temp_c'],
        dataWeather['current']['condition']['text']);
  }

  Icon color(String x) {
    Icon icon = Icon(
      Icons.sunny_snowing,
      size: 40,
      color: Colors.yellow,
    );

    if (x == dataWeather['current']['condition']['text'] && x == 'Sunny') {
      icon = Icon(
        Icons.sunny,
        color: Colors.yellow,
      );
    }
    if (x == dataWeather['current']['condition']['text'] && x == 'Clear') {
      icon = Icon(
        Icons.sunny,
        color: Colors.yellow,
      );
    }
    if (x == dataWeather['current']['condition']['text'] && x == 'Rainy')
      icon = Icon(
        Icons.sunny_snowing,
        color: Colors.yellow,
      );
    return icon;
    emit(BackGroundcolor());
  }

  var dataNews;

  void getNewsData() async {
    Response response = await dio.get(
        'https://newsdata.io/api/1/news?apikey=pub_2867376be8daadb6f12a59c11a6b2e3b10ee1&q=cryptocurrency');

    dataNews = response.data;
    print("value is ${dataNews['results']['title']}");
  }

  TextEditingController title = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController titleEdit = TextEditingController();
  TextEditingController dateEdit = TextEditingController();
  TextEditingController timeEdit = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController emailLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();

  // TextEditingController name = TextEditingController();
  // TextEditingController post = TextEditingController();
  // TextEditingController time = TextEditingController();
  // TextEditingController titleEdit = TextEditingController();
  // TextEditingController dateEdit = TextEditingController();
  // TextEditingController timeEdit = TextEditingController();
  bool showWeather = true;
  int selected_index = -1;
  int currentIndex = 0;
  bool showpassword = false;

  void showPassword(bool x) {
    showpassword = x;
    emit(ShowPassword());
  }

  void indexOfPage(int counter) {
    currentIndex = counter;
    emit(IndexOfPages());
  }

  void ShowWeather(bool x) {
    showWeather = x;
    emit(ShowWeatherPhoto());
  }

  bool showStarNews = true;

  void Showstarnews(bool x) {
    showStarNews = x;
    emit(ShowStarNews());
  }

  static AppCubit get(context) => BlocProvider.of(context);
  late Database databas;
  bool show = false;
  bool edit = false;

  void editTodo(bool x) {
    edit = x;
    emit(Edit());
  }

  void ShowEditIcon(bool x) {
    show = x;
    emit(MangeEditIcon());
  }

  void createDatabase() {
    openDatabase(
      'todoDB.db',
      version: 1,
      onCreate: (db, version) {
        print("Database Created");
        db
            .execute(
                "Create Table tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT ,time TEXT)")
            .then((value) {
          print("Table created");
        }).catchError((onError) {
          print("Catched Error is ${onError.toString()}");
        });
      },
      onOpen: (db) {
        print("Database Opened");
      },
    ).then((value) {
      databas = value;

      getFromDatabaase();
    });
    emit(CreateDatabase());
  }

  void insertIntoDatabase(String title, String date, String time) async {
    await databas.transaction((txn) async {
      txn
          .rawInsert(
              'Insert into tasks (title,date,time) VALUES ("$title","$date","$time")')
          .then((value) {
        print("$value raw inserted");
      }).catchError((e) {
        print(e);
      });
    });
    getFromDatabaase();
    emit(Insert());
  }

  bool isDone = true;

  void IsDone(bool x) {
    isDone = x;
    emit(IsDoneTodo());
  }

  List<Map> data = [];

  List<Map> datalogin = [];

  void getFromDatabaase() {
    databas.rawQuery("Select * from tasks").then((value) => data = value);
    print(data);
    emit(GetFromDatabase());
  }

  void deleteFromDatabase(int id) async {
    await databas.rawDelete('Delete from tasks WHERE id=?', [id]).then(
        (value) => print("raw deleted"));
    getFromDatabaase();
    emit(DeleteFromDatabase());
  }

  late Database databaseProfile;

   createDatabaseProfile() {
    openDatabase(
      'profile.db',
      version: 1,
      onCreate: (db, version) {
        print("Database Created");
        db
            .execute(
                "Create Table profile (id INTEGER PRIMARY KEY, email TEXT,password TEXT ,mobilenumber TEXT)")
            .then((value) {
          print("Table created");
        }).catchError((onError) {
          print("Catched Error is ${onError.toString()}");
        });
      },
      onOpen: (db) {
        print("Database Opened");
      },
    ).then((value) {
      databaseProfile = value;

      print(getFromDataProfile());
    });
    emit(CreateDataProfile());
  }

  int id = 0;




  /*void deleteFromDatabase(int id) async {
    await databas.rawDelete('Delete from tasks WHERE yid=?', [id]).then(
            (value) => print("raw deleted"));
    getFromDatabaase();
    emit(DeleteFromDatabase());
  }*/
  void insertIntoDatabaseProfile(
      String email, String password, String mobileNumber) async {
    await databaseProfile.transaction((txn) async {
      txn
          .rawInsert(
              'Insert into profile (email ,password  ,mobilenumber ) VALUES ("$email","$password","$mobileNumber")')
          .then((value) {
        print("$value raw inserted");
      }).catchError((e) {
        print(e);
      });
    });
    getFromDataProfile();
    emit(InsertinProfile());
  }
  Future<List<Map>> getProfileFromDatabaase() async {
    // Ensure that the databaseProfile is initialized before using it
    if (databaseProfile == null) {
      await createDatabaseProfile(); // Initialize the databaseProfile
    }

    // Fetch data from the database
    final data = await databaseProfile.rawQuery("Select * from profile");
    datalogin = data;
    print(datalogin);
    emit(getFromDataProfile());
    return datalogin;

  }
}
