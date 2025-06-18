import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeOutController;
  late Animation<double> _fadeOutAnimation;

  late AnimationController _logoController;
  late Animation<double> _logoFade;
  late Animation<double> _logoScale;

  late AnimationController _textController;
  late Animation<double> _textFade;
  late Animation<double> _textScale;

  @override
  void initState() {
    super.initState();
    _fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeOutAnimation = CurvedAnimation(
      parent: _fadeOutController,
      curve: Curves.easeOut,
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _logoFade = CurvedAnimation(parent: _logoController, curve: Curves.easeIn);
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _textFade = CurvedAnimation(parent: _textController, curve: Curves.easeIn);
    _textScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.elasticOut),
    );

    // SVG aparece em 1s
    Future.delayed(const Duration(milliseconds: 750), () {
      _logoController.forward();
    });
    // Texto aparece em 1.75s
    Future.delayed(const Duration(milliseconds: 1250), () {
      _textController.forward();
    });
    // 3.25s: inicia fade out e navega
    Future.delayed(const Duration(milliseconds: 2500), () async {
      await _fadeOutController.forward();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    _fadeOutController.dispose();
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: ReverseAnimation(_fadeOutAnimation),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF197E37), Color(0xFF105023)],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _logoScale,
                  child: FadeTransition(
                    opacity: _logoFade,
                    child: SvgPicture.asset(
                      'assets/images/logo_clinicasa_white.svg',
                      width: 120,
                      height: 110,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ScaleTransition(
                  scale: _textScale,
                  child: FadeTransition(
                    opacity: _textFade,
                    child: const Text(
                      'CliniCasa',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        fontFamily: 'Inter',
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
