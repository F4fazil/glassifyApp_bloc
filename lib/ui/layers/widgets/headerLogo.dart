
import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 120, // Adjust the height as needed
      decoration:const  BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/logo.png'), // Replace with your logo path
          fit: BoxFit.contain, // Ensures the logo fits nicely
        ),
      ),
    );
  }
}