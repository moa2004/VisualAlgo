import 'package:flutter/material.dart';

enum LayoutSize { compact, medium, expanded }

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key, required this.builder});

  final Widget Function(BuildContext context, LayoutSize size) builder;

  static LayoutSize getLayoutSize(double width) {
    if (width >= 1200) return LayoutSize.expanded;
    if (width >= 768) return LayoutSize.medium;
    return LayoutSize.compact;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = getLayoutSize(constraints.maxWidth);
        return builder(context, size);
      },
    );
  }
}
