import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/authentication/authBloc/authBloc.dart';
import 'package:flutterbloc/authentication/authState/authState.dart';
import 'package:flutterbloc/authentication/events/authEvent.dart';
import '../../components/button/login_signup_btn.dart';
import '../../components/lottie/lottieLoading.dart';
import '../../components/textfield/textfield.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            MyTextField(
              controller: _phoneController,
              icon: const Icon(Icons.phone),
              hintText: 'Phone Number',
            ),
            const SizedBox(height: 30),
            BlocBuilder<Authbloc, Authstate>(
              builder: (context, state) {
                if (state is OtpSentState) {
                  return Column(
                    children: [
                      MyTextField(
                        controller: _otpController,
                        icon: const Icon(Icons.message),
                        hintText: 'Enter OTP',
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            BlocConsumer<Authbloc, Authstate>(
              listener: (context, state) {
                if (state is Authenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Phone Auth Successful')),
                  );
                  Navigator.pop(context);
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
                return BlocBuilder<Authbloc, Authstate>(
                  builder: (context, state) {
                    if (state is OtpSentState) {
                      return MyButton(
                        onPressed: () {
                          context.read<Authbloc>().add(
                                VerifyOtpEvent(
                                  _otpController.text,
                                  state.verificationId,
                                ),
                              );
                        },
                        text: 'Verify OTP',
                      );
                    } else {
                      return MyButton(
                        onPressed: () {
                          final String phoneNumber =
                              '+92${_phoneController.text}';
                          context
                              .read<Authbloc>()
                              .add(SendOtpEvent(phoneNumber));
                        },
                        text: 'Send OTP',
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
