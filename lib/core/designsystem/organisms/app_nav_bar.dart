import 'package:flutter/material.dart';

enum AppNavBarTextAlignment { center, start }

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final AppNavBarTextAlignment textAlignment;
  final Function()? onBack;

  const AppNavBar({
    super.key,
    this.onBack,
    required this.titleText,
    this.textAlignment = AppNavBarTextAlignment.center,
  });

  Widget _layout() {
    switch (textAlignment) {
      case AppNavBarTextAlignment.center:
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            if (onBack != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Transform.translate(
                  offset: const Offset(0, -8),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: onBack,
                      icon: const Icon(Icons.chevron_left, color: Colors.black),
                    ),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.center,
              child: Text(
                titleText,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        );

      case AppNavBarTextAlignment.start:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (onBack != null)
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.chevron_left, color: Colors.black),
              ),
            Text(
              titleText,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.0,
      title: _layout(), // ✅ no wrapping Row
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
