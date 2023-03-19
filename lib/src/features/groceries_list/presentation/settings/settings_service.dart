
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local storage.
  Future<ThemeMode> themeMode() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final int storedMode = preferences.getInt(modePreference) ?? ThemeMode.system.index;
    return ThemeMode.values[storedMode];
  }

  Future<Locale> preferredLocale() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String locale = preferences.getString(localePreference) ?? Intl.getCurrentLocale();
    return Locale(locale);
  }

  /// Persists the user's preferred ThemeMode to local storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(modePreference, theme.index);
  }

  Future<void> updateLocale(String locale) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(localePreference, locale);
  }

  static String modePreference = "themeMode";

  static String localePreference = "preferredLocale";
}