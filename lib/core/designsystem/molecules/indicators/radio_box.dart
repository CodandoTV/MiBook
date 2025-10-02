import 'package:flutter/material.dart';
import 'package:mibook/core/designsystem/atoms/colors.dart';

class RadioBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const RadioBox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Checkbox(
            fillColor: WidgetStateProperty.all(primary),
            value: value,
            onChanged: onChanged,
          ),
          Text(label),
        ],
      ),
    );
  }
}
