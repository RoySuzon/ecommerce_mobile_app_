import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LostInSpacePage extends StatelessWidget {
  const LostInSpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Deep space blue
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Use a Lottie animation for a cool, dynamic visual
              Lottie.asset(
                'assets/animations/error.json', // Your Lottie animation file
                height: 250,
                reverse: true,
                // frameBuilder: (context, child, composition) =>
                // Text('data'),
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              // Use a custom, attention-grabbing font
              const Text(
                'Lost in Space?',
                style: TextStyle(
                  fontFamily: 'Montserrat', // A more modern, geometric font
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "It looks like this planet doesn't exist.",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: Color(0xFF94A9C4), // A soft grey for contrast
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.rocket_launch, color: Color(0xFF1A1A2E)),
                label: const Text(
                  'Launch Back Home',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFFE5C16C,
                  ), // A bright accent color
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
