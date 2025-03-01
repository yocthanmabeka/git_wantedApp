import 'package:flutter/material.dart';
import 'package:wanted/wanted_view.dart';
//import 'package:wanted/wanted_view.dart';
//aimport 'package:wanted/component/defaultTheme.dart';

void main() {
  // Starting point of the application
  runApp(WantedApp ());
}

class WantedApp extends StatelessWidget {

  const WantedApp({super.key});
  //Setting up the theme
  //final theme = DefaultTheme.light();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wanted',
      //Using the theme
      //theme: ThemeData.dark(),
      //Home of application
      home: WantedView()
    );
  }
}