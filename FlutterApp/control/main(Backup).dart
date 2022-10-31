import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;

RawDatagramSocket udpSocket() {
  var socket;
  RawDatagramSocket.bind(InternetAddress.anyIPv4, 1234).then((builtSocket) {
    socket = builtSocket;
  });
  return socket;
}

var completeSocket = udpSocket();

void sendData(data) {
  completeSocket.send(
      Utf8Codec().encode(data), InternetAddress("127.20.10.4"), 1234);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isIOS || Platform.isAndroid) {
  //   SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
  //       .then((_) {
  //     runApp(const MyApp());
  //   });
  // } else {
  runApp(const MyApp());
  //}

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _value = 1;
  String rpi = "ws://172.20.10.4:1234";
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
                    stick: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width / 12,
                          MediaQuery.of(context).size.width / 12),
                      painter: CirclePainter(),
                    ),
                    base: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width / 4.5,
                          MediaQuery.of(context).size.width / 4.5),
                      painter: CirclePainter2(),
                    ),
                    // onStickDragEnd: () {
                    //   var channel =
                    //       IOWebSocketChannel.connect(Uri.parse('ws://localhost:1234'));
                    //   channel.sink.add("end");
                    // },
                    listener: (details) {
                      var channel = WebSocketChannel.connect(Uri.parse(rpi));
                      if (details.x > details.y) {
                        if (details.x > 0.2) {
                          sendData("br");
                          channel.sink.add("br"); //base right
                        } else if (details.x < 0.2) {
                          channel.sink.add("rf"); //reach forward
                        }
                      } else {
                        if (details.y > 0.2) {
                          channel.sink.add("rb"); //reach back
                        } else if (details.y < 0.2) {
                          channel.sink.add("bl"); //base left
                        }
                      }
                    }),
                Joystick(
                    stick: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width / 12,
                          MediaQuery.of(context).size.width / 12),
                      painter: CirclePainter(),
                    ),
                    base: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width / 4.5,
                          MediaQuery.of(context).size.width / 4.5),
                      painter: CirclePainter2(),
                    ),
                    // onStickDragEnd: () {
                    //   var channel =
                    //       IOWebSocketChannel.connect(Uri.parse('ws://localhost:1234'));
                    //   channel.sink.add("end");
                    // },
                    listener: (details) {
                      var channel = WebSocketChannel.connect(Uri.parse(rpi));
                      if (details.x > details.y) {
                        if (details.x > 0.2) {
                          channel.sink.add("co"); //claw open
                        } else if (details.x < 0.2) {
                          channel.sink.add("wf"); //wrist forward
                        }
                      } else {
                        if (details.y > 0.2) {
                          channel.sink.add("wb"); //wrist back
                        } else if (details.y < 0.2) {
                          channel.sink.add("cc"); //claw close
                        }
                      }
                    }),
                Joystick(
                    stick: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width / 12,
                          MediaQuery.of(context).size.width / 12),
                      painter: CirclePainter(),
                    ),
                    base: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width / 4.5,
                          MediaQuery.of(context).size.width / 4.5),
                      painter: CirclePainter2(),
                    ),
                    // onStickDragEnd: () {
                    //   var channel =
                    //       IOWebSocketChannel.connect(Uri.parse('ws://localhost:1234'));
                    //   channel.sink.add("end");
                    // },
                    listener: (details) {
                      var channel = WebSocketChannel.connect(Uri.parse(rpi));
                      if (details.x > details.y) {
                        if (details.x > 0.2) {
                          channel.sink.add("rr"); //rotate claw right
                        } else if (details.x < 0.2) {
                          channel.sink.add("ef"); //elbow forward
                        }
                      } else {
                        if (details.y > 0.2) {
                          channel.sink.add("eb"); //elbow back
                        } else if (details.y < 0.2) {
                          channel.sink.add("rl"); //rotate claw left
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
                child: Column(
                  children: <Widget>[
                    Text("${_value.toInt()}"),
                    Slider(
                      min: 1,
                      max: 9,
                      divisions: 8,
                      value: _value,
                      onChanged: (value) {
                        setState2(() {
                          _value = value;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Set'),
              onPressed: () {
                var channel = WebSocketChannel.connect(Uri.parse(rpi));
                channel.sink.add("${_value.toInt()}");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = Colors.red[900]!
    ..strokeWidth = 2
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CirclePainter2 extends CustomPainter {
  final _paint = Paint()
    ..color = Colors.red[400]!
    ..strokeWidth = 2
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
