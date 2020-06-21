import 'package:firebase_auth_provider/pages/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());


class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {},
      debugShowCheckedModeBanner: false,
      title: 'Stream firestore data',
      home: Home(),
    );
  }
}