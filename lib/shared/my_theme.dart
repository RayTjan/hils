part of 'shared.dart';

class MyTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
      backgroundColor: Color(0xffD7F9DB),
      scaffoldBackgroundColor: Color(0xff70b84d),
      primaryColor: Colors.green[800],
      accentColor: Colors.green[600],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.jua().fontFamily,
    );
  }

  // a theme that changes based on system time
  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
      backgroundColor: Color(0xffD7F9DB),
      scaffoldBackgroundColor: Color(0xffD7F9DB),
      primaryColor: Colors.green[800],
      accentColor: Colors.green[600],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.jua().fontFamily,
    );
  }
}
