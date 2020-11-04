import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(    // scaffold is a widget which contains multiple widgets like appbar floatingActionButton,e.t.c
        appBar: AppBar(  // app bar widget // child is not required
          title: Text('My first app'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey , //click on red and press ctrl+Q and choose different colors of red using array value (hide that tab using shift+esc) or you can search diff colors on materialdesign.io
        ),
        body: Center(  // body segment aligning to center
          child: Text('Hello Aniket Raj!',  // body containing many child
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
          child: Text('Click\nHere'),
          backgroundColor: Colors.red[900],
        ),
      ),
    ));


