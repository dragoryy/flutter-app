import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first/firebase_options.dart';
import 'package:first/pages/about.dart';
import 'package:first/pages/auth.dart';
import 'package:first/pages/students.dart';
import 'package:flutter/material.dart';
import 'package:first/pages/home.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Образовательное учрежедние',
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case AuthView.routeName:
                return const AuthView();
              case About.routeName:
                return const About();
              case Home.routeName:
                return const Home();
              case Students.routeName:
                return const Students();
              default:
                return const Home();
            }
          },
        );
      },
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/auth' : '/',
    );
  }
}
