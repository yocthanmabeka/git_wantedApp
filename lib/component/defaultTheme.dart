import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headlineLarge: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headlineSmall: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );
        
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headlineLarge: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headlineSmall: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          return Colors.black;
        }),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: lightTextTheme,
    );
  }

    static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }
}

/*
TextStyle(
                  color: Colors.blue, // Couleur du texte
                  backgroundColor: Colors.yellow, // Couleur d'arrière-plan
                  fontSize: 24, // Taille de la police
                  fontWeight: FontWeight.bold, // Épaisseur de la police
                  fontStyle: FontStyle.italic, // Italique
                  letterSpacing: 2.0, // Espacement entre les lettres
                  wordSpacing: 5.0, // Espacement entre les mots
                  height: 1.5, // Hauteur des lignes
                  locale: Locale('fr', 'FR'), // Locale (pour les glyphes spécifiques)
                  foreground: Paint()..color = Colors.purple, // Couleur via Paint
                  background: Paint()..color = Colors.orangeAccent, // Fond via Paint
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0,
                      color: Colors.black38, // Ombre
                    ),
                  ],
                  fontFeatures: [FontFeature.enable('smcp')], // Petites majuscules
                  decoration: TextDecoration.underline, // Soulignement
                  decorationColor: Colors.red, // Couleur de la décoration
                  decorationStyle: TextDecorationStyle.dotted, // Style de décoration
                  decorationThickness: 2.0, // Épaisseur de la décoration
                  fontFamily: 'Roboto', // Famille de polices
                  fontFamilyFallback: ['Arial', 'Courier'], // Polices de secours
                  textBaseline: TextBaseline.alphabetic, // Ligne de base
                  overflow: TextOverflow.ellipsis, // Débordement du texte
                  leadingDistribution: TextLeadingDistribution.proportional, // Répartition verticale
                  inherit: false, // N'hérite pas du style parent
                  debugLabel: 'Exemple complet de TextStyle', // Étiquette de débogage
                )TextTheme(
          displayLarge: ,
          // displayMedium: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.orange),
          // displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.w500, color: Colors.yellow),
          // headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.green),
          // headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.blue),
          // headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Colors.indigo),
          // titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.purple),
          // titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.pink),
          // titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.teal),
          // bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
          // bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54),
          // bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
          // labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
          // labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey[800]),
          // labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.grey[600]),

        ThemeData(
        brightness: Brightness.light, // Thème clair
        primaryColor: Colors.blue, // Couleur principale
        scaffoldBackgroundColor: Colors.white, // Couleur d'arrière-plan
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.bold, color: Colors.blue),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue, // Couleur du texte
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.blue),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
          return Colors.black;
        }),
        ),
        iconTheme: IconThemeData(
          color: Colors.blue,
          size: 24,
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey,
          thickness: 1,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      )
        )*/
