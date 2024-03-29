// // ignore_for_file: avoid_print

// import 'dart:async';
// import 'dart:io';

// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:kavach/providers/trigger.dart';
// import 'package:kavach/screens/trigger_screen.dart';
// import 'package:kavach/utils/app_dimension.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<Trigger>(
//           create: (context) => Trigger(),
//         ),
//       ],
//       child: Consumer<Trigger>(
//         builder: (context, tapTrigger, _) {
//           return MaterialApp(
//             title: 'Kavach',
//             home: tapTrigger.pageTrigger
//                 ? const TriggerScreen()
//                 : const ValueScreen(),
//           );
//         },
//       ),
//     );
//   }
// }

// class ValueScreen extends StatefulWidget {
//   const ValueScreen({super.key});

//   @override
//   State<ValueScreen> createState() => _ValueScreenState();
// }

// class _ValueScreenState extends State<ValueScreen> {
//   List<double> acclUser = [0, 0, 0];
//   List<double> displayAcclUser = [0, 0, 0];
//   List<double> gyroUser = [0, 0, 0];
//   List<double> displayGyroUser = [0, 0, 0];
//   List acclValueRecorded = [];
//   List gyroValueRecorded = [];

//   StreamSubscription? accel;
//   StreamSubscription? gyro;
//   Timer? time;
//   bool _start = false;
//   bool _permission = true;
//   int timerValue = 60;
//   var timeStamp = 0.000;
//   final controller = TextEditingController();

//   // void _sendSOS(String msg, List<String> recipients) async {
//   //   String result =
//   //       await sendSMS(message: msg, recipients: recipients).catchError((error) {
//   //     print(error);
//   //   });
//   //   print(result);
//   // }

//   //^ To convert list to csv file
//   getCsv(List finalValues, String sensor, String activity) async {
//     // if (await Permission.storage.isDenied) {
//     //   print('Hello');
//     //   await Permission.storage.request();
//     // } else {
//     //   print('HI');
//     // }

//     // if (await Permission.storage.isPermanentlyDenied) {
//     //   print('PD');
//     //   setState(() {
//     //     _permission = false;
//     //   });
//     // }

//     List<List<dynamic>> rows = [];

//     for (var data in finalValues) {
//       timeStamp += 0.050;
//       print(timeStamp);
//       rows.add([timeStamp, data[0], data[1], data[2], activity]);
//     }

//     String csvString = const ListToCsvConverter().convert(rows);

//     final dir = await getExternalStorageDirectory();

//     final file = File('${dir!.path}/$sensor.csv');

//     if (await file.exists()) {
//       print('File deletion done');
//       await file.delete();
//     }

//     print(rows);

//     await file.writeAsString(csvString);
//     // _sendSOS('Bachao koi PK ko ', ['+91 97470 16882']);
//     acclValueRecorded = [];
//     gyroValueRecorded = [];
//     rows = [];
//     timeStamp = 0;
//     print(rows);
//   }

//   //& Triggers the timer to track activity
//   void timerCreate(int userTime) {
//     accel = accelerometerEvents.listen((event) {
//       setState(() {
//         acclUser = [
//           double.parse(event.x.toStringAsFixed(4)),
//           double.parse(event.y.toStringAsFixed(4)),
//           double.parse(event.z.toStringAsFixed(4)),
//         ];
//       });
//     });
//     gyro = gyroscopeEvents.listen((event) {
//       setState(() {
//         gyroUser = [
//           double.parse(event.x.toStringAsFixed(4)),
//           double.parse(event.y.toStringAsFixed(4)),
//           double.parse(event.z.toStringAsFixed(4)),
//         ];
//       });
//     });

//     Timer.periodic(const Duration(milliseconds: 50), (timer) {
//       setState(() {
//         displayAcclUser = acclUser;
//         displayGyroUser = gyroUser;
//       });
//       acclValueRecorded.add(displayAcclUser);
//       gyroValueRecorded.add(displayGyroUser);

//       if (timer.tick % 20 == 0 && timer.tick != 0) {
//         setState(() {
//           timerValue--;
//         });
//         userTime--;
//       }
//       if (userTime == 0) {
//         print('timer over');
//         timer.cancel();
//         accel!.cancel();
//         gyro!.cancel();
//         setState(() {
//           _start = !_start;
//           timerValue = 60;
//         });
//         getCsv(acclValueRecorded, 'accl', controller.text.toUpperCase());
//         timeStamp = 0;
//         getCsv(gyroValueRecorded, 'gyro', controller.text.toUpperCase());
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _trigger = Provider.of<Trigger>(context);
//     return Scaffold(
//       body: Center(
//         child: _start
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Accelerometer Readings',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text('x : ${displayAcclUser[0].toStringAsFixed(4)}'),
//                   Text('y : ${displayAcclUser[1].toStringAsFixed(4)}'),
//                   Text('z : ${displayAcclUser[2].toStringAsFixed(4)}'),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   const Text(
//                     'Gyroscope Readings',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text('x : ${displayGyroUser[0].toStringAsFixed(4)}'),
//                   Text('y : ${displayGyroUser[1].toStringAsFixed(4)}'),
//                   Text('z : ${displayGyroUser[2].toStringAsFixed(4)}'),
//                   verticalSpacing(10),
//                   FilledButton(
//                     onPressed: _trigger.alertTrigger,
//                     child: const Text('Trigger'),
//                   ),
//                 ],
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     _permission ? 'Press Start' : 'Permission not given',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextFormField(
//                       controller: controller,
//                       decoration: const InputDecoration(
//                         labelText: 'Enter Activity',
//                       ),
//                     ),
//                   ),
//                   verticalSpacing(10),
//                   FilledButton(
//                     onPressed: _trigger.alertTrigger,
//                     child: const Text('Trigger'),
//                   ),
//                 ],
//               ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         icon: Icon(
//           _start ? Icons.pause : Icons.play_arrow,
//         ),
//         label: Text('$timerValue'),
//         onPressed: () {
//           setState(() {
//             _start = !_start;
//           });
//           timerCreate(timerValue);
//         },
//       ),
//     );
//   }
// }
