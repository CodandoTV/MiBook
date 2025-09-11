import 'package:flutter/material.dart';
import 'package:mibook/core/designsystem/atoms/colors.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isEnabled;
  final String placeholder;
  final String? suffixText;
  final String? prefixText;
  final TextInputType? keyboardType;
  final Function(String) onChanged;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.isEnabled = true,
    this.placeholder = '',
    this.suffixText,
    this.prefixText,
    this.keyboardType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) Text(label),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: TextField(
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: onBorder),
              ),
              suffixText: suffixText,
              prefixText: prefixText,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
