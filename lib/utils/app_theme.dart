import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  /*static final ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: createMaterialColor(secondaryColor),
    scaffoldBackgroundColor: primaryColor,
    accentColor: secondaryColor,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: primaryColor,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      titleTextStyle: boldTextStyle(size: 20),
    ),
    iconTheme: IconThemeData(color: Colors.white, size: 24),
    dividerColor: Colors.white54,
    cardColor: cardColor,
    dialogBackgroundColor: cardColor,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(secondaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(secondaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: cardColor,
      contentTextStyle: primaryTextStyle(color: Colors.red),
      titleTextStyle: boldTextStyle(),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
  );*/

  static final ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: createMaterialColor(primaryColor),
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    scaffoldBackgroundColor: primaryColor,
    textTheme: GoogleFonts.montserratTextTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: primaryColor),
    iconTheme: IconThemeData(color: Colors.white),
    dialogBackgroundColor: primaryColor,
    unselectedWidgetColor: Colors.white,
    dividerColor: Colors.white54,
    cardColor: cardColor,
    canvasColor: primaryColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: primaryColor,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      titleTextStyle: boldTextStyle(size: 20),
    ),
    scrollbarTheme: ScrollbarThemeData(thumbColor: MaterialStateProperty.all(Colors.white), radius: Radius.circular(8)),
    dialogTheme: DialogTheme(
      backgroundColor: cardColor,
      contentTextStyle: primaryTextStyle(color: Colors.red),
      titleTextStyle: boldTextStyle(),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(secondaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(secondaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: createMaterialColor(lightModePrimaryColor),
    primaryColor: lightModePrimaryColor,
    scaffoldBackgroundColor: lightModePrimaryColor,
    accentColor: secondaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: lightModePrimaryColor),
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: GoogleFonts.montserratTextTheme(),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    dividerColor: viewLineColor,
    cardColor: lightModeCardColor,
    canvasColor: lightModeCardColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: lightModePrimaryColor,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
      titleTextStyle: boldTextStyle(size: 20),
    ),
    scrollbarTheme: ScrollbarThemeData(thumbColor: MaterialStateProperty.all(Colors.black), radius: Radius.circular(8)),
    dialogTheme: DialogTheme(
      backgroundColor: cardColor,
      contentTextStyle: primaryTextStyle(color: Colors.red),
      titleTextStyle: boldTextStyle(),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(secondaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(secondaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
