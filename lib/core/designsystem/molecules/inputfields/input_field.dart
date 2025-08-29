import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isEnabled;
  final String placeholder;
  final Function(String) onChanged;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.isEnabled = true,
    this.placeholder = '',
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) Text(label),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
