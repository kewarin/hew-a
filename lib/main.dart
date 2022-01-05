import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/screen/launcher.dart';

void main() {
  runApp(const MyApp());
}

// ส่วนของ Stateless widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Palette.roseBud,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          })),
      title: 'Hew\'a App',
      initialRoute: '/', // สามารถใช้ home แทนได้
      routes: {
        Launcher.routeName: (context) => Launcher(),
      },
    );
  }
}
