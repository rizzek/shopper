import 'dart:io';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/src/app_state/remote_credential_store.dart';
import 'package:shopper/src/app_state/shopper_app_state.dart';
import 'package:shopper/src/settings/sync_selection.dart';

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
    final syncSettings = context.read<ShopperAppState>().getSyncSettings();
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
                      value: "de",
                      child: Text(AppLocalizations.of(context)!.language_de)),
                  DropdownMenuItem(
                      value: "en",
                      child: Text(AppLocalizations.of(context)!.language_en))
                ],
              ),
            ),
            FutureBuilder(
                future: syncSettings,
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    final StorageSettings syncSettingsData = snapShot.data as StorageSettings;

                    final String buttonLabel;
                    final String subtitle;

                    switch (syncSettingsData.store) {

                      case RemoteStore.webdav:
                        buttonLabel = AppLocalizations.of(context)!.syncButton_change;
                        subtitle = AppLocalizations.of(context)!.syncService_webdav;
                        break;
                      case RemoteStore.nextcloud:
                        buttonLabel = AppLocalizations.of(context)!.syncButton_change;
                        subtitle = AppLocalizations.of(context)!.syncService_nextcloud;
                        break;
                      case RemoteStore.none:
                        buttonLabel = AppLocalizations.of(context)!.syncButton_setup;
                        subtitle = AppLocalizations.of(context)!.syncService_none;
                        break;
                    }


                    return ListTile(
                      title: Text(AppLocalizations.of(context)!.sync),
                      subtitle: Text(subtitle),
                      trailing: ElevatedButton(
                        child: Text(buttonLabel),
                        onPressed: () {
                          if (Platform.isAndroid || Platform.isIOS) {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SyncSelectionDialog(storedSettings: syncSettingsData,);
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                      children: [SyncSelectionDialog(storedSettings: syncSettingsData,)]);
                                });
                          }
                        },
                      ),
                    );
                  } else {
                    return const ListTile(
                      title: const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator()),
                    );
                  }
                }),
          ]).toList(),
        ),
      ),
    );
  }
}
