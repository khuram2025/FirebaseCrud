import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_books/pages/HomePage.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initilization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:_initilization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            print("Something went wrong");
          }
          if(snapshot.connectionState == ConnectionState.done){
            return  MaterialApp(
              title: 'Flutter Firestore CRUD',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              home: HomePage(),
            );
          }
          return CircularProgressIndicator();
        },);
  }
}

