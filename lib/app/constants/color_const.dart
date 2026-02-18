import 'package:flutter/material.dart';

abstract class ColorConst {
  // Light Theme
  static const Color kPrimary = Color(0xFF1565C0);
  static const Color kSecondary = Color(0xFF1976D2);

  // Dark Theme
  static const Color kPrimaryDark = Color(0xFF90CAF9);
  static const Color kSecondaryDark = Color(0xFF64B5F6);
  static const Color kSurfaceDark = Color(0xFF1E1E1E);
  static const Color kBackgroundDark = Color(0xFF121212);
  static const Color kSurfaceDark2 = Color(0xFF2C2C2C);

  // Avatar Palette
  static const Color kAvatarRed = Color(0xFFE57373);
  static const Color kAvatarPurple = Color(0xFFBA68C8);
  static const Color kAvatarBlue = Color(0xFF64B5F6);
  static const Color kAvatarLightBlue = Color(0xFF4FC3F7);
  static const Color kAvatarCyan = Color(0xFF4DD0E1);
  static const Color kAvatarTeal = Color(0xFF4DB6AC);
  static const Color kAvatarGreen = Color(0xFF81C784);
  static const Color kAvatarLightGreen = Color(0xFFAED581);
  static const Color kAvatarAmber = Color(0xFFFFD54F);
  static const Color kAvatarOrange = Color(0xFFFFB74D);
  static const Color kAvatarDeepOrange = Color(0xFFFF8A65);
  static const Color kAvatarBrown = Color(0xFFA1887F);
  static const Color kAvatarBlueGrey = Color(0xFF90A4AE);

  // Fallback
  static const Color kAvatarFallback = Color(0xFF9E9E9E);

  static Color getAvatarColor(String text) {
    if (text.isEmpty) {
      return kAvatarFallback;
    }

    // Generate hash from text
    int hash = 0;
    for (int i = 0; i < text.length; i++) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }

    // Predefined pleasant colors for avatars
    const List<Color> colors = [
      kAvatarRed,
      kAvatarPurple,
      kAvatarBlue,
      kAvatarLightBlue,
      kAvatarCyan,
      kAvatarTeal,
      kAvatarGreen,
      kAvatarLightGreen,
      kAvatarAmber,
      kAvatarOrange,
      kAvatarDeepOrange,
      kAvatarBrown,
      kAvatarBlueGrey,
    ];

    // Use hash to select color
    final index = hash.abs() % colors.length;
    return colors[index];
  }

  static Color getAvatarColorFromContact(String name, String phone) {
    // Combine name and phone for more unique hash
    final combined = '$name$phone';
    return getAvatarColor(combined);
  }
}
