import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app/SignIn.dart';
import 'package:app/home.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(

    MaterialApp(
      home: SignIn(),
      routes: {'/home': (context) => Home(),'/sign_in': (context) => SignIn()},
    )
  );
}

