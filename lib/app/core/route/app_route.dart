import 'package:ecommerce_app/features/home/presentations/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:lottie/lottie.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String productsRoute = '/products';
  static const String productDetailsRoute = '/product-details';
  static const String categoryRoute = '/category';
  static const String expensesRoute = '/expenses';
  static const String reportsRoute = '/reports';
  static const String settingsRoute = '/settings';
  static const String homeRoute = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case dashboardRoute:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Dashboard Screen'),
            ),
          ),
        );
      default:
        // Fallback: show error page for unknown routes
        return MaterialPageRoute(
          builder: (_) => const LostInSpacePage(),
        );
    }

    // return
  }
}

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
        painter: RobotPainter(),
      ),
    );
  }
}

// Custom painter to draw the robot
class RobotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Body
    paint.color = const Color(0xFFD0D0D0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.1,
          size.height * 0.3,
          size.width * 0.8,
          size.height * 0.6,
        ),
        const Radius.circular(20),
      ),
      paint,
    );

    // Head
    paint.color = const Color(0xFFB0B0B0);
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.2),
      size.width * 0.3,
      paint,
    );

    // Antenna
    paint.color = const Color(0xFF808080);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.47, size.height * 0.0, 5, size.height * 0.1),
      paint,
    );
    paint.color = Colors.amber;
    canvas.drawCircle(Offset(size.width * 0.49, size.height * 0.0), 7, paint);

    // Eye
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.2),
      size.width * 0.15,
      paint,
    );
    paint.color = const Color(0xFF4A90E2);
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.2),
      size.width * 0.1,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

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

class ErrorPage extends StatelessWidget {
  final String message;

  const ErrorPage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Error Icon
                SizedBox(
                  width: 150,
                  height: 150,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: const Icon(
                      Icons.error_outline,
                      size: 150,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Message
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Go Back Button
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Go Back"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
