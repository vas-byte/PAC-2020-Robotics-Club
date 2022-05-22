import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS || Platform.isAndroid) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
        .then((_) {
      runApp(const MyApp());
    });
  } else {
    runApp(const MyApp());
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.red,
    //statusBarIconBrightness: Brightness.dark
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _value = 1;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Joystick Controls"),

          leading: GestureDetector(
            onTap: () {
              _showMyDialog();
            },
            child: const Icon(
              Icons.settings, // add custom icons also
            ),
          ),
        ),
        bottomSheet: Container(
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Joystick(
                    stick: Container(
                      width: MediaQuery.of(context).size.width / 12,
                      height: MediaQuery.of(context).size.width / 12,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red[900],
                          border:
                              Border.all(width: 1, color: Colors.transparent)),
                    ),
                    base: Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      height: MediaQuery.of(context).size.width / 4.5,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red[400],
                          border:
                              Border.all(width: 1, color: Colors.transparent)),
                    ),
                    // onStickDragEnd: () {
                    //   var channel =
                    //       IOWebSocketChannel.connect(Uri.parse('ws://localhost:1234'));
                    //   channel.sink.add("end");
                    // },
                    listener: (details) {
                      var channel = IOWebSocketChannel.connect(
                          Uri.parse('ws://localhost:1234'));
                      if (details.x > details.y) {
                        if (details.x > 0.2) {
                          channel.sink.add("right");
                        } else if (details.x < 0.2) {
                          channel.sink.add("up");
                        }
                      } else {
                        if (details.y > 0.2) {
                          channel.sink.add("down");
                        } else if (details.y < 0.2) {
                          channel.sink.add("left");
                        }
                      }
                    }),
                Joystick(
                    stick: Container(
                      width: MediaQuery.of(context).size.width / 12,
                      height: MediaQuery.of(context).size.width / 12,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red[900],
                          border:
                              Border.all(width: 1, color: Colors.transparent)),
                    ),
                    base: Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      height: MediaQuery.of(context).size.width / 4.5,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red[400],
                          border:
                              Border.all(width: 1, color: Colors.transparent)),
                    ),
                    // onStickDragEnd: () {
                    //   var channel =
                    //       IOWebSocketChannel.connect(Uri.parse('ws://localhost:1234'));
                    //   channel.sink.add("end");
                    // },
                    listener: (details) {
                      var channel = IOWebSocketChannel.connect(
                          Uri.parse('ws://localhost:1234'));
                      if (details.x > details.y) {
                        if (details.x > 0.2) {
                          channel.sink.add("right");
                        } else if (details.x < 0.2) {
                          channel.sink.add("up");
                        }
                      } else {
                        if (details.y > 0.2) {
                          channel.sink.add("down");
                        } else if (details.y < 0.2) {
                          channel.sink.add("left");
                        }
                      }
                    }),
              ],
            ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adjust Sensitivity'),
          content: StatefulBuilder(
            builder: (context, setState2) {
              return SizedBox(
                width: 250,
                height: 75,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text("${_value.toInt()}%"),
                      Slider(
                        min: 1,
                        max: 100,
                        divisions: 10,
                        value: _value,
                        onChanged: (value) {
                          setState2(() {
                            _value = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Set'),
              onPressed: () {
                var channel = IOWebSocketChannel.connect(
                    Uri.parse('ws://localhost:1234'));
                channel.sink.add("${(_value / 10).toInt()}");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
