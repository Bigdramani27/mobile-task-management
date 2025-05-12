import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Color?>> _colorAnimations;
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    // Initialize controllers and animations for each letter
    _controllers = [];

    // Start initialization of services
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      // Check user authentication status
      final user = FirebaseAuth.instance.currentUser;

      // Navigate after a delay to allow splash screen animation to complete
      Timer(Duration(seconds: 1), () {
        setState(() {
          _visible = false;
        });

        // Delay before navigating to the next screen
        Timer(Duration(seconds: 1), () {
          if (user != null) {
            // If user is logged in, navigate to the home page
            context.go("/home");
          } else {
            // If user is not logged in, navigate to the login page
            context.go("/login");
          }
        });
      });
    } catch (e) {
      print("Initialization error: $e");
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/logo.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
