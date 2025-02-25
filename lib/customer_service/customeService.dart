import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
           height: 20,
          ),
          // Top Bar with Back and Menu Buttons
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color.fromARGB(255, 32, 173, 220),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                    onPressed: () {
                      // Handle back button press
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black),
                    onPressed: () {
                      // Handle menu button press
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5 - 64, // Adjust height to account for top bar
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color.fromARGB(255, 32, 173, 220),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Support',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: "Poppins"),
                ),
                SizedBox(height: 8),
                Text(
                  'How can we help you today?',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Choose an option below to get started.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Remaining Half-Height Container with Chat, FAQs, and Email Options
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Chat Option
                  _buildOptionContainer(
                    icon: Icons.chat,
                    title: 'Chat',
                    subtitle: 'Talk to our support team in real-time.',
                  ),
                  const SizedBox(height: 16),
                  // FAQs Option
                  _buildOptionContainer(
                    icon: Icons.help_outline,
                    title: 'FAQs',
                    subtitle: 'Find answers to common questions.',
                  ),
                  const SizedBox(height: 16),
                  // Email Option
                  _buildOptionContainer(
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: 'Send us an email for assistance.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Method to Build Option Containers
  Widget _buildOptionContainer({required IconData icon, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}