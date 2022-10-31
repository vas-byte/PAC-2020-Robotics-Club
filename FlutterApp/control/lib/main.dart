import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 1234);
  runApp(MyApp(socket: socket));

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.red,
  ));
}

class MyApp extends StatelessWidget {
  final RawDatagramSocket socket;
  const MyApp({Key? key, required this.socket}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(socket: socket),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final RawDatagramSocket socket;

  const MyHomePage({super.key, required this.socket});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _value = 1;

  void sendData(String data) {
    widget.socket
        .send(Utf8Codec().encode(data), InternetAddress("172.20.10.4"), 1234);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Joystick Controls"),
          leading: GestureDetector(
            onTap: () {
              _showMyDialog();
            },
            child: const Icon(
              Icons.settings,
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
                    listener: (details) {
                      if (details.x > details.y) {
                        if (details.x > 0.2) {
                          sendData("br");
                        } else if (details.x < 0.2) {
                          sendData("rf");
                        }
                      } else {
                        if (details.y > 0.2) {
                          sendData("rb");
                        } else if (details.y < 0.2) {
                          sendData("bl");
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
                    listener: (details) {
                      if (details.x > details.y) {
                        if (details.x > 0.2) {
                          sendData("co");
                        } else if (details.x < 0.2) {
                          sendData("wf");
                        }
                      } else {
                        if (details.y > 0.2) {
                          sendData("wb");
                        } else if (details.y < 0.2) {
                          sendData("cc");
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
                    listener: (details) {
                      if (details.x > details.y) {
                        if (details.x > 0.2) {
                          sendData("rr");
                        } else if (details.x < 0.2) {
                          sendData("ef");
                        }
                      } else {
                        if (details.y > 0.2) {
                          sendData("eb");
                        } else if (details.y < 0.2) {
                          sendData("rl");
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
                sendData("${_value.toInt()}");
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
