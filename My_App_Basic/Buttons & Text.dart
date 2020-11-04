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
          /*child: Icon( // many icons like cars, boy etc
            Icons.airport_shuttle,
            color: Colors.blue,
            size: 80.0,
          ),*/

          /*child: FlatButton( // simple flat rectangular button
            onPressed: () {},
            child: Text('Click Me'),
            color: Colors.lightBlue,
          )*/

          /*child: RaisedButton(  // flat button with shadow effect
            onPressed: (){
              print('you clicked me');  // on clicking this will print on console (Run tab in android studio)
            },
            child: Text('Click Me'),
            color: Colors.lightBlue,
          ),*/

          // icon inside a button
          /*child: RaisedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.mail,
              ),
              label: Text('mail me'),
              color: Colors.amber,
          )*/

          // clickable Icon or icon button

          child: IconButton(
            onPressed: (){
              print('You Clicked me');
            },
            icon: Icon(Icons.alarm),
            color: Colors.amber,
          )


          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Text('Click'),
          backgroundColor: Colors.red[900],
        ),
      );
  }
}

