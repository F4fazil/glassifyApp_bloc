import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/authentication/authBloc/authBloc.dart';
import 'package:flutterbloc/authentication/events/authEvent.dart';
import 'package:flutterbloc/ui/components/button/login_signup_btn.dart';

import '../signInScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: MyButton(
          onPressed: () {
            context.read<Authbloc>().add(LogoutIsRequested());
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          text: 'Sign Out',
        ),
      ),
    );
  }
}