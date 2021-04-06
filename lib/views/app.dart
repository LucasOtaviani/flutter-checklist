import 'package:flutter/material.dart';
import 'package:checklist/views/tasks/create.dart';
import 'package:checklist/views/tasks/index.dart';
import 'package:checklist/views/tasks/update.dart';

 class App extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange[400],
        accentColor: Colors.orange[800],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange[600],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => IndexTasks(),
        '/create': (context) => CreateTask(), 
        '/update': (context) => UpateTask(),
      },
      initialRoute: '/',
      );
   }
 }