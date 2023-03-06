import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'KAVACH',
      home: ValueScreen(),
    );
  }
}

class ValueScreen extends StatefulWidget {
  const ValueScreen({super.key});

  @override
  State<ValueScreen> createState() => _ValueScreenState();
}

class _ValueScreenState extends State<ValueScreen> {
  bool _valueRun = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _valueRun
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder<AccelerometerEvent>(
                    stream: SensorsPlatform.instance.accelerometerEvents,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Accelerometer Reading',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(' X : ${snapshot.data!.x.toString()}'),
                          Text(' Y : ${snapshot.data!.y.toString()}'),
                          Text(' Z : ${snapshot.data!.z.toString()}'),
                        ],
                      );
                    },
                  ),
                  StreamBuilder<GyroscopeEvent>(
                    stream: SensorsPlatform.instance.gyroscopeEvents,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Gyroscope Reading',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(' X : ${snapshot.data!.x.toString()}'),
                          Text(' Y : ${snapshot.data!.y.toString()}'),
                          Text(' Z : ${snapshot.data!.z.toString()}'),
                        ],
                      );
                    },
                  ),
                  StreamBuilder<MagnetometerEvent>(
                    stream: SensorsPlatform.instance.magnetometerEvents,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Magnetometer Reading',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(' X : ${snapshot.data!.x.toString()}'),
                          Text(' Y : ${snapshot.data!.y.toString()}'),
                          Text(' Z : ${snapshot.data!.z.toString()}'),
                        ],
                      );
                    },
                  ),
                ],
              )
            : const Text(
                'Press Start',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _valueRun = !_valueRun;
          });
        },
        child: Icon(
          _valueRun ? Icons.stop : Icons.play_arrow,
        ),
      ),
    );
  }
}
