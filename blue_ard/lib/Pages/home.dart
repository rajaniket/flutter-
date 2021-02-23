import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //*********************** All variables *************************** start
  // .... Enabling bluetooth......
  // intializing the bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // get the current instance of the bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Tracking the bluetooth connection with the remote device , BluetoothConnection is a class that Represents ongoing Bluetooth connection to remote device.
  // inside this class there are many inbuilt function has defined like isConnected which is a bool type
  BluetoothConnection connection;
  // To track wether the device is still connected or not to bluetooth
  bool get isConnected =>
      connection != null &&
      connection
          .isConnected; // Fat Arrow Expression or Lambda Function Expression is a syntax to write a function on a single line
  // defining a deviceState variable to track connection state of bluetooth device
  int _deviceState;
  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // defining a new class member variable for storing device list
  List<BluetoothDevice> _devicesList = [];
  // defining a member variable to track when the disconnection is in progress
  bool isDisconnecting = false;
  bool _connected = false;
  BluetoothDevice _device;
  bool _isButtonUnavailable = false;

  Map<String, Color> colors = {
    'onBorderColor': Colors.green,
    'offBorderColor': Colors.red,
    'neutralBorderColor': Colors.transparent,
    'onTextColor': Colors.green[700],
    'offTextColor': Colors.red[700],
    'neutralTextColor': Colors.blue,
  };

  //*********************** All variables *************************** end

  // inside initState , first we have to fetch current state of bluetooth , as per state , requst user to give permissions for enabling Bluetooth on their device if the Bluetooth is not turned on.
  @override
  void initState() {
    super.initState();

    // getting current state
    FlutterBluetoothSerial.instance.state.then((state) {
      // state is argument , that will give us status
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0; // netural

    // if the bluetooth of the device is not enabled, then request permission to turn on bluetooth as the app starts up.
    enableBluetooth(); // for getting bluetooth permission from the user.

    // Listen for further state change  (after enabling again we have to do some operations)
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        // now for retrieving or fetching the paired device list
        getPairedDevices(); // for fetching the paired device list
      });
    });
    //
  }

  // defining enableBluetooth function
  Future<bool> enableBluetooth() async {
    // retrieving the current bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // if the bluetooth is off, then turn it on first and then retrieve the devices that are paired
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices(); // defined downside
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  // Definig getPairedDevices function
  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];
    // to get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      // Thrown to indicate that a platform interaction failed in the platform plugin.
      print("Error");
    }
    // it is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }
    // store the [devices] list in the [_deviceList] for accessing the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

  @override
  void dispose() {
    // Avoid memory leak and disconnect
    if (isConnected) {
      // isConnected is already defined at 22th line
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    super.dispose();
  }

  //   If you are creating a stream in initState of your StatefullWidget,
  //   then it is important that you close that stream in dispose method of that state or else it will cause memory leak.
  //   Otherwise your app may get warning from playstore and appstore about memory leakage.
  //   So basically dispose is called when that current state will never be used again.
  //   memory leak is a type of resource leak that occurs when a computer program incorrectly manages memory allocations in such a way that memory which is no longer needed is not released
  //   dispose() method is called when this object is removed from the tree permanently.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        title: Text("BlueArd"),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            label: Text(
              "Refresh",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            splashColor: Colors.amberAccent[900],
            onPressed: () async {
              // So, that when new devices are paired
              // while the app is running, user can refresh
              // the paired devices list.
              await getPairedDevices().then((_) {
                show('Device list refreshed', duration: Duration(seconds: 3));
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Visibility(
              visible: _isButtonUnavailable &&
                  _bluetoothState == BluetoothState.STATE_ON,
              child: LinearProgressIndicator(
                backgroundColor: Colors.yellow,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Enable Bluetooth',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Switch(
                    value: _bluetoothState.isEnabled,
                    onChanged: (bool value) {
                      future() async {
                        if (value) {
                          await FlutterBluetoothSerial.instance.requestEnable();
                        } else {
                          await FlutterBluetoothSerial.instance
                              .requestDisable();
                        }

                        await getPairedDevices();
                        _isButtonUnavailable = false;

                        if (_connected) {
                          _disconnect();
                        }
                      }

                      future().then((_) {
                        setState(() {});
                      });
                    },
                  )
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "PAIRED DEVICES",
                        style: TextStyle(fontSize: 24, color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Device:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButton(
                            items: _getDeviceItems(),
                            onChanged: (value) =>
                                setState(() => _device = value),
                            value: _devicesList.isNotEmpty ? _device : null,
                          ),
                          RaisedButton(
                            onPressed: _isButtonUnavailable
                                ? null
                                : _connected
                                    ? _disconnect
                                    : _connect,
                            child: Text(_connected ? 'Disconnect' : 'Connect'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: new BorderSide(
                            color: _deviceState == 0
                                ? colors['neutralBorderColor']
                                : _deviceState == 1
                                    ? colors['onBorderColor']
                                    : colors['offBorderColor'],
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        elevation: _deviceState == 0 ? 4 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "DEVICE 1",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: _deviceState == 0
                                        ? colors['neutralTextColor']
                                        : _deviceState == 1
                                            ? colors['onTextColor']
                                            : colors['offTextColor'],
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: _connected
                                    ? _sendOnMessageToBluetooth
                                    : null,
                                child: Text("ON"),
                              ),
                              FlatButton(
                                onPressed: _connected
                                    ? _sendOffMessageToBluetooth
                                    : null,
                                child: Text("OFF"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.blue,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "NOTE: If you cannot find the device in the list, please pair the device by going to the bluetooth settings",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 15),
                      RaisedButton(
                        elevation: 2,
                        child: Text("Bluetooth Settings"),
                        onPressed: () {
                          FlutterBluetoothSerial.instance.openSettings();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Create the List of devices to be shown in Dropdown Menu
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  // Method to connect to bluetooth
  void _connect() async {
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      show('No device selected');
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });

          connection.input.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        show('Device connected');

        setState(() => _isButtonUnavailable = false);
      }
    }
  }

  // void _onDataReceived(Uint8List data) {
  //   // Allocate buffer for parsed data
  //   int backspacesCounter = 0;
  //   data.forEach((byte) {
  //     if (byte == 8 || byte == 127) {
  //       backspacesCounter++;
  //     }
  //   });
  //   Uint8List buffer = Uint8List(data.length - backspacesCounter);
  //   int bufferIndex = buffer.length;

  //   // Apply backspace control character
  //   backspacesCounter = 0;
  //   for (int i = data.length - 1; i >= 0; i--) {
  //     if (data[i] == 8 || data[i] == 127) {
  //       backspacesCounter++;
  //     } else {
  //       if (backspacesCounter > 0) {
  //         backspacesCounter--;
  //       } else {
  //         buffer[--bufferIndex] = data[i];
  //       }
  //     }
  //   }
  // }

  // Method to disconnect bluetooth
  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    });

    await connection.close();
    show('Device disconnected');
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
      });
    }
  }

  // Method to send message,
  // for turning the Bluetooth device on
  void _sendOnMessageToBluetooth() async {
    connection.output.add(utf8.encode("1" + "\r\n"));
    await connection.output.allSent;
    show('Device Turned On');
    setState(() {
      _deviceState = 1; // device on
    });
  }

  // Method to send message,
  // for turning the Bluetooth device off
  void _sendOffMessageToBluetooth() async {
    connection.output.add(utf8.encode("0" + "\r\n"));
    await connection.output.allSent;
    show('Device Turned Off');
    setState(() {
      _deviceState = -1; // device off
    });
  }

  // Method to show a Snackbar,
  // taking message as the text
  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        key: _scaffoldKey,
        content: new Text(
          message,
        ),
        duration: duration, //ScaffoldMessenger
      ),
    );
  }
}

/*
 actions: [
          Icon(Icons.bluetooth),
          


          SizedBox(width: 5.0),
          //IconButton(icon: Icon(Icons.bluetooth_searching), onPressed: () {})
        ],
*/
