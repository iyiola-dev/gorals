import 'package:flutter/material.dart';
import 'package:gorals/core/service/goralApi.dart';
import 'package:gorals/views/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: Home());
  }
}
