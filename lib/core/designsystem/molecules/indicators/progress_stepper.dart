import 'package:flutter/material.dart';
import 'package:mibook/core/designsystem/atoms/colors.dart';

class ProgressStepper extends StatelessWidget {
  final double progress;

  const ProgressStepper({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Progress: ${(progress * 100).toStringAsFixed(1)}%'),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(background),
        ),
      ],
    );
  }
}
