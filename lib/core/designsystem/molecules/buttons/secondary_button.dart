import 'package:flutter/material.dart';
import 'package:mibook/core/designsystem/atoms/colors.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final bool isExpanded;
  final bool isLoading;
  final VoidCallback onPressed;

  const SecondaryButton({
    super.key,
    required this.title,
    this.isEnabled = true,
    this.isExpanded = false,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: isExpanded ? double.infinity : null,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isEnabled ? primary : disabled,
            width: 1.0,
          ),
          foregroundColor: isEnabled ? primary : disabled,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
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
      ),
    );
  }
}
