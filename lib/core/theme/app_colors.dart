import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const background = Color(0xFFFAFBFC);
  static const card = Color(0xFFFFFFFF);
  static const primary = Color(0xFF2563EB);
  static const secondary = Color(0xFF38BDF8);
  static const accent = Color(0xFF8B5CF6);
  static const highlight = Color(0xFF06B6D4);
  static const success = Color(0xFF10B981);
  static const text = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const textMuted = Color(0xFF9CA3AF);
  static const border = Color(0xFFE5E7EB);
  static const glass = Color(0xCCFFFFFF);
  static const glassBorder = Color(0x33FFFFFF);

  static const gold = Color(0xFFF59E0B);
  static const goldLight = Color(0xFFFBBF24);
  static const silver = Color(0xFF94A3B8);

  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary, accent],
  );

  static const softGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFEFF6FF),
      Color(0xFFF0F9FF),
      Color(0xFFFAF5FF),
    ],
  );

  static const auroraGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x402563EB),
      Color(0x3038BDF8),
      Color(0x308B5CF6),
      Color(0x2006B6D4),
    ],
  );

  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.08),
      blurRadius: 40,
      offset: const Offset(0, 16),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: const Color(0xFF0F172A).withValues(alpha: 0.06),
      blurRadius: 32,
      offset: const Offset(0, 12),
      spreadRadius: -4,
    ),
  ];

  static List<BoxShadow> glowShadow(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 48,
          spreadRadius: 0,
        ),
      ];
}
