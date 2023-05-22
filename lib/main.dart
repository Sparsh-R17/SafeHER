import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/providers/internet_connectivity.dart';
import 'firebase_options.dart';
import 'providers/trigger.dart';
import 'screens/main_screen.dart';
import 'screens/register_screen.dart';

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
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
            ),
            home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const MainScreen();
                  } else {
                    return const RegisterScreen();
                  }
                }),
          );
        },
      ),
    );
  }
}
