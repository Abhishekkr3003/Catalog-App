import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.grey,
      fontFamily: GoogleFonts.lato().fontFamily,
      appBarTheme: AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.black)
          //textTheme: Theme.of(context).textTheme,
          )
      //primaryTextTheme: GoogleFonts.latoTextTheme()
      );
  static ThemeData darkTheme(BuildContext context) =>
      ThemeData(brightness: Brightness.dark);
}
