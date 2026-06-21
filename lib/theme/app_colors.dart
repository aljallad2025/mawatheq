import 'package:flutter/material.dart';

/// ألوان هوية مواثيق — مستخرجة من تدرج الشعار
/// (ذهبي/برتقالي علوي → تركواز وسطي → كحلي غامق سفلي)
class AppColors {
  AppColors._();

  // ===== الألوان الأساسية (من تدرج اللوجو) =====
  static const Color gold = Color(0xFFF5A623); // أعلى الشعار
  static const Color goldLight = Color(0xFFFBC761);
  static const Color teal = Color(0xFF2BA8C4); // وسط الشعار
  static const Color tealLight = Color(0xFF6FC8DC);
  static const Color navy = Color(0xFF1E3A5F); // أساسي - نفس لون موقع مواثيق
  static const Color navyDark = Color(0xFF0F1F33); // أسفل الشعار - الأغمق
  static const Color navyDeep = Color(0xFF0A1622);

  // ===== الألوان الوظيفية =====
  static const Color primary = navy;
  static const Color primaryDark = navyDark;
  static const Color secondary = teal;
  static const Color accent = gold;

  static const Color success = Color(0xFF2E9E5B);
  static const Color warning = Color(0xFFE8A33D);
  static const Color danger = Color(0xFFD64545);
  static const Color info = teal;

  // ===== خلفيات =====
  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFEFF3F6);
  static const Color cardBorder = Color(0xFFE3E8EE);

  // داكن (للوضع الليلي مستقبلاً)
  static const Color backgroundDark = Color(0xFF0B1622);
  static const Color surfaceDark = Color(0xFF132438);

  // ===== نصوص =====
  static const Color textPrimary = Color(0xFF132438);
  static const Color textSecondary = Color(0xFF5B6B7B);
  static const Color textMuted = Color(0xFF8C9AA8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ===== تدرجات (Gradients) — مطابقة لتدرج الشعار =====
  static const LinearGradient logoGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gold, teal, navy],
    stops: [0.0, 0.45, 1.0],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [navy, navyDark],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [navyDark, navy, Color(0xFF1A4566)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gold, teal],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [navyDark, navyDeep],
  );

  // ===== ظلال =====
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: navy.withOpacity(0.06),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: navy.withOpacity(0.12),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ];
}
