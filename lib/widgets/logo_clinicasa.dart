import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoClinicasa extends StatelessWidget {
  final double height;
  final VoidCallback? onTap;
  const LogoClinicasa({super.key, this.height = 110, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;
    Widget logo = Column(
      children: [
        SvgPicture.asset('assets/images/logo_clinicasa.svg', height: height),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
            children: [
              TextSpan(
                text: 'Clini',
                style: TextStyle(color: green),
              ),
              const TextSpan(
                text: 'Casa',
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: logo);
    }
    return logo;
  }
}
