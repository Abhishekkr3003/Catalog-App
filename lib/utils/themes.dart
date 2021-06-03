import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyThemes {
  static Color creamColor = Color(0xfff5f5f5);
  static Color darkblue = Color(0xff403b58);

  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.grey,
        accentColor: MyThemes.darkblue,
        primaryColor: Colors.black,
        cardColor: Colors.white,
        buttonColor: MyThemes.darkblue,
        canvasColor: MyThemes.creamColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
        indicatorColor: Colors.white,
        backgroundColor: MyThemes.darkblue,

        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: GoogleFonts.poppins(color: Vx.black),
          ),
          color: Colors.white,
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: darkblue),
          actionsIconTheme: IconThemeData(
            color: MyThemes.darkblue,
          ),

          //textTheme: Theme.of(context).textTheme,
        ),
        //primaryTextTheme: GoogleFonts.latoTextTheme()
      );
  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.poppins().fontFamily,
        accentColor: MyThemes.creamColor,
        primaryColor: MyThemes.creamColor,
        cardColor: Colors.black,
        buttonColor: Colors.indigo.shade700,
        canvasColor: Colors.grey.shade900,
        indicatorColor: Colors.white,
        backgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          centerTitle: true,
          elevation: 0,
          textTheme: TextTheme(
            headline6: GoogleFonts.poppins(color: MyThemes.creamColor),
          ),
          iconTheme: IconThemeData(color: creamColor),
          actionsIconTheme: IconThemeData(
            color: MyThemes.creamColor,
          ),
        ),
      );
}
