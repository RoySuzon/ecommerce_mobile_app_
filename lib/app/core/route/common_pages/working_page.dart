import 'package:flutter/material.dart';

class WorkingPage extends StatelessWidget {
  final String message;

  const WorkingPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Notice'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Clean icon
              Icon(
                Icons.work_outline,
                size: 80,
                color: Colors.blueGrey[400],
              ),
              const SizedBox(height: 24),

              // Message
              Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Go back button
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Colors.blueGrey[700],
                //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                //   textStyle: const TextStyle(fontSize: 16),
                // ),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
