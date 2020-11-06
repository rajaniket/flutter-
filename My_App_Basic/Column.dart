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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,  //it will manage space b/w widgets along the main axis (vertical)
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Hello'),
                Text('Aniket'),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.cyan,
              child: Text('One'),
            ),
            Container(
              padding: EdgeInsets.all(30),
              color: Colors.pinkAccent,
              child: Text('Two'),
            ),
            Container(
              padding: EdgeInsets.all(40),
              color: Colors.amber,
              child: Text('Three'),
            )
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Text('Click'),
          backgroundColor: Colors.red[900],
        ),
      );
  }
}

