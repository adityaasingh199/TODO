import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:todo_block/bloc/todo_bloc.dart';
import 'package:todo_block/database/db_helper.dart';
import 'package:todo_block/splash/splash_screen.dart';
import 'package:todo_block/widget/home_page.dart';

void main() {
  runApp(BlocProvider(create: (context) => todoBloc(DbHelper: dbHelper.GetIntstance())
  ,child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashScreen()
    );
  }
}
