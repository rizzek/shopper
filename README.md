# shopper

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)
.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on
mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to include with your
application.

The `assets/images` directory
contains [resolution-aware images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware)
.

## Localization

This project generates localized messages based on arb files found in the `lib/src/localization`
directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

## Building for Web

Shopper has been build for users to have the choice to be independent of "Big Tech". This is of
course pointless when the app loads additional content from CDNs like GStatic or unpckg.com.
Unfortunately this is the case when building Shopper web with the default settings.

Building Flutter web apps with "canvaskit" might bring some advantages but with the cost of
additional assets being loaded from Google Fonts and unpckg.com.

You can simply prevent this by choosing "html" as the default renderer:

    flutter build web --web-renderer html
    

Another way of at least getting rid of the unpckg.com resource call is to specify a custom location for CanvasKit. Fortunately, the build output of Flutter web already contains a copy of CanvasKit. You can specify it like this:

    flutter build web --dart-define=FLUTTER_WEB_CANVASKIT_URL=/canvaskit/

For more information about web renderers for Flutter please
see [Web renderers](https://docs.flutter.dev/development/tools/web-renderers).
