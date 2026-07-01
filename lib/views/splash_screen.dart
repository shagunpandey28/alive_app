import 'package:alive_app/views/login_screen.dart';
import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────
///  SPLASH SCREEN TEMPLATE
///  Style : Material Design
///  State : setState
///
///  HOW TO USE:
///  1. Replace 'AppName' with your app name.
///  2. Replace the icon with your logo asset:
///       Image.asset('assets/logo.png', width: 120)
///  3. Change _navigateTo() to your first route.
///  4. Adjust _splashDuration if needed.
/// ─────────────────────────────────────────────

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ── CONFIG ──────────────────────────────────
  static const Duration _splashDuration = Duration(seconds: 3);
  static const String _appName = 'Alive'; 
  // ────────────────────────────────────────────

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(_splashDuration);
    if (!mounted) return;
    _navigateTo();
  }

  void _navigateTo() {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Logo / Icon ──────────────────
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Image.asset('assets/alive_logo.png'),
                ),

                const SizedBox(height: 32),

                // ── App Name ─────────────────────
                Text(
                  _appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),



                const SizedBox(height: 64),

                // ── Loading Indicator ────────────
                SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.7),
                    strokeWidth: 3,
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