import 'package:flutter/material.dart';
import 'dart:async';

class ConfirmationScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String nextRoute;

  const ConfirmationScreen({
    super.key,
    this.title = 'Pagamento',
    this.subtitle = 'Processando...',
    this.nextRoute = '/home',
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with TickerProviderStateMixin {
  bool _showCheck = false;
  late AnimationController _checkController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showCheck = true;
      });
      _checkController.forward();
    });
    Future.delayed(const Duration(seconds: 4), () async {
      await _fadeController.forward();
      if (mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(widget.nextRoute, (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _checkController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFB0B0B0),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FadeTransition(
                opacity: ReverseAnimation(_fadeAnimation),
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
                    child: _showCheck
                        ? AnimatedBuilder(
                            animation: _checkController,
                            builder: (context, child) {
                              return CustomPaint(
                                size: const Size(220, 220),
                                painter: _CheckPainter(_checkController.value),
                              );
                            },
                          )
                        : const SizedBox(
                            width: 140,
                            height: 140,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 10,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Mantém a classe PaymentConfirmationScreen para compatibilidade
class PaymentConfirmationScreen extends StatelessWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConfirmationScreen(
      title: 'Pagamento',
      subtitle: 'Processando pagamento...',
      nextRoute: '/home',
    );
  }
}

class _CheckPainter extends CustomPainter {
  final double progress; // 0.0 a 1.0
  _CheckPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.22, size.height * 0.55);
    path.lineTo(size.width * 0.45, size.height * 0.75);
    path.lineTo(size.width * 0.78, size.height * 0.32);

    final totalLength = _calculatePathLength(path);
    final currentLength = totalLength * progress;
    final metric = path.computeMetrics().first;
    final extractPath = metric.extractPath(0, currentLength);
    canvas.drawPath(extractPath, paint);
  }

  double _calculatePathLength(Path path) {
    double length = 0.0;
    for (final metric in path.computeMetrics()) {
      length += metric.length;
    }
    return length;
  }

  @override
  bool shouldRepaint(covariant _CheckPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
