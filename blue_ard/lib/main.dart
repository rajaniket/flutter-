import 'package:blue_ard/Pages/home.dart';
import 'package:flutter/material.dart';

// important link about bluetooth
//  https://pub.dev/documentation/flutter_bluetooth_serial/latest/flutter_bluetooth_serial/FlutterBluetoothSerial-class.html

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // to remove the banner
      title: "BlueArd",
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.cyanAccent[900],
      ),
    );
  }
}

// https://www.iflutter.in/flutter-bluetooth/
/*
 ___________________Methods of BluetoothAdapter class_______________________________ 
static synchronized BluetoothAdapter getDefaultAdapter() returns the instance of BluetoothAdapter.
boolean enable() enables the bluetooth adapter if it is disabled.
boolean isEnabled() returns true if the bluetooth adapter is enabled.
boolean disable() disables the bluetooth adapter if it is enabled.
String getName() returns the name of the bluetooth adapter.
boolean setName(String name) changes the bluetooth name.
int getState() returns the current state of the local bluetooth adapter.
Set<BluetoothDevice> getBondedDevices() returns a set of paired (bonded) BluetoothDevice objects.
boolean startDiscovery() starts the discovery process.

*/
