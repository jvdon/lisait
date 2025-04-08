import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lisait/firebase_options.dart';
import 'package:lisait/pages/login_page.dart';
import 'package:lisait/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.black,
        appBarTheme: AppBarTheme(backgroundColor: Pallete.gray),
      ),
      home: LoginPage(),
    );
  }
}
