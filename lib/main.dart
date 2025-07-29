import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_task/Provider/login_provider.dart';
import 'package:technical_task/Provider/result_provider.dart';
import 'package:technical_task/Provider/streams_provider.dart';
import 'package:technical_task/Provider/profile_provider.dart';
import 'package:technical_task/screens/auth/login/Login_page.dart';
import 'package:technical_task/screens/intro/Splash_screen.dart';
import 'package:technical_task/screens/main/activity/bottomnavigation_streams.dart';
import 'package:technical_task/screens/main/activity/example.dart';
// import 'package:technical_task/screens/main/activity/image_picker.dart';

import 'package:technical_task/screens/main/activity/navigationbar.dart';
import 'package:technical_task/screens/main/activity/streams_screen.dart';

import 'Provider/auth_provider.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider(create: (_) => AllStreamsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ResultProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash_Screen(),
      ),
    );
  }
}
