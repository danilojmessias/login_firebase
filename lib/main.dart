import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/pages/notes_page.dart';
import 'package:login_firebase/pages/teste_note.dart';
import 'package:login_firebase/services/auth_service.dart';
import 'package:login_firebase/widgets/auth_check.dart';
import 'package:provider/provider.dart';
import 'package:login_firebase/pages/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purpleAccent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => const AuthCheck(),
        '/notes': (context) => const NotesPage(),
        '/home': (context) => const Home(),
      },
    );
  }
}
