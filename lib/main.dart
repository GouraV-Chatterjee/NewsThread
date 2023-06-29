import 'package:flutter/material.dart';
import 'package:newsthread/views/home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() {
  initializeDateFormatting('en_IN', null).then((_) => runApp(MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:  Home(),
    );
  }
}
