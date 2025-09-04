import 'package:flutter/material.dart';
import 'package:mibook/core/designsystem/atoms/colors.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonLoader({
    super.key,
    this.width = 500,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: primary,
      ),
    );
  }
}

class DisplayAsLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const DisplayAsLoader({
    required this.isLoading,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: isLoading,
          child: Opacity(
            opacity: isLoading ? 0 : 1,
            child: child,
          ),
        ),
        Visibility(
          visible: isLoading,
          child: const Positioned.fill(
            child: SkeletonLoader(),
          ),
        ),
      ],
    );
  }
}
