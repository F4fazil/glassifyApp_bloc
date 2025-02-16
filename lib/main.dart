import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/authentication/authBloc/authBloc.dart';
import 'package:flutterbloc/firebase_options.dart';

import 'ui/OnboardScreens/OnBoardScreen.dart';
import 'ui/layers/screens/homeScreen.dart';
import 'ui/layers/screens/orderScreen.dart';
import 'ui/layers/signInScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => Authbloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
       ),
      );
  }
}

