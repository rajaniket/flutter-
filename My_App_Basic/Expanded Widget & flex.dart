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
        body: Row(
          children: <Widget>[
            Expanded(child: Image.asset('img2.jpg'),
              flex: 4,
            ),
            Expanded(  // Expanded widget is used to auto flexible of container according to screen size
              flex: 3,  // this is the portion of the width we want to take up for this container in auto flexible( flex: 3 means it's width is more than flex: 2 and 1 ) , if we don't use flex then all container will get same ratio in auto flexible hence they are of same size
              child: Container(
                padding: EdgeInsets.all(30.0),
                color: Colors.cyan,
                child: Text('1'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(30.0),
                color: Colors.pinkAccent,
                child: Text('2'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(30.0),
                color: Colors.amber,
                child: Text('3'),
              ),
            ),
          ],
        ),
      );
  }
}

