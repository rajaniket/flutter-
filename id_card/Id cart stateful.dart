import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// all the yellow one is widget and it contains some parameters

void main() {
  runApp(MaterialApp(
    home:NinjaCard(),
  ));
}
class NinjaCard extends StatefulWidget { // A widget is either stateful or stateless. If a widget can change—when a user interacts with it, for example—it's stateful. A stateless widget never changes.
  @override
  _NinjaCardState createState() => _NinjaCardState();
}

class _NinjaCardState extends State<NinjaCard> {
  int ninjaLevel=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold is a class in flutter which provides many widgets or we can say APIs like Drawer, SnackBar, BottomNavigationBar, FloatingActionButton, AppBar etc.
      backgroundColor: Colors.grey[900],
      appBar: AppBar( // AppBar is a widget and title,centerTitle,backgroundColor etc is parameter of that widget
        title: Text('Ninja ID Card'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0, // shadow intensity
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            ninjaLevel++;   // when you want to change the state of a data in stateful widget always use setState((){.....});
          });
        },
          child:Icon(Icons.add),
        backgroundColor: Colors.grey[800],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30,40,30,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/aniket.jpg'),
                maxRadius: 80,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.grey[800],
            ),
            Text('NAME',
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 2.0, // spacing b/w letters
            ),
            ),
            SizedBox(height: 2.0,), // attaching a invisible box in b/w for maintaining a gap
            Text('Aniket',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0, // spacing b/w letters
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0,),
            Text('CURRENT NINJA LEVEL',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0, // spacing b/w letters
              ),
            ),
            SizedBox(height: 2.0,),
            Text('$ninjaLevel',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0, // spacing b/w letters
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 12.0,),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text('aniketraj.go@gmail.com',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18.0,
                ),
                )
              ],
            ),
          ],
        ),

      ),

    );
  }
}





