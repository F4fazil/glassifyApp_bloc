import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/authentication/authBloc/authBloc.dart';
import 'package:flutterbloc/authentication/authState/authState.dart';
import 'package:flutterbloc/authentication/events/authEvent.dart';
import 'package:flutterbloc/ui/components/button/login_signup_btn.dart';
import 'package:flutterbloc/ui/layers/screens/homeScreen.dart';
import 'package:flutterbloc/ui/layers/signInScreen.dart';

import '../components/lottie/lottieLoading.dart';
import '../components/textfield/textfield.dart';
import 'widgets/headerLogo.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
               const SizedBox(
                height: 40,
              ),
              // image logo container
              const LogoHeader(),
              
              const SizedBox(
                height: 120,
              ),
              MyTextField(
                controller: _emailController,
                icon: const Icon(Icons.email),
                hintText: 'Email',
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: _passwordController,
                icon: const Icon(Icons.password),
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 40),
              BlocConsumer<Authbloc, Authstate>(
                listener: (context, state) {
                  if (state is Authenticated) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  HomeScreen()));
                  } else if (state is AuthError) {
                    Future.delayed(const Duration(seconds: 0), () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    });
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Lottieloading();
                  }
                  return MyButton(
                    onPressed: () {
                      context.read<Authbloc>().add(
                            SignupIsRequested(
                              _emailController.text,
                              _passwordController.text,
                            ),
                          );
                    },
                    text: 'Sign Up',
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text('Already have an account? Sign In',style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
