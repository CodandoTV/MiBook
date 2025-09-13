import 'package:flutter/material.dart';
import 'package:mibook/core/designsystem/atoms/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final bool isExpanded;
  final bool isLoading;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.title,
    this.isEnabled = true,
    this.isExpanded = false,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? primary : disabled,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        minimumSize: const Size(80, 48),
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(title),
    );

    if (isExpanded) {
      return SizedBox(
        height: 48,
        width: double.infinity,
        child: button,
      );
    } else {
      return SizedBox(
        height: 48,
        child: button,
      );
    }
  }
}
