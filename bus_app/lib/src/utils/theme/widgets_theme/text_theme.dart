import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat(color: Colors.black87),
    titleMedium: GoogleFonts.poppins(color: Colors.deepPurple, fontSize: 24),
    bodyLarge: GoogleFonts.roboto(color: Colors.black87),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat(color: Colors.white70),
    titleMedium: GoogleFonts.poppins(color: Colors.white60, fontSize: 24),
    bodyLarge: GoogleFonts.roboto(color: Colors.white70),
  );
}
