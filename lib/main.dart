import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:kavach/providers/internet_connectivity.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'providers/trigger.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Trigger>(
          create: (context) => Trigger(),
        ),
        ChangeNotifierProvider<InternetConnection>(
          create: (context) => InternetConnection(),
        )
      ],
      child: Consumer<Trigger>(
        builder: (context, value, child) {
          // final toShowDialong = value.pageTrigger;

          return MaterialApp(
            title: 'Kavach',
            themeMode: ThemeMode.system,
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
            ),
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
