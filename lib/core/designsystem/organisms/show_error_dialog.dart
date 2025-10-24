import 'package:flutter/material.dart';

import '../molecules/buttons/primary_button.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String title,
  String content,
  String ctaText,
) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: PrimaryButton(
            title: title,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    ),
  );
}
