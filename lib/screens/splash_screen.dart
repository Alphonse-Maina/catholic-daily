import 'package:catholic_daily/main.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation: scale logo from 0.6 to 1.0
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation =
        Tween<double>(begin: 0.6, end: 1.0).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutBack,
        ));

    _controller.forward();

    // Navigate to HomePage after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenColor = Colors.white; // background

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Stack(
          fit: StackFit.expand,
            children: [
              // Full-screen background image
              Image.asset(
                'assets/app/about.png',
                fit: BoxFit.fill,
              ),
              // Blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // adjust for stronger/weaker blur
                child: Container(
                  color: Colors.black.withOpacity(0), // required, transparent overlay
                ),
              ),
              // Logo + text at bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Image.asset(
                          'assets/app/vexaryn_logo.png',
                          height: 60,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Powered by VexaRyn",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}