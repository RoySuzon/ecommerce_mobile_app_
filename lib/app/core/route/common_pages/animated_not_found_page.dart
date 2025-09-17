import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedNotFoundPage extends StatefulWidget {
  const AnimatedNotFoundPage({super.key});

  @override
  State<AnimatedNotFoundPage> createState() => _AnimatedNotFoundPageState();
}

class _AnimatedNotFoundPageState extends State<AnimatedNotFoundPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Create a curved animation for a smoother "float" effect
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated floating robot
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        10 * math.sin(_controller.value * 2 * math.pi),
                      ),
                      child: child,
                    );
                  },
                  child: const LostRobot(),
                ),
                const SizedBox(height: 40),

                // Title Text
                const Text(
                  'Oh no, you\'re lost!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle Text
                Text(
                  "The page you are looking for doesn't exist. But don't worry, we can get you back on track.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),

                // Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black.withOpacity(0.2),
                  ),
                  child: const Text(
                    'Back to Safety',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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

// Widget for the custom-painted robot
class LostRobot extends StatelessWidget {
  const LostRobot({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 200,
      child: CustomPaint(
        painter: CoolRobotPainter(),
      ),
    );
  }
}

class CoolRobotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      // Shadow under robot
      ..color = Colors.black.withOpacity(0.1);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.9),
        width: size.width * 0.6,
        height: size.height * 0.08,
      ),
      paint,
    );

    // Body
    paint.color = const Color(0xFF90CAF9); // Light blue
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.2,
          size.height * 0.35,
          size.width * 0.6,
          size.height * 0.5,
        ),
        const Radius.circular(24),
      ),
      paint,
    );

    // Head
    paint.color = const Color(0xFF42A5F5); // Darker blue
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.25,
          size.height * 0.15,
          size.width * 0.5,
          size.height * 0.25,
        ),
        const Radius.circular(20),
      ),
      paint,
    );

    // Antenna
    paint.color = const Color(0xFF1E88E5);
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.48,
        size.height * 0.05,
        4,
        size.height * 0.1,
      ),
      paint,
    );

    paint.color = Colors.amber;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.05), 6, paint);

    // Eyes
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width * 0.38, size.height * 0.25),
      size.width * 0.06,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.25),
      size.width * 0.06,
      paint,
    );

    // Pupils
    paint.color = Colors.black;
    canvas.drawCircle(
      Offset(size.width * 0.38, size.height * 0.25),
      size.width * 0.03,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.25),
      size.width * 0.03,
      paint,
    );

    // Mouth
    paint.color = Colors.black;
    final mouthPath = Path();
    mouthPath.moveTo(size.width * 0.38, size.height * 0.33);
    mouthPath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.38,
      size.width * 0.62,
      size.height * 0.33,
    );
    canvas.drawPath(mouthPath, paint);

    // Arms
    paint.color = const Color(0xFF90CAF9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.05,
          size.height * 0.45,
          size.width * 0.15,
          size.height * 0.15,
        ),
        const Radius.circular(12),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.8,
          size.height * 0.45,
          size.width * 0.15,
          size.height * 0.15,
        ),
        const Radius.circular(12),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
