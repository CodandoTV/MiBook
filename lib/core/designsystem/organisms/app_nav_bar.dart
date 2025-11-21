import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mibook/core/designsystem/modifiers/display_as_loader.dart';

enum AppNavBarTextAlignment { center, start }

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final bool isTitleLoading;
  final Widget? trailing;
  final AppNavBarTextAlignment textAlignment;
  final Function()? onBack;

  const AppNavBar({
    super.key,
    this.onBack,
    required this.titleText,
    this.isTitleLoading = false,
    this.textAlignment = AppNavBarTextAlignment.center,
    this.trailing,
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
                  offset: const Offset(0, -16),
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
              child: _title(),
            ),
            if (trailing != null)
              Transform.translate(
                offset: const Offset(0, -8),
                child: Align(
                  alignment: Alignment.topRight,
                  child: trailing,
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
            _title(),
          ],
        );
    }
  }

  Widget _title() {
    return DisplayAsLoader(
      isLoading: isTitleLoading,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: AutoSizeText(
          titleText,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          minFontSize: 12,
          stepGranularity: 1,
        ),
      ),
    );
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
