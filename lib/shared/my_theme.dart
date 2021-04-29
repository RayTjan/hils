part of 'shared.dart';

class MyTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      backgroundColor: Color(0xFFffe6ff),
      scaffoldBackgroundColor: Color(0xFFffe6ff),
      primaryColor: Colors.deepPurple[400],
      accentColor: Colors.deepPurple[400],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }

  // a theme that changes based on system time
  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      backgroundColor: Color(0xFFffe6ff),
      scaffoldBackgroundColor: Color(0xFFffe6ff),
      primaryColor: Colors.deepPurple[400],
      accentColor: Colors.deepPurple[400],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }
}
