import 'package:vokdams/import_packages.dart';

class CustomTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: const AppBarTheme(color: white),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: white),
    colorScheme: const ColorScheme.light(),
    primaryColor: white,
    iconTheme: const IconThemeData(color: black),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: const AppBarTheme(color: darkAppbarColor),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: darkDeepBackground),
    colorScheme: const ColorScheme.dark(),
    primaryColor: darkDeepBackground,
    iconTheme: const IconThemeData(color: white),
  );
}
