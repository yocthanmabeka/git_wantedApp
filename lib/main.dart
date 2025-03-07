import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted/models/model.dart';

import 'package:wanted/wanted_view.dart';

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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WantedProvider()),
          ChangeNotifierProvider(create: (context) => WantedTabProvider()),
          ChangeNotifierProvider(create: (context) => EventManager()),
          ChangeNotifierProvider(create: (context) => EventLiveProvider()),
          ChangeNotifierProvider(create: (context) => MemorialProvider()),
          ChangeNotifierProvider(create: (context) => ActivityProvider()),
        ],
        child: WantedView(),
      )
    );
  }
}