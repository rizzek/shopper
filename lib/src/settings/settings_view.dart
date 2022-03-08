import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.appearance),
              trailing: DropdownButton<ThemeMode>(
                // Read the selected themeMode from the controller
                value: controller.themeMode,
                // Call the updateThemeMode method any time the user selects a theme.
                onChanged: controller.updateThemeMode,
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text(AppLocalizations.of(context)!.systemTheme),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(AppLocalizations.of(context)!.lightTheme),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(AppLocalizations.of(context)!.darkTheme),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.language),
              trailing: DropdownButton<String>(
                value: controller.locale.languageCode.substring(0, 2),
                onChanged: controller.updatePreferredLocale,
                items: [
                  DropdownMenuItem(
                      value: "de", child: Text(AppLocalizations.of(context)!.language_de)),
                  DropdownMenuItem(
                      value: "en", child: Text(AppLocalizations.of(context)!.language_en))
                ],
              ),
            ),
          ]).toList(),
        ),
      ),
    );
  }

}
