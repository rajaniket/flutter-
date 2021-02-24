import 'package:flutter/material.dart';
import 'input_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),

      // theme: ThemeData(
      //     accentColor: Colors.amber,
      //     primaryColor: Color(0xFF0A0D22), // remove # and add 0xFF
      //     scaffoldBackgroundColor: Color(
      //         0xFF0A0D22), // by default background color will be this unless one change
      //     // backgroundColor: Colors.amber, this will not work
      //     textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))   // by default color
      //     ),

      // what we have done in up is like dark theme so be can modify dark theme which has already predefined properties specific for dark theme
      theme: ThemeData.dark().copyWith(
        // making a copy of dark theme
        primaryColor: Color(0xFF0A0E21), // remove # and add 0xFF
        scaffoldBackgroundColor: Color(
            0xFF0A0E21), // by default background color will be this unless one changes
      ),

      home: MyHomePage(),
    );
  }
}
