import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/authentication/authBloc/authBloc.dart';
import 'package:flutterbloc/authentication/authState/authState.dart';
import 'package:flutterbloc/authentication/events/authEvent.dart';
import 'package:flutterbloc/ui/layers/screens/homeScreen.dart';
import 'package:flutterbloc/ui/layers/signInScreen.dart';
class SignupScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            BlocConsumer<Authbloc, Authstate>(
              listener: (context, state) {
                if (state is Authenticated) {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const  HomeScreen()));
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<Authbloc>().add(
                      SignupIsRequested(
                        _emailController.text,
                        _passwordController.text,
                      ),
                    );
                  },
                  child: const Text('Sign Up'),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: const Text('Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}