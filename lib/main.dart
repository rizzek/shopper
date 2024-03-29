import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/src/app_state/shopper_app_state.dart';
import 'package:shopper/src/features/settings/presentation/settings/settings_controller.dart';
import 'package:shopper/src/features/settings/presentation/settings/settings_service.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<ShopperAppState>(
        create: (context) {
          final state = ShopperAppState();
          state.init();
          return state;
        },
      ),
      ChangeNotifierProvider(
        create: (context) => settingsController,
      )
    ], child: ShopperApp()),
  );
}
