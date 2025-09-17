import 'package:flutter/material.dart';

class NotFoundPageNoImage extends StatelessWidget {
  const NotFoundPageNoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon placeholder instead of an image
                Icon(
                  Icons.search_off_rounded,
                  size: 150,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 40),

                // "Page not found" title text
                const Text(
                  'Page not found',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748), // A dark grey color
                  ),
                ),
                const SizedBox(height: 16),

                // Subtitle text
                const Text(
                  "We can't seem to find the page you are looking for",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),

                // "Go to Homepage" button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3182CE), // Blue color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
