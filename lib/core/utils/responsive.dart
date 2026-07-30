import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isMobile => screenWidth < Breakpoints.mobile;
  bool get isTablet =>
      screenWidth >= Breakpoints.mobile && screenWidth < Breakpoints.desktop;
  bool get isDesktop => screenWidth >= Breakpoints.desktop;
  bool get isWide => screenWidth >= Breakpoints.wide;

  double get horizontalPadding {
    if (isWide) return 120;
    if (isDesktop) return 80;
    if (isTablet) return 40;
    return 20;
  }

  double get contentMaxWidth {
    if (isWide) return 1280;
    if (isDesktop) return 1100;
    return screenWidth;
  }

  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop) return desktop ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }
}
