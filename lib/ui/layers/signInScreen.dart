import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/authentication/authBloc/authBloc.dart';
import 'package:flutterbloc/authentication/authState/authState.dart';
import 'package:flutterbloc/authentication/events/authEvent.dart';
import 'package:flutterbloc/ui/components/button/login_signup_btn.dart';
import 'package:flutterbloc/ui/layers/screens/homeScreen.dart';
import 'package:flutterbloc/ui/layers/signupScreen.dart';
import '../components/lottie/lottieLoading.dart';
import '../components/textfield/textfield.dart';
import 'screens/phoneOtpScreen.dart';
import 'widgets/headerLogo.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  LoginScreen({super.key});

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

              // Email TextField
              MyTextField(
                controller: _emailController,
                icon: const Icon(Icons.email),
                hintText: 'Email',
              ),
              const SizedBox(height: 20),

              // Password TextField
              MyTextField(
                controller: _passwordController,
                icon: const Icon(Icons.password),
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 40),

              // Sign In Button
              BlocConsumer<Authbloc, Authstate>(
                listener: (context, state) {
                  if (state is Authenticated || state is GoogleAuthenticated) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  HomeScreen(),
                      ),
                    );
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Lottieloading();
                  }
                  return Column(
                    children: [
                      MyButton(
                        onPressed: () {
                          context.read<Authbloc>().add(
                                SignInRequested(
                                  _emailController.text,
                                  _passwordController.text,
                                ),
                              );
                        },
                        text: 'Sign In',
                      ),
                      const SizedBox(height: 20),

                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black, // Color of the divider
                              thickness: 0.5, // Thickness of the divider
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    8.0), // Space between text and dividers
                            child: Text(
                              "Or Sign With",
                              style: TextStyle(
                                color: Colors.black, // Text color
                                fontSize: 14, // Text size
                                fontWeight: FontWeight.w400, // Text weight
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black, // Color of the divider
                              thickness: 0.5, // Thickness of the divider
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Google Sign-In Button or Phone
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildThirdPartyLogin(
                            context,
                            'assets/google_logo.png', // Image path
                            () {
                              // Your onPressed logic here
                              context
                                  .read<Authbloc>()
                                  .add(GoogleSignInRequested());
                            },
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          buildThirdPartyLogin(
                            context,
                            'assets/phone.png', // Image path
                            () {
                              // Your onPressed logic here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const  PhoneAuthScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Phone Authentication Buttons
                    ],
                  );
                },
              ),

              // Sign Up TextButton
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildThirdPartyLogin(
      BuildContext context, String imagepath, VoidCallback onPress) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.14,
      height: MediaQuery.of(context).size.width *
          0.14, // Set a height to make it square
      child: OutlinedButton(
        onPressed: onPress,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets
              .zero, // Remove padding to allow the image to fill the button
          side: const BorderSide(color: Colors.white10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Image.asset(
          imagepath, // Ensure this path is correct
          fit: BoxFit.cover, // Make the image cover the entire button
        ),
      ),
    );
  }
}
