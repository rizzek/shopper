import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopper/src/features/groceries_list/presentation/home/home_screen.dart';
import 'package:shopper/src/features/settings/presentation/settings/settings_controller.dart';
import 'package:shopper/src/features/settings/presentation/settings/settings_view.dart';


/// The Widget that configures your application.
class ShopperApp extends StatelessWidget {
  ShopperApp({
    Key? key,
  }) : super(key: key);

  final _router = GoRouter(routes: [
    GoRoute(path: '/', name: 'home', builder: (context, state) {
      return const HomeScreen();
    }),
    GoRoute(path: '/settings', name: 'settings', builder: (context, state) {
      return SettingsView(controller: context.read<SettingsController>());
    }),
  ]);


  @override
  Widget build(BuildContext context) {
    print(context.read<SettingsController>().locale);
    print(Intl.getCurrentLocale());
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: context.watch<SettingsController>(),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(

          routeInformationParser: _router.routeInformationParser,

          routerDelegate: _router.routerDelegate,

          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Enable l10n support
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          locale: context.read<SettingsController>().locale,

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: context.read<SettingsController>().themeMode,

        );
      },
    );
  }
}
