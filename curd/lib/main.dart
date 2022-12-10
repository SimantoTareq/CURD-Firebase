import 'package:curd/demo/slidable.dart';
import 'package:curd/pages/home_page.dart';
import 'package:curd/pages/listStudent2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          //check for errors
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          //once completed , show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: HomePage());
          }
          return CircularProgressIndicator();
        });
  }
}
