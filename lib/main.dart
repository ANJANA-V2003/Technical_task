import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_task/Provider/login_provider.dart';
import 'package:technical_task/Splash_screen.dart';

import 'Provider/auth_provider.dart';

void main() {
  runApp(
      const MyApp()
    // ChangeNotifierProvider(
    //   create: (context) => AuthProvider(),
    //   child: MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash_Screen(),
      ),
    );
  }
}
