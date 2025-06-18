import 'package:flutter/material.dart';
import 'dart:async';

class PaymentConfirmationScreen extends StatefulWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  State<PaymentConfirmationScreen> createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen>
    with TickerProviderStateMixin {
  bool _showCheck = false;
  late AnimationController _checkController;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showCheck = true;
      });
      _checkController.forward();
    });
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;
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
                  'Pagamento',
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
              child: Center(
                child: Container(
                  width: 360,
                  height: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0,
                  ),
                  decoration: BoxDecoration(color: green),
                  child: Center(
                    child: _showCheck
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: _checkController,
                                builder: (context, child) {
                                  return CustomPaint(
                                    size: const Size(100, 100),
                                    painter: _CheckPainter(
                                      _checkController.value,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 32),
                              const Text(
                                'Agendamento\nconfirmado',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                  strokeWidth: 8,
                                ),
                              ),
                              const SizedBox(height: 32),
                              const Text(
                                'Carregando\nagendamento',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
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
