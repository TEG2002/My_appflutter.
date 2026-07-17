import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradientStatBar extends StatelessWidget {
  final String label;
  final double value;
  final String trailingText;
  final Gradient gradient;
  final IconData icon;

  const GradientStatBar({
    super.key,
    required this.label,
    required this.value,
    required this.trailingText,
    required this.gradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color themeColor = AppColors.primary;
    if (gradient is LinearGradient) {
      final lg = gradient as LinearGradient;
      if (lg.colors.isNotEmpty) {
        themeColor = lg.colors.first;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(icon, color: themeColor, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              trailingText,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              Container(
                height: 6,
                width: double.infinity,
                color: Colors.black.withOpacity(0.05),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: 6,
                    width: constraints.maxWidth * value.clamp(0.0, 1.0),
                    decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
