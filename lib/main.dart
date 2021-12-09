import 'package:flutter/material.dart';
import 'package:micro/home.dart';
import 'package:micro/http.dart';
import 'package:micro/providers/user.dart';
import 'package:provider/provider.dart';

void main() {
  networkInit();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(create: (context) => UserState()),
      ],
      child: MaterialApp(
        title: 'Hello world',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
