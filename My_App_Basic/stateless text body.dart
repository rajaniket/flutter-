import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(), // just using custom made stateless Home widget
));
// for creating stateless widget just write stless
// Stateless widgets : the state of the widgets cannot over time e.g,layout,Time,icon
class Home extends StatelessWidget {
  @override  // StatelessWidgets also contain build function but here we are again redefining a build function that's why we are using @override
  Widget build(BuildContext context) {
    return Scaffold(    // scaffold is a widget which contains multiple widgets like appbar floatingActionButton,e.t.c (once you use stateless widget you don't need to hot reload every time just save and check it's output ,it just reload that modified part of code which takes less time to run
        appBar: AppBar(  // app bar widget // child is not required
          title: Text('My first app'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey , //click on red and press ctrl+Q and choose different colors of red using array value (hide that tab using shift+esc) or you can search diff colors on materialdesign.io
        ),
        body: Center(  // body segment aligning to center
          child: Text('Hello Raj!',  // body containing many child
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.grey[600],
                fontFamily: 'IndieFlower',  // go to google fonts download fonts then make a fonts directory by clicking right key over myapp--> new-->directory then drag the extracted font on that folder then fo to pubspec.yaml and edit that file (follow this link--> 6:00 min : https://www.youtube.com/watch?v=km2P_KQJyO0&t=573s)
              )
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Text('Click'),
          backgroundColor: Colors.red[900],
        ),
      );
  }
}

