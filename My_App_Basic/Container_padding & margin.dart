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
          backgroundColor: Colors.red[700] , //click on red and press ctrl+Q and choose different colors of red using array value (hide that tab using shift+esc) or you can search diff colors on materialdesign.io
        ),
        // body: Container(  // if container not include any child then container takes the full space available to it (whole body or screen inside the body)
        //   // padding: EdgeInsets.all(20.0),  // all means same margin from all side
        //   // padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0), // to manage vertical and horizontal padding around child
        //   padding: EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0), // different padding in all direction
        //   margin: EdgeInsets.all(30.0), // margin is around the container  while padding is inside the container
        //   color: Colors.blueGrey[500],
        //   child: Text('Hello'),  // if container includes child then the container restricts itself to size of that child widget
        //   ),

        // in case you just want to padding a text without creating container
        body: Padding( // in this we can't apply color and margin property for that use container widget
          padding: EdgeInsets.all(100.0),
          child: Text('Hello'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Text('Click'),
          backgroundColor: Colors.red[900],
        ),
      );
  }
}

