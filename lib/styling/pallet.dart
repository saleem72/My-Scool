//

import 'package:flutter/material.dart';

extension Swatch on Color {
  MaterialColor createMaterialColor() {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = red, g = green, b = blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(value, swatch);
  }

  Map<int, Color> _toSwatch() => {
        50: withOpacity(0.1),
        100: withOpacity(0.2),
        200: withOpacity(0.3),
        300: withOpacity(0.4),
        400: withOpacity(0.5),
        500: withOpacity(0.6),
        600: withOpacity(0.7),
        700: withOpacity(0.8),
        800: withOpacity(0.9),
        900: this,
      };

  MaterialColor toMaterialColor() => MaterialColor(
        value,
        _toSwatch(),
      );

  MaterialAccentColor toMaterialAccentColor() => MaterialAccentColor(
        value,
        _toSwatch(),
      );
}

class Pallet {
  Pallet._();

  static const Color pink = Color(0xffDA0177);
  static const Color green = Color(0xff48AB23);
  static const Color orang = Color(0xffE87203);
  static const Color blue = Color(0xff2855AE);
  static const Color lightBlue = Color(0xff7292CF);
  static const Color darkBlue = Color(0xff345FB4);
  static const Color grey = Color(0xffF5F6FC);
  static final Color tableGuids = Colors.blue.shade100;
  static final Color tableBody = Colors.blue.shade50;

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromRGBO(40, 85, 174, 1),
      Color.fromRGBO(114, 146, 207, 1),
    ],
    stops: [0.6, 1],
  );

  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.green,
      secondary: Pallet.green,
      onPrimary: Colors.greenAccent,
      onSecondary: Pallet.green.createMaterialColor().shade300,
      error: Pallet.pink,
      onError: Pallet.pink.createMaterialColor().shade200,
      background: Colors.grey.shade400,
      onBackground: Colors.grey.shade400.createMaterialColor(),
      surface: Colors.grey.shade600,
      onSurface: Colors.grey.createMaterialColor().shade200,
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
          headline3: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          headline6: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          subtitle1: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          bodyText1: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          bodyText2: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            // fontWeight: FontWeight.w200,
          ),
          caption: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
  );

  static final ThemeData someTheme = ThemeData(
    primarySwatch: Colors.blue,
    highlightColor: const Color(0xFFD0996F),
    backgroundColor: const Color(0xFFFDF5EC),
    canvasColor: const Color(0xFFFDF5EC),
    textTheme: TextTheme(
      headline5: ThemeData.light()
          .textTheme
          .headline5!
          .copyWith(color: const Color(0xFFBC764A)),
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[600],
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFBC764A),
      centerTitle: false,
      foregroundColor: Colors.white,
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => const Color(0xFFBC764A)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateColor.resolveWith(
          (states) => const Color(0xFFBC764A),
        ),
        side: MaterialStateBorderSide.resolveWith(
            (states) => const BorderSide(color: Color(0xFFBC764A))),
      ),
    ),
  );
}
